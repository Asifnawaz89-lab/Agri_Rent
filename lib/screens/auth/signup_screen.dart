import 'package:flutter/material.dart';
import 'package:agri_rent/core/constants/app_strings.dart';
import 'package:agri_rent/core/constants/app_theme.dart';
import 'package:agri_rent/core/services/auth_service.dart';
import 'package:agri_rent/screens/auth/login_screen.dart';
import 'package:agri_rent/screens/home/farmer_home.dart';
import 'package:agri_rent/screens/home/owner_home.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final _formKey = GlobalKey<FormState>();
  final AuthService _authService = AuthService();

  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  String _selectedRole = 'farmer';
  bool _isLoading = false;

  void _handleSignUp() async {
    if (_formKey.currentState!.validate()) {
      setState(() => _isLoading = true);

      String? error = await _authService.signUp(
        email: _emailController.text.trim(),
        password: _passwordController.text.trim(),
        fullName: _nameController.text.trim(),
        phoneNumber: _phoneController.text.trim(),
        userRole: _selectedRole,
      );

      setState(() => _isLoading = false);

      if (error == null) {
        if (!mounted) return;

        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            backgroundColor: AppTheme.primaryGreen,
            content: Text(
              AppStrings.get('accountCreated'),
              style: const TextStyle(color: Colors.white),
            ),
          ),
        );

        if (_selectedRole == 'owner') {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (_) => const OwnerHomeScreen()),
          );
        } else {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (_) => const FarmerHomeScreen()),
          );
        }
      } else {
        if (!mounted) return;
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            backgroundColor: Colors.redAccent,
            content: Text(error),
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(AppStrings.get('signUp')),
        actions: [
          TextButton(
            onPressed: () {
              setState(() {
                AppStrings.toggleLanguage();
              });
            },
            child: Text(
              AppStrings.isUrdu ? AppStrings.get('english') : AppStrings.get('urdu'),
              style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
            ),
          ),
        ],
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24.0),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const Icon(
                  Icons.person_add_alt_1_rounded,
                  size: 60,
                  color: AppTheme.primaryGreen,
                ),
                const SizedBox(height: 10),

                Text(
                  AppStrings.get('signUp'),
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: AppTheme.primaryGreen,
                  ),
                ),
                const SizedBox(height: 24),

                TextFormField(
                  controller: _nameController,
                  decoration: InputDecoration(
                    labelText: AppStrings.get('fullName'),
                    prefixIcon: const Icon(Icons.person_outline),
                  ),
                  validator: (val) => val!.isEmpty ? AppStrings.get('requiredName') : null,
                ),
                const SizedBox(height: 16),

                TextFormField(
                  controller: _phoneController,
                  keyboardType: TextInputType.phone,
                  decoration: const InputDecoration(
                    labelText: "Phone Number",
                    prefixIcon: Icon(Icons.phone_outlined),
                  ),
                  validator: (val) => val!.isEmpty ? "Enter phone" : null,
                ),
                const SizedBox(height: 16),

                TextFormField(
                  controller: _emailController,
                  keyboardType: TextInputType.emailAddress,
                  decoration: InputDecoration(
                    labelText: AppStrings.get('email'),
                    prefixIcon: const Icon(Icons.email_outlined),
                  ),
                  validator: (val) => val!.isEmpty ? AppStrings.get('requiredEmail') : null,
                ),
                const SizedBox(height: 16),

                TextFormField(
                  controller: _passwordController,
                  obscureText: true,
                  decoration: InputDecoration(
                    labelText: AppStrings.get('password'),
                    prefixIcon: const Icon(Icons.lock_outline),
                  ),
                  validator: (val) => val!.length < 6 ? AppStrings.get('requiredPassword') : null,
                ),
                const SizedBox(height: 20),

                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: Colors.grey.shade300),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        AppStrings.get('selectRole'),
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 15,
                          color: AppTheme.primaryGreen,
                        ),
                      ),
                      const Divider(),
                      RadioListTile<String>(
                        title: Text(AppStrings.get('farmer')),
                        value: 'farmer',
                        groupValue: _selectedRole,
                        activeColor: AppTheme.primaryGreen,
                        onChanged: (val) {
                          if (val != null) setState(() => _selectedRole = val);
                        },
                      ),
                      RadioListTile<String>(
                        title: Text(AppStrings.get('equipmentOwner')),
                        value: 'owner',
                        groupValue: _selectedRole,
                        activeColor: AppTheme.primaryGreen,
                        onChanged: (val) {
                          if (val != null) setState(() => _selectedRole = val);
                        },
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 24),

                _isLoading
                    ? const Center(child: CircularProgressIndicator())
                    : ElevatedButton(
                        onPressed: _handleSignUp,
                        child: Text(
                          AppStrings.get('signUp'),
                          style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                        ),
                      ),
                const SizedBox(height: 12),

                TextButton(
                  onPressed: () {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(builder: (_) => const LoginScreen()),
                    );
                  },
                  child: Text(AppStrings.get('alreadyHaveAccount')),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}