import 'package:easy_stepper/easy_stepper.dart';
import 'package:emergency_one/core/components/primary_button.dart';
import 'package:emergency_one/core/constants/assets_path.dart';
import 'package:emergency_one/features/service_request/model/emergency_request.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:google_maps_widget/google_maps_widget.dart';
import '../../../core/constants/app_const.dart';
import '../controller/service_request.dart';

class ServiceRequestView extends StatelessWidget {
  final EmergencyRequest? serviceData;
  final String? serviceType;
  const ServiceRequestView({super.key, this.serviceData, this.serviceType});

  @override
  Widget build(BuildContext context) {
    
    final serviceRequestController = Get.find<ServiceRequestController>();
    if (serviceRequestController.currentLocation.value == null) {
      serviceRequestController.fetchAndSetCurrentLocation(context);
    }
    RxBool isLoading = false.obs;
    Future<void> createServiceRequest(String serviceType) async {
      isLoading.value = true;
      await serviceRequestController.createServiceRequest(serviceType);
      isLoading.value = false;
    }
    int activeStep = serviceData?.status == "Pending" ?
     0 :
      serviceData?.status == "Accepted" ? 1 : serviceData?.status == "Coming" ? 2 : serviceData?.status == "Reached" ? 3 : serviceData?.status == "Completed" ? 4 : 0;
    return Scaffold(
      bottomNavigationBar: Container(
        padding: EdgeInsets.all(20),
        height: serviceData == null ? 130 : 250,
        margin: EdgeInsets.only(bottom: 20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            serviceData == null
                ? Row(
                  children: [
                    Text(
                      "Service Type: ${serviceType}",
                      style: Theme.of(context).textTheme.labelLarge,
                    ),
                  ],
                )
                : EasyStepper(
                  activeStep: activeStep,
                  stepShape: StepShape.rRectangle,
                  stepBorderRadius: 15,
                  borderThickness: 2,
                  padding: EdgeInsets.all(10),
                  stepRadius: 28,
                  finishedStepBorderColor: Colors.deepOrange,
                  finishedStepTextColor: Colors.deepOrange,
                  finishedStepBackgroundColor: Colors.deepOrange,
                  activeStepIconColor: Colors.deepOrange,
                  showLoadingAnimation: false,
                  steps: [
                    EasyStep(
                      customStep: ClipRRect(
                        borderRadius: BorderRadius.circular(15),
                        child: Opacity(
                          opacity: activeStep >= 0 ? 1 : 0.3,
                          child: Icon(Icons.directions_walk),
                        ),
                      ),
                      customTitle: const Text(
                        'Pending',
                        textAlign: TextAlign.center,
                      ),
                    ),
                    EasyStep(
                      customStep: ClipRRect(
                        borderRadius: BorderRadius.circular(15),
                        child: Opacity(
                          opacity: activeStep >= 1 ? 1 : 0.3,
                          child: Icon(Icons.directions_bike),
                        ),
                      ),
                      customTitle: const Text(
                        'Acepted',
                        textAlign: TextAlign.center,
                      ),
                    ),
                    EasyStep(
                      customStep: ClipRRect(
                        borderRadius: BorderRadius.circular(15),
                        child: Opacity(
                          opacity: activeStep >= 2 ? 1 : 0.3,
                          child: Icon(Icons.directions_car),
                        ),
                      ),
                      customTitle: const Text(
                        'Coming',
                        textAlign: TextAlign.center,
                      ),
                    ),
                    EasyStep(
                      customStep: ClipRRect(
                        borderRadius: BorderRadius.circular(15),
                        child: Opacity(
                          opacity: activeStep >= 3 ? 1 : 0.3,
                          child: Icon(Icons.directions_transit),
                        ),
                      ),
                      customTitle: const Text(
                        'Reached',
                        textAlign: TextAlign.center,
                      ),
                    ),
                    EasyStep(
                      customStep: ClipRRect(
                        borderRadius: BorderRadius.circular(15),
                        child: Opacity(
                          opacity: activeStep >= 4 ? 1 : 0.3,
                          child: Icon(Icons.directions_bus),
                        ),
                      ),
                      customTitle: const Text(
                        'Completed',
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ],
                  onStepReached: (index) => {},
                ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                serviceData == null
                    ? Obx(
                      () =>
                          isLoading.value
                              ? const CircularProgressIndicator()
                              : PrimaryButton(
                                text: "REQUEST",
                                onPressed: () {
                                  createServiceRequest(serviceType??"");
                                },
                              ),
                    )
                    : PrimaryButton(
                      text: "CANCEL",
                      onPressed: () {
                        // serviceRequestController.cancelServiceRequest();
                      },
                    ),
              ],
            ),
          ],
        ),
      ),
      appBar: AppBar(
        title: const Text('Service Request'),
        actions: [
          IconButton(
            onPressed: () {
              serviceRequestController.fetchAndSetCurrentLocation(context);
            },
            icon: Icon(Icons.location_on),
          ),
        ],
      ),
      body: Obx(() {
        final position = serviceRequestController.currentLocation.value;
        if (position == null) {
          return const Center(child: CircularProgressIndicator());
        }
        return GoogleMapsWidget(
          apiKey: "AIzaSyAl5TtsfNcQL0iLuG_STqqYcW5zgEV19no",
          sourceLatLng: LatLng(position.latitude, position.longitude),
          destinationLatLng: LatLng(12.993878, 77.605726),
          routeWidth: 40,
          sourceMarkerIconInfo: MarkerIconInfo(
            infoWindowTitle: "You",
            assetPath: ImageAssets.my,
            assetMarkerSize: const Size.square(40),
          ),
          destinationMarkerIconInfo: MarkerIconInfo(
            assetPath: ImageAssets.des,
            infoWindowTitle: "Destination",
            assetMarkerSize: const Size.square(40),
          ),
          driverMarkerIconInfo: MarkerIconInfo(
            infoWindowTitle: "Driver",
            assetPath: ImageAssets.car,
            assetMarkerSize: const Size.square(40),
            rotation: 90,
          ),
          updatePolylinesOnDriverLocUpdate: true,
          onPolylineUpdate: (_) => print("Polyline updated"),
          totalTimeCallback: (time) {
            print("ETA: $time");
          },
          totalDistanceCallback: (distance) {
            print("Distance: $distance");
          },
        );
      }),
    );
  }
}
