import 'package:flutter/material.dart';
import 'package:agri_rent/core/constants/app_strings.dart';
import 'package:agri_rent/core/services/auth_service.dart';
import 'package:agri_rent/screens/auth/login_screen.dart';
import 'package:agri_rent/screens/home/add_equipment_screen.dart';
import 'package:agri_rent/screens/home/owner_bookings_screen.dart';

class OwnerHomeScreen extends StatefulWidget {
  const OwnerHomeScreen({super.key});

  @override
  State<OwnerHomeScreen> createState() => _OwnerHomeScreenState();
}

class _OwnerHomeScreenState extends State<OwnerHomeScreen> {
  final AuthService _authService = AuthService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(AppStrings.get('ownerHome')),
        actions: [
          IconButton(
            icon: const Icon(Icons.bookmark_border),
            tooltip: "Booking Requests",
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const OwnerBookingsScreen()),
              );
            },
          ),
          IconButton(
            icon: const Icon(Icons.language),
            onPressed: () => setState(() => AppStrings.toggleLanguage()),
          ),
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () async {
              final nav = Navigator.of(context);
              await _authService.signOut();
              if (!mounted) return;
              nav.pushReplacement(
                MaterialPageRoute(builder: (_) => const LoginScreen()),
              );
            },
          ),
        ],
      ),
      body: const Center(
        child: Text(
          "Welcome Equipment Owner!",
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (_) => const AddEquipmentScreen()),
          );
        },
        icon: const Icon(Icons.add),
        label: Text(AppStrings.get('addEquipment')),
      ),
    );
  }
}