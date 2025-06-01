import 'package:emergency_one/core/routes/app_routes.dart';
import 'package:emergency_one/features/auth/controller/auth_controller.dart';
import 'package:emergency_one/features/auth/model/user_mode.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../../../core/constants/app_const.dart';

class UserProfile extends StatelessWidget {
  UserProfile({super.key});

  final AuthController authController = Get.find<AuthController>();
  final FirebaseAuth _auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    final UserModel? user = authController.userDetails.value;

    return Scaffold(
      appBar: AppBar(
        title: const Text("User Profile"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(PAGE_PADDING),
        child: user == null
            ? const Center(child: CircularProgressIndicator())
            : Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 20),
                  Text("Name: ${user.name}", style: Theme.of(context).textTheme.titleMedium),
                  const SizedBox(height: 10),
                  Text("Email: ${user.email}", style: Theme.of(context).textTheme.bodyLarge),
                  const SizedBox(height: 10),
                  if (user.phone != null) Text("Phone: ${user.phone}"),
                  if (user.bloodGroup != null) Text("Blood Group: ${user.bloodGroup}"),
                  if (user.address != null) Text("Address: ${user.address}"),
                  const Spacer(),
                  Center(
                    child: ElevatedButton.icon(
                      onPressed: () async {
                        await _auth.signOut();
                        Get.offAllNamed(loginView);
                      },
                      icon: const Icon(Icons.logout),
                      label: const Text("Logout"),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.red,
                        foregroundColor: Colors.white,
                      ),
                    ),
                  ),
                ],
              ),
      ),
    );
  }
}
