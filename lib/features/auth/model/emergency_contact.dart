
class EmergencyContact {
  final String name;
  final String phone;
  final String relation;

  EmergencyContact({
    required this.name,
    required this.phone,
    required this.relation,
  });

  factory EmergencyContact.fromJson(Map<String, dynamic> json) {
    return EmergencyContact(
      name: json['name'],
      phone: json['phone'],
      relation: json['relation'],
    );
  }

  Map<String, dynamic> toJson() => {
        'name': name,
        'phone': phone,
        'relation': relation,
      };
}