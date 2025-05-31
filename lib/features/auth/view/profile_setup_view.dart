import 'package:emergency_one/core/components/primary_button.dart';
import 'package:emergency_one/core/constants/app_const.dart';
import 'package:emergency_one/core/routes/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../view_models/auth_view_model.dart';

class ProfileSetupView extends StatelessWidget {
  const ProfileSetupView({super.key});

  @override
  Widget build(BuildContext context) {
    final TextEditingController bloodGroupController = TextEditingController();
    final TextEditingController contactNumber = TextEditingController();
    final TextEditingController locationController = TextEditingController();

    final authVM = Get.put(AuthViewModel());
    final isLoading = false.obs;
    final RxString errorMessage = "".obs;

    void handleRegister() async {
      isLoading.value = true;
      final error = await authVM.updateUserData(
       address: locationController.text,  
       bloodGroup: bloodGroupController.text,
       phone: contactNumber.text,
      );
      isLoading.value = false;
      if (error != null) {
        errorMessage.value = error;
        Get.snackbar("Profile Update erro", error, snackPosition: SnackPosition.BOTTOM);
      } else {
        Get.offAllNamed(loginView);
      }
    }

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.primary,
        title: const Text("Profile setup"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(PAGE_PADDING),
        child: Obx(() => Stack(
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
                          "S E T U P - P R O F I L E",
                          style: TextStyle(
                            fontSize: 25,
                            fontWeight: FontWeight.bold,
                            color: Theme.of(context).colorScheme.primary,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),
                    Row(
                      children: [
                        Container(
                          padding: const EdgeInsets.all(5),
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: Theme.of(context).colorScheme.primary,
                              width: 1,
                            ),
                            color: Theme.of(context).colorScheme.primary.withValues(alpha: 0.2),
                            borderRadius: BorderRadius.circular(3),
                          ),
                          child: Text("Step 2 of 2",style: TextStyle(
                            color: Theme.of(context).colorScheme.primary,
                            fontWeight: FontWeight.bold,
                          ),),
                        ),
                      ],
                    ), const SizedBox(height: 10),
                    TextFormField(
                      onChanged: (_) => errorMessage.value = "",
                      controller: bloodGroupController,
                      decoration: const InputDecoration(
                        labelText: "Blood Group",
                        prefixIcon: Icon(Icons.water_drop_sharp),
                      ),
                    ),
                    const SizedBox(height: 20),
                    TextFormField(
                      onChanged: (_) => errorMessage.value = "",
                      controller: contactNumber,
                      decoration: const InputDecoration(
                        labelText: "Emergency Number",
                        prefixIcon: Icon(Icons.phone),
                      ),
                    ),
                    const SizedBox(height: 20),
                    TextFormField(
                      onChanged: (_) => errorMessage.value = "",
                      controller: locationController,
                      decoration: const InputDecoration(
                        labelText: "Location",
                        prefixIcon: Icon(Icons.pin_drop_rounded),
                      ),
                    ),
                    const SizedBox(height: 20),
                    Obx(() => errorMessage.value.isNotEmpty
                        ? Container(
                            padding: const EdgeInsets.all(10),
                            decoration: BoxDecoration(
                              color: Theme.of(context).colorScheme.primary.withAlpha(40),
                              borderRadius: BorderRadius.circular(3),
                            ),
                            child: Row(
                              children: [
                                Icon(Icons.error_outline,
                                    color: Theme.of(context).colorScheme.primary),
                                const SizedBox(width: 10),
                                Expanded(
                                  child: Text(
                                    errorMessage.value,
                                    style: TextStyle(
                                      color: Theme.of(context).colorScheme.primary,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                )
                              ],
                            ),
                          )
                        : const SizedBox.shrink()),
                    const SizedBox(height: 20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Obx(() => isLoading.value
                            ? const CircularProgressIndicator()
                            : PrimaryButton(
                                onPressed: handleRegister,
                                text: "S A V E",
                              )),
                      ],
                    ),
              
                  ],
                ),
              ),
            ),
          ],
        )),
      ),
    );
  }
}
