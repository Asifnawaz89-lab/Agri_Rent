class UserModel {
  final String uid;
  final String fullName;
  final String phoneNumber;
  final String email;
  final String userRole; // 'farmer' ya 'owner'

  UserModel({
    required this.uid,
    required this.fullName,
    required this.phoneNumber,
    required this.email,
    required this.userRole,
  });

  // Map mein convert karke Firestore ko bhejne ke liye
  Map<String, dynamic> toMap() {
    return {
      'uid': uid,
      'fullName': fullName,
      'phoneNumber': phoneNumber,
      'email': email,
      'userRole': userRole,
      'createdAt': DateTime.now().toIso8601String(),
    };
  }

  // Firestore se data read karne ke liye
  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      uid: map['uid'] ?? '',
      fullName: map['fullName'] ?? '',
      phoneNumber: map['phoneNumber'] ?? '',
      email: map['email'] ?? '',
      userRole: map['userRole'] ?? 'farmer',
    );
  }
}