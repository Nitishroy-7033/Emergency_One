import 'package:cloud_firestore/cloud_firestore.dart';

class RequestDetails {
  String message;
  GeoPoint location;
  String urgencyLevel;

  RequestDetails({
    required this.message,
    required this.location,
    required this.urgencyLevel,
  });

  factory RequestDetails.fromMap(Map<String, dynamic> map) {
    return RequestDetails(
      message: map['message'],
      location: map['location'],
      urgencyLevel: map['urgencyLevel'] ?? 'medium',
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'message': message,
      'location': location,
      'urgencyLevel': urgencyLevel,
    };
  }
}
