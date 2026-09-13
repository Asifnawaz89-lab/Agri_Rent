import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker/image_picker.dart';
import '../../models/equipment_model.dart';

class EquipmentService {
  final FirebaseFirestore _db = FirebaseFirestore.instance;
  final FirebaseStorage _storage = FirebaseStorage.instance;

  // Upload Images safely using File stream
  Future<List<String>> uploadEquipmentImages({
    required List<XFile> imageFiles,
    required String ownerId,
  }) async {
    List<String> imageUrls = [];

    for (XFile xFile in imageFiles) {
      try {
        String fileName = "${DateTime.now().millisecondsSinceEpoch}_${xFile.name}";
        Reference ref = _storage.ref().child('equipment_images').child(ownerId).child(fileName);

        File file = File(xFile.path);
        UploadTask uploadTask = ref.putFile(file);
        TaskSnapshot snapshot = await uploadTask;

        String downloadUrl = await snapshot.ref.getDownloadURL();
        imageUrls.add(downloadUrl);
      } catch (e) {
        // Fallback or handle single image failure
      }
    }
    return imageUrls;
  }

  // Add Equipment Document to Firestore
  Future<String?> addEquipment(EquipmentModel equipment) async {
    try {
      DocumentReference docRef = _db.collection('equipments').doc();
      EquipmentModel newEquipment = EquipmentModel(
        id: docRef.id,
        ownerId: equipment.ownerId,
        title: equipment.title,
        category: equipment.category,
        description: equipment.description,
        hourlyRate: equipment.hourlyRate,
        dailyRate: equipment.dailyRate,
        imageUrls: equipment.imageUrls,
      );

      await docRef.set(newEquipment.toMap());
      return null; // Success
    } catch (e) {
      return e.toString();
    }
  }

  // Get Stream of Available Equipments
  Stream<List<EquipmentModel>> getAvailableEquipment() {
    return _db.collection('equipments').snapshots().map((snapshot) {
      return snapshot.docs
          .map((doc) => EquipmentModel.fromMap(doc.data(), doc.id))
          .toList();
    });
  }
}