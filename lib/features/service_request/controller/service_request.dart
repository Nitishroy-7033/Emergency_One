import 'dart:ui';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:emergency_one/features/service_request/model/RequestDetails.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:uuid/uuid.dart';

import '../model/emergency_request.dart';

class ServiceRequestController extends GetxController {
  final db = FirebaseFirestore.instance;
  final auth = FirebaseAuth.instance;
  Rxn<Position> currentLocation = Rxn<Position>();
  RxList<EmergencyRequest> myServiceRequests = RxList<EmergencyRequest>();
  @override
  void onInit() {
    super.onInit();
    fetchAndSetCurrentLocation(Get.context!);
    getMyServiceRequests();
  }

  Future<bool> checkAndRequestLocationPermission(BuildContext context) async {
    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        Get.snackbar(
          "Location Required",
          "Please enable location permission to use this feature.",
          snackPosition: SnackPosition.BOTTOM,
        );
        return false;
      }
    }
    if (permission == LocationPermission.deniedForever) {
      Get.defaultDialog(
        title: "Location Permission",
        middleText:
            "Location permission is permanently denied. Please enable it from app settings.",
        textConfirm: "Open Settings",
        onConfirm: () {
          Geolocator.openAppSettings();
          Get.back();
        },
        textCancel: "Cancel",
      );
      return false;
    }
    return true;
  }

  Future<Position> getCurrentLocation(BuildContext context) async {
    bool hasPermission = await checkAndRequestLocationPermission(context);
    if (!hasPermission) throw Exception("Location permission not granted");
    final location = await Geolocator.getCurrentPosition();
    print("Your Current location 🥷 : $location");
    return location;
  }

  Future<void> fetchAndSetCurrentLocation(BuildContext context) async {
    currentLocation.value = null;
    try {
      currentLocation.value = await getCurrentLocation(context);
    } catch (e) {
      // Optionally handle error
    }
  }

  Future<void> createServiceRequest(String serviceType) async {
    var docId = Uuid().v4();
    try {
      var newservice = EmergencyRequest(
        id: docId,
        userId: auth.currentUser?.uid,
        serviceType:serviceType,
        status: "Pending",
        requestDetails: RequestDetails(
          message: "Service Request",
          location: currentLocation.value!,
          urgencyLevel: "medium",
        ),
        createdAt: DateTime.now(),
        updatedAt: DateTime.now(),
      );
      await db.collection("ServiceRequest").doc(docId).set(newservice.toMap());
      await getMyServiceRequests(); 
      Get.snackbar(
        "Success",
        "Service Request Created Successfully",
        snackPosition: SnackPosition.BOTTOM,
      );
    } catch (ex) {
      Get.snackbar("Error", ex.toString(), snackPosition: SnackPosition.BOTTOM);
    }
  }

 Future<List<EmergencyRequest>> getMyServiceRequests() async {
  try {
    final userId = auth.currentUser?.uid;
    if (userId == null) {
      throw Exception("User is not logged in");
    }
    final querySnapshot = await db
        .collection("ServiceRequest")
        .where("userId", isEqualTo: userId)
        .orderBy("createdAt", descending: true) 
        .get();

    final requests = querySnapshot.docs.map((doc) {
      return EmergencyRequest.fromMap(doc.data(), doc.id);
    }).toList();
    myServiceRequests.value = requests;
    print("Service Requests: ${myServiceRequests.value[0].serviceType}");
    return requests;
  } catch (e) {
    debugPrint("Error fetching service requests: $e");
    Get.snackbar("Error", e.toString(), snackPosition: SnackPosition.BOTTOM);

    return []; // Return empty list to avoid crash
  }
}

}
