import 'package:emergency_one/core/routes/app_routes.dart';
import 'package:emergency_one/features/auth/controller/auth_controller.dart';
import 'package:emergency_one/features/auth/model/user_mode.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../../../core/constants/app_const.dart';

class UserProfile extends StatefulWidget {
  UserProfile({super.key});

  @override
  State<UserProfile> createState() => _UserProfileState();
}

class _UserProfileState extends State<UserProfile> {
  final AuthController authController = Get.find<AuthController>();
  final FirebaseAuth _auth = FirebaseAuth.instance;

  late TextEditingController nameController;
  late TextEditingController emailController;
  late TextEditingController phoneController;
  late TextEditingController genderController;

  @override
  void initState() {
    super.initState();
    final user = authController.userDetails.value;
    nameController = TextEditingController(text: user?.name ?? '');
    emailController = TextEditingController(text: user?.email ?? '');
    phoneController = TextEditingController(text: user?.phone ?? '');
    genderController = TextEditingController(text: '');
  }

  @override
  void dispose() {
    nameController.dispose();
    emailController.dispose();
    phoneController.dispose();
    genderController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final user = authController.userDetails.value;
    return Scaffold(
      appBar: AppBar(
        title: const Text("Edit profile"),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
      body: user == null
          ? const Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(PAGE_PADDING),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const SizedBox(height: 20),
                    Center(
                      child: CircleAvatar(
                        radius: 48,
                        backgroundColor: Colors.deepPurple.shade100,
                        child: const Icon(Icons.person, size: 48, color: Colors.deepPurple),
                      ),
                    ),
                    const SizedBox(height: 8),
                    const SizedBox(height: 16),
                    Container(
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: Colors.grey[100],
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text('PROFILE', style: TextStyle(fontWeight: FontWeight.bold)),
                          const SizedBox(height: 12),
                          TextField(
                            controller: nameController,
                            decoration: const InputDecoration(labelText: 'Name'),
                          ),
                          TextField(
                            controller: emailController,
                            decoration: const InputDecoration(labelText: 'Email'),
                          ),
                          TextField(
                            controller: phoneController,
                            decoration: const InputDecoration(labelText: 'Phone number'),
                          ),
                          TextField(
                            controller: genderController,
                            decoration: const InputDecoration(labelText: 'Gender'),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 120),
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: () {
                          // Save changes logic here
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.deepPurple,
                          foregroundColor: Colors.white,
                          padding: const EdgeInsets.symmetric(vertical: 16),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                        child: const Text('Save changes'),
                      ),
                    ),
                    const SizedBox(height: 12),
                    SizedBox(
                      width: double.infinity,
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
                          padding: const EdgeInsets.symmetric(vertical: 16),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 120),  
                    const Text('Made with ❤️ by Flutetrhero', style: TextStyle(fontWeight: FontWeight.bold,color: Colors.grey)),
                  ],
                ),
              ),
            ),
    );
  }
}
