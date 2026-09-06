import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:agri_rent/core/constants/app_strings.dart';
import 'package:agri_rent/core/constants/app_theme.dart';
import 'package:agri_rent/core/services/auth_service.dart';
import 'package:agri_rent/core/services/equipment_service.dart';
import 'package:agri_rent/models/equipment_model.dart';

class AddEquipmentScreen extends StatefulWidget {
  const AddEquipmentScreen({super.key});

  @override
  State<AddEquipmentScreen> createState() => _AddEquipmentScreenState();
}

class _AddEquipmentScreenState extends State<AddEquipmentScreen> {
  final _formKey = GlobalKey<FormState>();
  final EquipmentService _equipmentService = EquipmentService();
  final AuthService _authService = AuthService();

  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _descController = TextEditingController();
  final TextEditingController _hourlyRateController = TextEditingController();
  final TextEditingController _dailyRateController = TextEditingController();

  String _selectedCategory = 'Tractor';
  final List<String> _categories = ['Tractor', 'Rotavator', 'Harvester', 'Thresher', 'Tools'];

  List<XFile> _selectedImages = [];
  bool _isLoading = false;

  void _pickImages() async {
    final ImagePicker picker = ImagePicker();
    final List<XFile> images = await picker.pickMultiImage();
    if (images.isNotEmpty) {
      setState(() {
        _selectedImages = images;
      });
    }
  }

  void _submitEquipment() async {
    if (!_formKey.currentState!.validate()) return;
    if (_selectedImages.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(AppStrings.get('selectAtleastOneImage')),
        ),
      );
      return;
    }

    setState(() => _isLoading = true);

    try {
      String ownerId = _authService.currentUser!.uid;

      List<String> imageUrls = await _equipmentService.uploadEquipmentImages(
        imageFiles: _selectedImages,
        ownerId: ownerId,
      );

      EquipmentModel newEquipment = EquipmentModel(
        id: '',
        ownerId: ownerId,
        title: _titleController.text.trim(),
        category: _selectedCategory,
        description: _descController.text.trim(),
        hourlyRate: double.parse(_hourlyRateController.text.trim()),
        dailyRate: double.parse(_dailyRateController.text.trim()),
        imageUrls: imageUrls,
      );

      String? error = await _equipmentService.addEquipment(newEquipment);

      setState(() => _isLoading = false);

      if (error == null) {
        if (!mounted) return;
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            backgroundColor: AppTheme.primaryGreen,
            content: Text(AppStrings.get('equipmentAddedSuccess')),
          ),
        );
        Navigator.pop(context);
      } else {
        if (!mounted) return;
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(error)));
      }
    } catch (e) {
      setState(() => _isLoading = false);
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(e.toString())));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(AppStrings.get('addEquipment')),
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
          )
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              GestureDetector(
                onTap: _pickImages,
                child: Container(
                  height: 140,
                  decoration: BoxDecoration(
                    color: Colors.grey.shade100,
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: AppTheme.primaryGreen, style: BorderStyle.solid),
                  ),
                  child: _selectedImages.isEmpty
                      ? Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Icon(Icons.add_a_photo, size: 40, color: AppTheme.primaryGreen),
                            const SizedBox(height: 8),
                            Text(AppStrings.get('uploadPhotos')),
                          ],
                        )
                      : Center(
                          child: Text(
                            "${_selectedImages.length} ${AppStrings.get('imagesSelected')}",
                            style: const TextStyle(
                              color: AppTheme.primaryGreen,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                ),
              ),
              const SizedBox(height: 16),

              TextFormField(
                controller: _titleController,
                decoration: InputDecoration(
                  labelText: AppStrings.get('equipmentTitle'),
                  prefixIcon: const Icon(Icons.title),
                ),
                validator: (val) => val!.isEmpty ? AppStrings.get('somethingWrong') : null,
              ),
              const SizedBox(height: 12),

              DropdownButtonFormField<String>(
                initialValue: _selectedCategory,
                decoration: InputDecoration(
                  labelText: AppStrings.get('category'),
                  prefixIcon: const Icon(Icons.category),
                ),
                items: _categories.map((String cat) {
                  return DropdownMenuItem<String>(
                    value: cat,
                    child: Text(cat),
                  );
                }).toList(),
                onChanged: (String? val) {
                  if (val != null) {
                    setState(() => _selectedCategory = val);
                  }
                },
              ),
              const SizedBox(height: 12),

              Row(
                children: [
                  Expanded(
                    child: TextFormField(
                      controller: _hourlyRateController,
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                        labelText: AppStrings.get('hourlyRate'),
                      ),
                      validator: (val) => val!.isEmpty ? "Enter rate" : null,
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: TextFormField(
                      controller: _dailyRateController,
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                        labelText: AppStrings.get('dailyRate'),
                      ),
                      validator: (val) => val!.isEmpty ? "Enter rate" : null,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 12),

              TextFormField(
                controller: _descController,
                maxLines: 3,
                decoration: InputDecoration(
                  labelText: AppStrings.get('description'),
                  prefixIcon: const Icon(Icons.description),
                ),
                validator: (val) => val!.isEmpty ? "Enter description" : null,
              ),
              const SizedBox(height: 24),

              _isLoading
                  ? const Center(child: CircularProgressIndicator())
                  : ElevatedButton(
                      onPressed: _submitEquipment,
                      child: Text(
                        AppStrings.get('publishEquipment'),
                        style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                    ),
            ],
          ),
        ),
      ),
    );
  }
}