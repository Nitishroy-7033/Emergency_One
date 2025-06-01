import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:emergency_one/features/auth/model/emergency_contact.dart';
import 'package:emergency_one/features/auth/model/health_info.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

import '../controller/auth_controller.dart';
import '../model/user_mode.dart';

class AuthViewModel extends GetxController {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _db = FirebaseFirestore.instance;
  final AuthController _authController = Get.put(AuthController());

  @override
  void onInit() {
    super.onInit();
    fetchUserData();
  }

  /// LOGIN
  Future<String?> login(String email, String password) async {
    try {
      await _auth.signInWithEmailAndPassword(email: email, password: password);
      await fetchUserData();
      return null; // success
    } on FirebaseAuthException catch (e) {
      return _handleAuthError(e);
    } catch (e) {
      return "Login failed. Please try again.";
    }
  }

  /// REGISTER
  Future<String?> register(String email, String password, String name) async {
    try {
      await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      final uid = _auth.currentUser!.uid;

      final newUser = UserModel(
        id: uid,
        name: name,
        email: email,
        passwordHash: password,
        role: "public",
        coordinates: [0.0, 0.0],
        isVerified: false,
        createdAt: DateTime.now(),
        updatedAt: DateTime.now(),
      );

      await _db.collection("users").doc(uid).set(newUser.toJson());
      _authController.setUserDetails(newUser);
      return null; // success
    } on FirebaseAuthException catch (e) {
      return _handleAuthError(e);
    } catch (e) {
      return "Registration failed. Please try again.";
    }
  }

  /// FETCH USER DATA
  Future<void> fetchUserData() async {
    final uid = _auth.currentUser?.uid;
    if (uid == null) return;

    final doc = await _db.collection("users").doc(uid).get();
    if (doc.exists) {
      final user = UserModel.fromJson(doc.data()!, doc.id);
      _authController.setUserDetails(user);
    }
  }

  /// UPDATE USER DETAILS (e.g., after KYC, health info)
  Future<String?> updateUserData({
    String? phone,
    String? bloodGroup,
    String? address,
  }) async {
    try {
      final uid = _auth.currentUser?.uid;
      if (uid == null) return "User not logged in.";

      final updateData = {
        if (phone != null) 'phone': phone,
        if (bloodGroup != null) 'bloodGroup': bloodGroup,
        if (address != null) 'address': address,
        'updatedAt': Timestamp.now(),
      };

      await _db.collection("users").doc(uid).update(updateData);

      // Refresh local user
      await fetchUserData();
      return null;
    } catch (e) {
      return "Failed to update user data.";
    }
  }

  /// HANDLE FIREBASE AUTH ERRORS
  String _handleAuthError(FirebaseAuthException e) {
    switch (e.code) {
      case 'invalid-email':
        return 'The email address is not valid.';
      case 'user-disabled':
        return 'This user has been disabled.';
      case 'user-not-found':
        return 'No user found with this email.';
      case 'wrong-password':
        return 'Incorrect password.';
      case 'email-already-in-use':
        return 'This email is already in use.';
      case 'weak-password':
        return 'The password is too weak.';
      case 'operation-not-allowed':
        return 'Operation not allowed. Please contact support.';
      default:
        return 'Authentication error: ${e.message}';
    }
  }
}
