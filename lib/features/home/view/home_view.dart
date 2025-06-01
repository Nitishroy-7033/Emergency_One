import 'package:emergency_one/core/components/circle_button.dart';
import 'package:emergency_one/core/constants/app_const.dart';
import 'package:emergency_one/core/constants/assets_path.dart';
import 'package:emergency_one/core/routes/app_routes.dart';
import 'package:emergency_one/demo.dart';
import 'package:emergency_one/features/auth/controller/auth_controller.dart';
import 'package:emergency_one/features/home/model/category_card.dart';
import 'package:emergency_one/features/home/model/sos_button.dart';
import 'package:emergency_one/features/service_request/controller/service_request.dart'
    show ServiceRequestController;
import 'package:emergency_one/features/service_request/view/service_request_view.dart';
import 'package:emergency_one/features/user/user_profile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:google_maps_widget/google_maps_widget.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    RxBool emergencyEnabled = false.obs;
    final serviceRequestController = Get.put(ServiceRequestController());
    final authController = Get.put(AuthController());
    return Scaffold(
      body: RefreshIndicator(
        onRefresh: () async {
          await serviceRequestController.getMyServiceRequests();
        },
        child: Padding(
          padding: const EdgeInsets.all(PAGE_PADDING),
          child: ListView(
            children: [
              Container(
                padding: EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.primary,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween ,
                  children: [
                    CircleButton(
                      icon: Icons.menu,
                      onPressed: () {
                        // serviceRequestController.getMyServiceRequests();
                      },
                    ),
                    Obx(
                      () => Text(
                        authController.userDetails.value?.name ??
                            "Nitish Kumar",
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Theme.of(context).colorScheme.surface,
                        ),
                      ),
                    ),
                    CircleButton(
                      icon: Icons.person,
                      onPressed: () {
                        // serviceRequestController.getMyServiceRequests();
                        Get.to(UserProfile());
                      },
                    ),
                  ],
                ),
              ),
              SizedBox(height: 20), 
              Container(
                // height: 300,
                decoration: BoxDecoration(
                  color: Theme.of(
                    context,
                  ).colorScheme.primary.withValues(alpha: 0.2),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Expanded(
                      child: Column(
                        children: [
                          Container(
                            padding: EdgeInsets.symmetric(
                              vertical: 5,
                              horizontal: 10,
                            ),
                            decoration: BoxDecoration(
                              color:
                                  Theme.of(
                                    context,
                                  ).colorScheme.primaryContainer,
                              borderRadius: BorderRadius.only(
                                bottomLeft: Radius.circular(10),
                                bottomRight: Radius.circular(10),
                              ),
                            ),
                            child: Text(
                              "Emergency",
                              style: TextStyle(
                                fontSize: 20,
                                // fontWeight: FontWeight.bold,
                                color: Theme.of(context).colorScheme.primary,
                              ),
                            ),
                          ),
                          SosButton(
                            onPressed: () {
                              Get.to(ServiceRequestView(serviceType: "Police"));
                              emergencyEnabled.value = true;
                            },
                          ),
                          Obx(
                            () =>
                                emergencyEnabled.value
                                    ? LinearProgressIndicator()
                                    : SizedBox.shrink(),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Obx(
                    () =>
                        emergencyEnabled.value
                            ? ElevatedButton(
                              onPressed: () {
                                emergencyEnabled.value = false;
                              },
                              child: Text("Cancel SOS"),
                            )
                            : SizedBox.shrink(),
                  ),
                ],
              ),
              SizedBox(height: 10),
              Row(
                children: [
                  Text("OTHERS", style: Theme.of(context).textTheme.labelLarge),
                ],
              ),
              SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  CategoryCard(
                    iconPath: IconAssets.ambulance,
                    title: "Ambulance",
                    onTap: () {
                      Get.to(ServiceRequestView(serviceType: "Ambulance"));
                    },
                  ),
                  CategoryCard(
                    iconPath: IconAssets.hospital,
                    title: "Hospital",
                    onTap: () {
                      Get.to(ServiceRequestView(serviceType: "Hospital"));
                    },
                  ),
                  CategoryCard(
                    iconPath: IconAssets.blood,
                    title: "Blood",
                    onTap: () {
                      Get.to(ServiceRequestView(serviceType: "Blood"));
                    },
                  ),
                  CategoryCard(
                    iconPath: IconAssets.fire,
                    title: "Desater",
                    onTap: () {
                      Get.to(ServiceRequestView(serviceType: "Fire"));
                    },
                  ),
                ],
              ),
              SizedBox(height: 30),
              Row(
                children: [
                  Text(
                    "My Service Requests",
                    style: Theme.of(context).textTheme.labelLarge,
                  ),
                ],
              ),
              SizedBox(height: 10),
              SizedBox(
                height: 400,
                child: Obx(
                  () => ListView.builder(
                    itemCount:
                        serviceRequestController.myServiceRequests.value.length,
                    itemBuilder: (context, index) {
                      return Container(
                        margin: EdgeInsets.only(bottom: 10),
                        child: ListTile(
                          tileColor:
                              Theme.of(context).colorScheme.primaryContainer,
                          onTap: () {
                            Get.to(
                              ServiceRequestView(
                                serviceData:
                                    serviceRequestController
                                        .myServiceRequests
                                        .value[index],
                              ),
                            );
                          },
                          leading: Container(
                            decoration: BoxDecoration(
                              color: Theme.of(context).colorScheme.primary,
                              shape: BoxShape.circle,
                            ),
                            child: SvgPicture.asset(
                              serviceRequestController
                                          .myServiceRequests
                                          .value[index]
                                          .serviceType ==
                                      "Police"
                                  ? IconAssets.polic
                                  : serviceRequestController
                                          .myServiceRequests
                                          .value[index]
                                          .serviceType ==
                                      "Ambulance"
                                  ? IconAssets.ambulance
                                  : serviceRequestController
                                          .myServiceRequests
                                          .value[index]
                                          .serviceType ==
                                      "Fire"
                                  ? IconAssets.fire
                                  : IconAssets.hospital,
                              width: 30,
                              height: 30,
                            ),
                          ),
                          title: Text(
                            serviceRequestController
                                    .myServiceRequests
                                    .value[index]
                                    .serviceType ??
                                "No Service Type",
                          ),
                          subtitle: Text(
                            serviceRequestController
                                    .myServiceRequests
                                    .value[index]
                                    .status ??
                                "No Status",
                          ),
                          trailing:
                              serviceRequestController
                                          .myServiceRequests
                                          .value[index]
                                          .status ==
                                      "Pending"
                                  ? Icon(
                                    Icons.punch_clock_rounded,
                                    color: Colors.amber,
                                  )
                                  : serviceRequestController
                                          .myServiceRequests
                                          .value[index]
                                          .status ==
                                      "Accepted"
                                  ? Icon(
                                    Icons.check_circle_outline,
                                    color: Colors.green,
                                  )
                                  : serviceRequestController
                                          .myServiceRequests
                                          .value[index]
                                          .status ==
                                      "Coming"
                                  ? Icon(Icons.run_circle, color: Colors.blue)
                                  : serviceRequestController
                                          .myServiceRequests
                                          .value[index]
                                          .status ==
                                      "Reached"
                                  ? Icon(Icons.location_on, color: Colors.green)
                                  : serviceRequestController
                                          .myServiceRequests
                                          .value[index]
                                          .status ==
                                      "Completed"
                                  ? Icon(
                                    Icons.check_circle,
                                    color: Colors.green,
                                  )
                                  : serviceRequestController
                                          .myServiceRequests
                                          .value[index]
                                          .status ==
                                      "Cancled"
                                  ? Icon(Icons.cancel, color: Colors.red)
                                  : Icon(Icons.help, color: Colors.blue),
                        ),
                      );
                    },
                  ),
                ),
              ),
              
            
            SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("Made with ❤️ by @FlutterHero", 
                  style:TextStyle(
                    fontSize: 12,
                    color: Colors.grey
                  ),
                ),
              ],
            ),
            ],
          ),
        ),
      ),
    );
  }
}
