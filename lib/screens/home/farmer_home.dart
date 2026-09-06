import 'package:flutter/material.dart';
import 'package:agri_rent/core/constants/app_strings.dart';
import 'package:agri_rent/core/constants/app_theme.dart';
import 'package:agri_rent/core/services/auth_service.dart';
import 'package:agri_rent/core/services/equipment_service.dart';
import 'package:agri_rent/models/equipment_model.dart';
import 'package:agri_rent/screens/auth/login_screen.dart';
import 'package:agri_rent/screens/home/equipment_detail_screen.dart';

class FarmerHomeScreen extends StatefulWidget {
  const FarmerHomeScreen({super.key});

  @override
  State<FarmerHomeScreen> createState() => _FarmerHomeScreenState();
}

class _FarmerHomeScreenState extends State<FarmerHomeScreen> {
  final AuthService _authService = AuthService();
  final EquipmentService _equipmentService = EquipmentService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(AppStrings.get('farmerHome')),
        actions: [
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
      body: StreamBuilder<List<EquipmentModel>>(
        stream: _equipmentService.getAvailableEquipment(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(
              child: Text(
                AppStrings.isUrdu ? "کوئی مشینری دستیاب نہیں ہے۔" : "No equipment available right now.",
                style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
            );
          }

          final equipmentList = snapshot.data!;

          return ListView.builder(
            padding: const EdgeInsets.all(16),
            itemCount: equipmentList.length,
            itemBuilder: (context, index) {
              final item = equipmentList[index];
              return Card(
                margin: const EdgeInsets.only(bottom: 16),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                child: ListTile(
                  contentPadding: const EdgeInsets.all(12),
                  leading: Container(
                    width: 70,
                    height: 70,
                    decoration: BoxDecoration(
                      color: AppTheme.lightGreen,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: const Icon(Icons.agriculture, color: AppTheme.primaryGreen, size: 40),
                  ),
                  title: Text(
                    item.title,
                    style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                  ),
                  subtitle: Text("${item.category} • PKR ${item.dailyRate}/day"),
                  trailing: const Icon(Icons.arrow_forward_ios, size: 18),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => EquipmentDetailScreen(equipment: item),
                      ),
                    );
                  },
                ),
              );
            },
          );
        },
      ),
    );
  }
}