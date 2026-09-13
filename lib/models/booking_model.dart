class BookingModel {
  final String id;
  final String equipmentId;
  final String equipmentTitle;
  final String farmerId;
  final String ownerId;
  final DateTime bookingDate;
  final String status; // 'pending', 'approved', 'rejected'
  final double totalPrice;

  BookingModel({
    required this.id,
    required this.equipmentId,
    required this.equipmentTitle,
    required this.farmerId,
    required this.ownerId,
    required this.bookingDate,
    required this.status,
    required this.totalPrice,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'equipmentId': equipmentId,
      'equipmentTitle': equipmentTitle,
      'farmerId': farmerId,
      'ownerId': ownerId,
      'bookingDate': bookingDate.toIso8601String(),
      'status': status,
      'totalPrice': totalPrice,
    };
  }

  factory BookingModel.fromMap(Map<String, dynamic> map, String docId) {
    return BookingModel(
      id: docId,
      equipmentId: map['equipmentId'] ?? '',
      equipmentTitle: map['equipmentTitle'] ?? '',
      farmerId: map['farmerId'] ?? '',
      ownerId: map['ownerId'] ?? '',
      bookingDate: DateTime.parse(map['bookingDate']),
      status: map['status'] ?? 'pending',
      totalPrice: (map['totalPrice'] as num).toDouble(),
    );
  }
}