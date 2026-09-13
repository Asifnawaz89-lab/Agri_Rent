import 'package:cloud_firestore/cloud_firestore.dart';
import '../../models/booking_model.dart';

class BookingService {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  // Submit Booking Request
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
      return null; // Success
    } catch (e) {
      return e.toString();
    }
  }
}