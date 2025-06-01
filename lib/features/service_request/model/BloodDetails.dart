import 'package:cloud_firestore/cloud_firestore.dart';

class BloodDetails {
  String bloodGroup;
  int quantity;
  DateTime neededBy;

  BloodDetails({
    required this.bloodGroup,
    required this.quantity,
    required this.neededBy,
  });

  factory BloodDetails.fromMap(Map<String, dynamic> map) {
    return BloodDetails(
      bloodGroup: map['bloodGroup'],
      quantity: map['quantity'],
      neededBy: (map['neededBy'] as Timestamp).toDate(),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'bloodGroup': bloodGroup,
      'quantity': quantity,
      'neededBy': Timestamp.fromDate(neededBy),
    };
  }
}
