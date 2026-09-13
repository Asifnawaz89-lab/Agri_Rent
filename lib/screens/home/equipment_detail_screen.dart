import 'package:flutter/material.dart';
import 'package:agri_rent/core/constants/app_strings.dart';
import 'package:agri_rent/core/constants/app_theme.dart';
import 'package:agri_rent/core/services/auth_service.dart';
import 'package:agri_rent/core/services/booking_service.dart';
import 'package:agri_rent/models/booking_model.dart';
import 'package:agri_rent/models/equipment_model.dart';

class EquipmentDetailScreen extends StatefulWidget {
  final EquipmentModel equipment;

  const EquipmentDetailScreen({super.key, required this.equipment});

  @override
  State<EquipmentDetailScreen> createState() => _EquipmentDetailScreenState();
}

class _EquipmentDetailScreenState extends State<EquipmentDetailScreen> {
  final BookingService _bookingService = BookingService();
  final AuthService _authService = AuthService();
  bool _isBooking = false;

  void _showBookingDialog() async {
    final pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime.now().add(const Duration(days: 90)),
    );

    if (pickedDate != null) {
      setState(() => _isBooking = true);

      String farmerId = _authService.currentUser!.uid;

      BookingModel booking = BookingModel(
        id: '',
        equipmentId: widget.equipment.id,
        equipmentTitle: widget.equipment.title,
        farmerId: farmerId,
        ownerId: widget.equipment.ownerId,
        bookingDate: pickedDate,
        status: 'pending',
        totalPrice: widget.equipment.dailyRate,
      );

      String? error = await _bookingService.createBooking(booking);

      setState(() => _isBooking = false);

      if (!mounted) return;

      if (error == null) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            backgroundColor: AppTheme.primaryGreen,
            content: Text(
              "${AppStrings.get('bookingRequestedFor')} ${pickedDate.day}/${pickedDate.month}/${pickedDate.year}",
            ),
          ),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(error), backgroundColor: Colors.redAccent),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(widget.equipment.title)),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Container(
              height: 250,
              color: Colors.grey.shade300,
              child: widget.equipment.imageUrls.isNotEmpty
                  ? Image.network(
                      widget.equipment.imageUrls.first,
                      fit: BoxFit.cover,
                      errorBuilder: (_, __, ___) => const Icon(Icons.agriculture, size: 80, color: AppTheme.primaryGreen),
                    )
                  : const Icon(Icons.agriculture, size: 80, color: AppTheme.primaryGreen),
            ),
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(widget.equipment.title, style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
                  const SizedBox(height: 8),
                  Chip(label: Text(widget.equipment.category), backgroundColor: AppTheme.lightGreen),
                  const SizedBox(height: 16),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("Hourly: PKR ${widget.equipment.hourlyRate}", style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600, color: AppTheme.primaryGreen)),
                      Text("Daily: PKR ${widget.equipment.dailyRate}", style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600, color: AppTheme.primaryGreen)),
                    ],
                  ),
                  const Divider(height: 32),
                  Text(AppStrings.get('description'), style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                  const SizedBox(height: 8),
                  Text(widget.equipment.description, style: const TextStyle(fontSize: 15, color: Colors.black87)),
                ],
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: _isBooking
              ? const Center(child: CircularProgressIndicator())
              : ElevatedButton(
                  onPressed: _showBookingDialog,
                  child: Text(AppStrings.get('bookNow'), style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                ),
        ),
      ),
    );
  }
}