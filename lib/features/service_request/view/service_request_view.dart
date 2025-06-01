import 'package:easy_stepper/easy_stepper.dart';
import 'package:emergency_one/core/components/primary_button.dart';
import 'package:emergency_one/core/constants/assets_path.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:google_maps_widget/google_maps_widget.dart';
import '../../../core/constants/app_const.dart';
import '../controller/service_request.dart';

class ServiceRequestView extends StatelessWidget {
  const ServiceRequestView({super.key});

  @override
  Widget build(BuildContext context) {
    int activeStep = 2;
    final serviceRequestController = Get.find<ServiceRequestController>();
    if (serviceRequestController.currentLocation.value == null) {
      serviceRequestController.fetchAndSetCurrentLocation(context);
    }
    RxBool isLoading = false.obs;
    Future<void> createServiceRequest() async {
      isLoading.value = true;
      await serviceRequestController.createServiceRequest();
      isLoading.value = false;
    }
    return Scaffold(
      bottomNavigationBar: Container(
        margin: EdgeInsets.only(bottom: 20),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            PrimaryButton(text: "CANCEL", onPressed: () {}),
            Obx(() => isLoading.value
                ? const CircularProgressIndicator()
                : PrimaryButton(
                    text: "REQUEST",
                    onPressed: () {
                      serviceRequestController.createServiceRequest();
                    },
                  )),
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
      body: Padding(
        padding: const EdgeInsets.all(PAGE_PADDING),
        child: Obx(() {
          final position = serviceRequestController.currentLocation.value;
          if (position == null) {
            return const Center(child: CircularProgressIndicator());
          }
          return ListView(
            children: [
              Container(
                height: 700,
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.primaryContainer,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: GoogleMapsWidget(
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
                ),
              ),
              SizedBox(height: 20),
              EasyStepper(
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
            ],
          );
        }),
      ),
    );
  }
}
