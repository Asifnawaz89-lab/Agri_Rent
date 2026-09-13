import 'package:flutter/material.dart';
import 'package:agri_rent/core/constants/app_theme.dart';
import 'package:agri_rent/core/services/auth_service.dart';
import 'package:agri_rent/core/services/booking_service.dart';
import 'package:agri_rent/models/booking_model.dart';

class OwnerBookingsScreen extends StatefulWidget {
  const OwnerBookingsScreen({super.key});

  @override
  State<OwnerBookingsScreen> createState() => _OwnerBookingsScreenState();
}

class _OwnerBookingsScreenState extends State<OwnerBookingsScreen> {
  final BookingService _bookingService = BookingService();
  final AuthService _authService = AuthService();

  @override
  Widget build(BuildContext context) {
    String ownerId = _authService.currentUser?.uid ?? '';

    return Scaffold(
      appBar: AppBar(
        title: const Text("Booking Requests"),
      ),
      body: StreamBuilder<List<BookingModel>>(
        stream: _bookingService.getOwnerBookings(ownerId),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(
              child: Text(
                "No booking requests yet.",
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
            );
          }

          final bookings = snapshot.data!;

          return ListView.builder(
            padding: const EdgeInsets.all(16),
            itemCount: bookings.length,
            itemBuilder: (context, index) {
              final booking = bookings[index];
              return Card(
                margin: const EdgeInsets.only(bottom: 12),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            booking.equipmentTitle,
                            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                          ),
                          Chip(
                            label: Text(
                              booking.status.toUpperCase(),
                              style: const TextStyle(color: Colors.white, fontSize: 12),
                            ),
                            backgroundColor: booking.status == 'approved'
                                ? AppTheme.primaryGreen
                                : booking.status == 'rejected'
                                    ? Colors.red
                                    : Colors.orange,
                          ),
                        ],
                      ),
                      const SizedBox(height: 8),
                      Text("Date: ${booking.bookingDate.day}/${booking.bookingDate.month}/${booking.bookingDate.year}"),
                      Text("Price: PKR ${booking.totalPrice}"),
                      const SizedBox(height: 12),
                      if (booking.status == 'pending')
                        Row(
                          children: [
                            Expanded(
                              child: ElevatedButton(
                                style: ElevatedButton.styleFrom(backgroundColor: AppTheme.primaryGreen),
                                onPressed: () {
                                  _bookingService.updateBookingStatus(booking.id, 'approved');
                                },
                                child: const Text("Accept"),
                              ),
                            ),
                            const SizedBox(width: 12),
                            Expanded(
                              child: ElevatedButton(
                                style: ElevatedButton.styleFrom(backgroundColor: Colors.redAccent),
                                onPressed: () {
                                  _bookingService.updateBookingStatus(booking.id, 'rejected');
                                },
                                child: const Text("Reject"),
                              ),
                            ),
                          ],
                        ),
                    ],
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}