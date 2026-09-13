import 'package:cloud_firestore/cloud_firestore.dart';
import '../../models/booking_model.dart';

class BookingService {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  // Create new booking request
  Future<String?> createBooking(BookingModel booking) async {
    try {
      DocumentReference docRef = _db.collection('bookings').doc();
      BookingModel newBooking = BookingModel(
        id: docRef.id,
        equipmentId: booking.equipmentId,
        equipmentTitle: booking.equipmentTitle,
        farmerId: booking.farmerId,
        ownerId: booking.ownerId,
        bookingDate: booking.bookingDate,
        status: booking.status,
        totalPrice: booking.totalPrice,
      );
      await docRef.set(newBooking.toMap());
      return null;
    } catch (e) {
      return e.toString();
    }
  }

  // Get stream of owner bookings
  Stream<List<BookingModel>> getOwnerBookings(String ownerId) {
    return _db
        .collection('bookings')
        .where('ownerId', isEqualTo: ownerId)
        .snapshots()
        .map((snapshot) => snapshot.docs
            .map((doc) => BookingModel.fromMap(doc.data(), doc.id))
            .toList());
  }

  // Update booking status (Accept / Reject)
  Future<void> updateBookingStatus(String bookingId, String status) async {
    await _db.collection('bookings').doc(bookingId).update({'status': status});
  }
}