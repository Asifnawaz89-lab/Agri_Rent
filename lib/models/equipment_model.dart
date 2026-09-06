class EquipmentModel {
  final String id;
  final String ownerId;
  final String title;
  final String category; // Tractor, Rotavator, etc.
  final String description;
  final double hourlyRate;
  final double dailyRate;
  final List<String> imageUrls;
  final bool isAvailable;

  EquipmentModel({
    required this.id,
    required this.ownerId,
    required this.title,
    required this.category,
    required this.description,
    required this.hourlyRate,
    required this.dailyRate,
    required this.imageUrls,
    this.isAvailable = true,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'ownerId': ownerId,
      'title': title,
      'category': category,
      'description': description,
      'hourlyRate': hourlyRate,
      'dailyRate': dailyRate,
      'imageUrls': imageUrls,
      'isAvailable': isAvailable,
      'createdAt': DateTime.now().toIso8601String(),
    };
  }

  factory EquipmentModel.fromMap(Map<String, dynamic> map, String docId) {
    return EquipmentModel(
      id: docId,
      ownerId: map['ownerId'] ?? '',
      title: map['title'] ?? '',
      category: map['category'] ?? 'Tractor',
      description: map['description'] ?? '',
      hourlyRate: (map['hourlyRate'] ?? 0).toDouble(),
      dailyRate: (map['dailyRate'] ?? 0).toDouble(),
      imageUrls: List<String>.from(map['imageUrls'] ?? []),
      isAvailable: map['isAvailable'] ?? true,
    );
  }
}