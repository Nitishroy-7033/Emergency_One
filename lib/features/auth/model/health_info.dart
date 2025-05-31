class HealthInfo {
  final List<String> allergies;
  final List<String> chronicDiseases;
  final List<String> medications;

  HealthInfo({
    required this.allergies,
    required this.chronicDiseases,
    required this.medications,
  });

  factory HealthInfo.fromJson(Map<String, dynamic> json) {
    return HealthInfo(
      allergies: List<String>.from(json['allergies'] ?? []),
      chronicDiseases: List<String>.from(json['chronicDiseases'] ?? []),
      medications: List<String>.from(json['medications'] ?? []),
    );
  }

  Map<String, dynamic> toJson() => {
        'allergies': allergies,
        'chronicDiseases': chronicDiseases,
        'medications': medications,
      };
}