import 'package:emergency_one/core/components/circle_button.dart';
import 'package:emergency_one/core/components/custom_appbar.dart';
import 'package:emergency_one/core/components/primary_button.dart';
import 'package:emergency_one/core/constants/app_const.dart';
import 'package:emergency_one/core/routes/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../view_models/auth_view_model.dart';

class LoginView extends StatelessWidget {
  const LoginView({super.key});

  @override
  Widget build(BuildContext context) {
    final TextEditingController emailController = TextEditingController();
    final TextEditingController passwordController = TextEditingController();

    final authVM = Get.put(AuthViewModel());
    final isLoading = false.obs;
    RxString errorMessage = "".obs;
    void handleLogin() async {
      isLoading.value = true;
      final error = await authVM.login(
        emailController.text.trim(),
        passwordController.text,
      );
      isLoading.value = false;
      if (error != null) {
        errorMessage.value = error;
        Get.snackbar(
          "Login Failed",
          error,
          snackPosition: SnackPosition.BOTTOM,
        );
      } else {
        // Get.offAllNamed(homeView);
        Get.snackbar(
          "Login Success",
          "You have successfully logged in",
          snackPosition: SnackPosition.BOTTOM,
        );
      }
    }

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.primary,
        title: const Text("Auth Page"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(PAGE_PADDING),
        child: Obx(
          () => Stack(
            children: [
              AbsorbPointer(
                absorbing: isLoading.value,
                child: SingleChildScrollView(
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
                        mainAxisAlignment: MainAxisAlignment.center,
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
                        onChanged: (value) {
                          errorMessage.value = "";
                        },
                        controller: emailController,
                        decoration: const InputDecoration(
                          labelText: "Email",
                          prefixIcon: Icon(Icons.alternate_email),
                        ),
                      ),
                      const SizedBox(height: 20),
                      TextFormField(
                         onChanged: (value) {
                          errorMessage.value = "";
                        },
                        controller: passwordController,
                        obscureText: true,
                        decoration: const InputDecoration(
                          labelText: "Password",
                          prefixIcon: Icon(Icons.password),
                        ),
                      ),
                      const SizedBox(height: 20),
                     Obx(()=>errorMessage.value.isNotEmpty? Container(
                        padding: const EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          color: Theme.of(context).colorScheme.primary.withValues(alpha: 0.4),
                          borderRadius: BorderRadius.circular(3),
                        ),
                        child: Row(
                          children: [
                            Icon(
                              Icons.error_outline,
                              color: Theme.of(context).colorScheme.primary,
                            ),
                            const SizedBox(width: 10),
                            Text(errorMessage.value.toString(),style: TextStyle(
                            color: Theme.of(context).colorScheme.primary,
                            fontWeight: FontWeight.bold,
                          ),)],
                        ),
                      ):SizedBox.shrink()),
                      const SizedBox(height: 20),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Obx(
                            () =>
                                isLoading.value
                                    ? CircularProgressIndicator()
                                    : PrimaryButton(
                                      onPressed: handleLogin,
                                      text: "L O G I N ",
                                    ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 50),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(height: 2, width: 100, color: Colors.grey),
                          const SizedBox(width: 10),
                          const Text("OR"),
                          const SizedBox(width: 10),
                          Container(height: 2, width: 100, color: Colors.grey),
                        ],
                      ),
                      const SizedBox(height: 10),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "Don't have an account?",
                            style: Theme.of(context).textTheme.bodyLarge,
                          ),
                          const SizedBox(width: 10),
                          InkWell(
                            onTap: () {
                              Get.toNamed(registerView);
                            },
                            child: Text(
                              "Create account",
                              style: Theme.of(
                                context,
                              ).textTheme.bodyLarge?.copyWith(
                                color: Theme.of(context).colorScheme.primary,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
