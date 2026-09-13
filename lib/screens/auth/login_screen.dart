import 'package:flutter/material.dart';
import 'package:agri_rent/core/constants/app_strings.dart';
import 'package:agri_rent/core/constants/app_theme.dart';
import 'package:agri_rent/core/services/auth_service.dart';
import 'package:agri_rent/screens/auth/signup_screen.dart';
import 'package:agri_rent/screens/home/farmer_home.dart';
import 'package:agri_rent/screens/home/owner_home.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final AuthService _authService = AuthService();

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  bool _isLoading = false;

  void _handleLogin() async {
    if (_formKey.currentState!.validate()) {
      setState(() => _isLoading = true);

      // .trim() removes invisible space issues causing invalid-email
      String email = _emailController.text.trim();
      String password = _passwordController.text.trim();

      String? error = await _authService.login(
        email: email,
        password: password,
      );

      if (error == null) {
        String uid = _authService.currentUser!.uid;
        String? role = await _authService.getUserRole(uid);

        setState(() => _isLoading = false);

        if (!mounted) return;

        if (role == 'owner') {
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
        setState(() => _isLoading = false);
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
        actions: [
          IconButton(
            icon: const Icon(Icons.language),
            onPressed: () => setState(() => AppStrings.toggleLanguage()),
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
                const Icon(Icons.agriculture, size: 80, color: AppTheme.primaryGreen),
                const SizedBox(height: 10),
                const Text(
                  "AgriRent",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                    color: AppTheme.primaryGreen,
                  ),
                ),
                const SizedBox(height: 30),
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
                  validator: (val) => val!.isEmpty ? AppStrings.get('requiredPassword') : null,
                ),
                const SizedBox(height: 24),
                _isLoading
                    ? const Center(child: CircularProgressIndicator())
                    : ElevatedButton(
                        onPressed: _handleLogin,
                        child: Text(
                          AppStrings.get('login'),
                          style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                        ),
                      ),
                const SizedBox(height: 12),
                TextButton(
                  onPressed: () {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(builder: (_) => const SignupScreen()),
                    );
                  },
                  child: Text(AppStrings.get('dontHaveAccount')),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}