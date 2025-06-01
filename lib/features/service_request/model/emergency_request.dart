import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:emergency_one/features/service_request/model/BloodDetails.dart';
import 'package:emergency_one/features/service_request/model/RequestDetails.dart';
import 'package:emergency_one/features/service_request/model/Tracking.dart';

class EmergencyRequest {
  String? id;
  String? userId;
  String? serviceType;
  String? status;
  RequestDetails? requestDetails;
  BloodDetails? bloodDetails;
  Tracking? tracking;
  String? assignedTo;
  DateTime? createdAt;
  DateTime? updatedAt;

  EmergencyRequest({
   this.id,
   this.userId,
   this.serviceType,
   this.status,
   this.requestDetails,
    this.bloodDetails,
    this.tracking,
    this.assignedTo,
   this.createdAt,
   this.updatedAt,
  });

  factory EmergencyRequest.fromMap(Map<String, dynamic> map, String docId) {
    return EmergencyRequest(
      id: docId,
      userId: map['userId'],
      serviceType: map['serviceType'],
      status: map['status'],
      requestDetails: RequestDetails.fromMap(map['requestDetails']),
      bloodDetails: map['bloodDetails'] != null
          ? BloodDetails.fromMap(map['bloodDetails'])
          : null,
      tracking: map['tracking'] != null
          ? Tracking.fromMap(map['tracking'])
          : null,
      assignedTo: map['assignedTo'],
      createdAt: (map['createdAt'] as Timestamp).toDate(),
      updatedAt: (map['updatedAt'] as Timestamp).toDate(),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'userId': userId,
      'serviceType': serviceType,
      'status': status,
      'requestDetails': requestDetails!.toMap(),
      if (bloodDetails != null) 'bloodDetails': bloodDetails!.toMap(),
      if (tracking != null) 'tracking': tracking!.toMap(),
      'assignedTo': assignedTo,
      'createdAt': Timestamp.fromDate(createdAt!),
      'updatedAt': Timestamp.fromDate(updatedAt!),
    };
  }
}
