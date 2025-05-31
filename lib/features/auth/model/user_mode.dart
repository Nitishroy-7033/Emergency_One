import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:emergency_one/features/auth/model/emergency_contact.dart';
import 'package:emergency_one/features/auth/model/health_info.dart';

class RecentRequest {
  final String type;
  final String status;
  final DateTime timestamp;

  RecentRequest({
    required this.type,
    required this.status,
    required this.timestamp,
  });

  factory RecentRequest.fromJson(Map<String, dynamic> json) {
    return RecentRequest(
      type: json['type'],
      status: json['status'],
      timestamp: (json['timestamp'] as Timestamp).toDate(),
    );
  }

  Map<String, dynamic> toJson() => {
        'type': type,
        'status': status,
        'timestamp': Timestamp.fromDate(timestamp),
      };
}

class UserModel {
  final String? id;
  final String? name;
  final String? email;
  final String? phone;
  final String? passwordHash;
  final String? role;
  final List<double>? coordinates;
  final bool? isVerified;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final List<EmergencyContact>? emergencyContacts;
  final String? bloodGroup;
  final HealthInfo? healthInfo;
  final List<RecentRequest>? recentRequests;
  final String? address;
  final String? languagePreference;

  UserModel({
    this.id,
     this.name,
     this.email,
     this.phone,
     this.passwordHash,
     this.role,
     this.coordinates,
     this.isVerified,
     this.createdAt,
     this.updatedAt,
    this.emergencyContacts = const [],
    this.bloodGroup,
    this.healthInfo,
    this.recentRequests = const [],
    this.languagePreference,
    this.address,
  });

  factory UserModel.fromJson(Map<String, dynamic> json, [String? docId]) {
    return UserModel(
      id: docId,
      name: json['name'],
      email: json['email'],
      phone: json['phone'],
      address: json['address'],
      passwordHash: json['passwordHash'],
      role: json['role'],
      coordinates: List<double>.from(json['location']['coordinates']),
      isVerified: json['isVerified'] ?? false,
      createdAt: (json['createdAt'] as Timestamp).toDate(),
      updatedAt: (json['updatedAt'] as Timestamp).toDate(),
      emergencyContacts: (json['emergencyContacts'] as List<dynamic>?)
              ?.map((e) => EmergencyContact.fromJson(e))
              .toList() ??
          [],
      bloodGroup: json['bloodGroup'],
      healthInfo: json['healthInfo'] != null
          ? HealthInfo.fromJson(json['healthInfo'])
          : null,
      recentRequests: (json['recentRequests'] as List<dynamic>?)
              ?.map((e) => RecentRequest.fromJson(e))
              .toList() ??
          [],
      languagePreference: json['languagePreference'],
    );
  }

  Map<String, dynamic> toJson() => {
        'name': name,
        'email': email,
        'phone': phone,
        'address': address,
        'passwordHash': passwordHash,
        'role': role,
        'location': {
          'type': 'Point',
          'coordinates': coordinates,
        },
        'isVerified': isVerified,
        'createdAt': Timestamp.fromDate(createdAt!),
        'updatedAt': Timestamp.fromDate(updatedAt!),
        'emergencyContacts':
            emergencyContacts!.map((e) => e.toJson()).toList(),
        'bloodGroup': bloodGroup,
        'healthInfo': healthInfo?.toJson(),
        'recentRequests': recentRequests!.map((e) => e.toJson()).toList(),
        'languagePreference': languagePreference,
      };
}
