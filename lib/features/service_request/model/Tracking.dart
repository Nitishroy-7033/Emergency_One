import 'package:cloud_firestore/cloud_firestore.dart';

class Tracking {
  bool isLive;
  GeoPoint currentLocation;
  List<RouteEntry> routeHistory;
  DateTime? startedAt;
  DateTime? endedAt;

  Tracking({
    required this.isLive,
    required this.currentLocation,
    required this.routeHistory,
    this.startedAt,
    this.endedAt,
  });

  factory Tracking.fromMap(Map<String, dynamic> map) {
    return Tracking(
      isLive: map['isLive'],
      currentLocation: map['currentLocation'],
      routeHistory: (map['routeHistory'] as List<dynamic>)
          .map((e) => RouteEntry.fromMap(e))
          .toList(),
      startedAt: map['startedAt'] != null
          ? (map['startedAt'] as Timestamp).toDate()
          : null,
      endedAt: map['endedAt'] != null
          ? (map['endedAt'] as Timestamp).toDate()
          : null,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'isLive': isLive,
      'currentLocation': currentLocation,
      'routeHistory': routeHistory.map((e) => e.toMap()).toList(),
      'startedAt': startedAt != null ? Timestamp.fromDate(startedAt!) : null,
      'endedAt': endedAt != null ? Timestamp.fromDate(endedAt!) : null,
    };
  }
}

class RouteEntry {
  DateTime timestamp;
  GeoPoint coordinates;

  RouteEntry({required this.timestamp, required this.coordinates});

  factory RouteEntry.fromMap(Map<String, dynamic> map) {
    return RouteEntry(
      timestamp: (map['timestamp'] as Timestamp).toDate(),
      coordinates: map['coordinates'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'timestamp': Timestamp.fromDate(timestamp),
      'coordinates': coordinates,
    };
  }
}
