import 'package:emergency_one/core/components/circle_button.dart';
import 'package:emergency_one/core/components/custom_appbar.dart';
import 'package:emergency_one/core/components/primary_button.dart';
import 'package:emergency_one/core/constants/app_const.dart';
import 'package:emergency_one/core/routes/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LoginView extends StatelessWidget {
  const LoginView({super.key});

  @override
  Widget build(BuildContext context) {
    TextEditingController emailController = TextEditingController();
    TextEditingController passwordController = TextEditingController();
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.primary,
        title: const Text("Auth Page"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(PAGE_PADDING),
        child: Column(
          children: [
            Row(
              children: [
                Text(
                  "Welcome to Emergency One",
                  style: Theme.of(context).textTheme.titleLarge,
                ),
              ],
            ),
            const SizedBox(height: 30),
             Row(
              mainAxisAlignment: MainAxisAlignment.center, // Center the childr,
              children: [
                Text(
                  "L O G I N ",
                  style: TextStyle(
                    fontSize: 25,
                    fontWeight: FontWeight.bold,
                    color: Theme.of(context).colorScheme.primary,
                  ),
                ),
              ],
            ),
             const SizedBox(height: 10),
            TextFormField(
              controller:
                  emailController, // Add this line to bind the controller t,
              decoration: InputDecoration(
                labelText: "Email",
                prefixIcon: Icon(Icons.alternate_email),
              ),
            ),
            SizedBox(height: 20),
            TextFormField(
              controller: passwordController,
              decoration: InputDecoration(
                labelText: "Password",
                prefixIcon: Icon(Icons.password),
              ),
            ),
            SizedBox(height: 40),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [PrimaryButton(onPressed: () {}, text: "LOGIN")],
            ),
            SizedBox(height: 50),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(height: 2, width: 100, color: Colors.grey),
                SizedBox(width: 10),
                Text("OR"),
                SizedBox(width: 10),
                Container(height: 2, width: 100, color: Colors.grey),
              ],
            ),
            SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Don't have an account?",
                  style: Theme.of(context).textTheme.bodyLarge,
                ),
                SizedBox(width: 10),
                InkWell(
                  onTap: () {
                    Get.toNamed(registerView);
                  },
                  child: Text(
                    "Create account",
                    style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                      color: Theme.of(context).colorScheme.primary,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
