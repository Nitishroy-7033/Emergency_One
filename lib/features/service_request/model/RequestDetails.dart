import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:geolocator/geolocator.dart';

class RequestDetails {
  String message;
  Position location;
  String urgencyLevel;

  RequestDetails({
    required this.message,
    required this.location,
    required this.urgencyLevel,
  });

  factory RequestDetails.fromMap(Map<String, dynamic> map) {
    return RequestDetails(
      message: map['message'],
      location: Position(
        latitude: map['location']['latitude'],
        longitude: map['location']['longitude'],
        timestamp: DateTime.now(),
        accuracy: 0.0,
        altitude: 0.0,
        heading: 0.0,
        speed: 0.0,
        speedAccuracy: 0.0,
        altitudeAccuracy: 0.0,
        headingAccuracy: 0.0,
        isMocked: false,
      ),
      urgencyLevel: map['urgencyLevel'] ?? 'medium',
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'message': message,
      'location': {
        'latitude': location.latitude,
        'longitude': location.longitude,
      },
      'urgencyLevel': urgencyLevel,
    };
  }
}
