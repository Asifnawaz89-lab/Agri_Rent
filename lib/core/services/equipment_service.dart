import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';
import '../../models/equipment_model.dart';

class EquipmentService {
  final FirebaseFirestore _db = FirebaseFirestore.instance;
  final FirebaseStorage _storage = FirebaseStorage.instance;

  // 1. Upload Images to Firebase Storage & Get Download URLs
  Future<List<String>> uploadEquipmentImages({
    required List<dynamic> imageFiles, // Can be File (Mobile) or Uint8List/XFile (Web)
    required String ownerId,
  }) async {
    List<String> downloadUrls = [];

    for (int i = 0; i < imageFiles.length; i++) {
      String fileName = '${DateTime.now().millisecondsSinceEpoch}_$i.jpg';
      Reference ref = _storage.ref().child('equipment_images/$ownerId/$fileName');

      UploadTask uploadTask;
      if (kIsWeb) {
        // Web Platform
        uploadTask = ref.putData(await imageFiles[i].readAsBytes());
      } else {
        // Android / iOS
        uploadTask = ref.putFile(File(imageFiles[i].path));
      }

      TaskSnapshot snapshot = await uploadTask;
      String url = await snapshot.ref.getDownloadURL();
      downloadUrls.add(url);
    }

    return downloadUrls;
  }

  // 2. Add New Equipment Document to Firestore
  Future<String?> addEquipment(EquipmentModel equipment) async {
    try {
      DocumentReference docRef = _db.collection('equipment').doc();
      
      EquipmentModel finalEquipment = EquipmentModel(
        id: docRef.id,
        ownerId: equipment.ownerId,
        title: equipment.title,
        category: equipment.category,
        description: equipment.description,
        hourlyRate: equipment.hourlyRate,
        dailyRate: equipment.dailyRate,
        imageUrls: equipment.imageUrls,
        isAvailable: equipment.isAvailable,
      );

      await docRef.set(finalEquipment.toMap());
      return null; // Success
    } catch (e) {
      return e.toString();
    }
  }

  // 3. Stream Equipment List for Farmers / Owners
  Stream<List<EquipmentModel>> getAvailableEquipment() {
    return _db
        .collection('equipment')
        .where('isAvailable', isEqualTo: true)
        .snapshots()
        .map((snapshot) => snapshot.docs
            .map((doc) => EquipmentModel.fromMap(doc.data(), doc.id))
            .toList());
  }
}