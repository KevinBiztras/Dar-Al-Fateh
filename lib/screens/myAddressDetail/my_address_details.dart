import 'package:flutter/material.dart';
import 'package:flutter_project_structure/constants/app_constants.dart';
import 'package:flutter_project_structure/helper/app_localizations.dart';

import '../../constants/app_string_constant.dart';

class MyAddressDetails extends StatefulWidget {
  final Map<String, dynamic> address;

  const MyAddressDetails({super.key, required this.address});

  @override
  State<MyAddressDetails> createState() => _MyAddressDetailsState();
}

class _MyAddressDetailsState extends State<MyAddressDetails> {
  AppLocalizations? _localizations;
  final _formKey = GlobalKey<FormState>();
  final TextEditingController addressTypeController = TextEditingController();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController addressController = TextEditingController();
  final TextEditingController cityController = TextEditingController();

  @override
  void didChangeDependencies() {
    _localizations = AppLocalizations.of(context);
    super.didChangeDependencies();
  }

  @override
  void initState() {
    super.initState();
    addressTypeController.text = widget.address['type'] ?? '';
    nameController.text = widget.address['name'] ?? '';
    phoneController.text = widget.address['phone'] ?? '';
    addressController.text = widget.address['address'] ?? '';
    cityController.text = widget.address['city'] ?? '';
  }

  @override
  void dispose() {
    nameController.dispose();
    phoneController.dispose();
    addressController.dispose();
    cityController.dispose();
    super.dispose();
  }

  void _saveAddress() {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    final updatedAddress = {
      'type': addressTypeController.text.trim(),
      'name': nameController.text.trim(),
      'phone': phoneController.text.trim(),
      'address': addressController.text.trim(),
      'city': cityController.text.trim(),
    };
    Navigator.pop(context, updatedAddress);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_localizations?.translate(AppStringConstant.address) ?? ''),
        centerTitle: true,
      ),

      body: Form(
        key: _formKey,
        child: ListView(
          padding: const EdgeInsets.all(16),
          children: [
            // Address Type
            const Text(
              'Address Type',
              style: TextStyle(fontSize: 15, fontWeight: FontWeight.w600),
            ),

            const SizedBox(height: 8),

            TextFormField(
              controller: addressTypeController,
              textInputAction: TextInputAction.next,
              decoration: const InputDecoration(
                hintText: 'Enter your address type',
                hintStyle: TextStyle(fontSize: 15),
                border: OutlineInputBorder(),
              ),
              validator: (value) {
                if (value == null || value.trim().isEmpty) {
                  return 'Please enter your name';
                }
                return null;
              },
            ),

            const SizedBox(height: 24),

            // Name
            _buildLabel('Full Name'),

            const SizedBox(height: 8),

            TextFormField(
              controller: nameController,
              textInputAction: TextInputAction.next,
              decoration: const InputDecoration(
                hintText: 'Enter your name',
                hintStyle: TextStyle(fontSize: 15),
                border: OutlineInputBorder(),
              ),
              validator: (value) {
                if (value == null || value.trim().isEmpty) {
                  return 'Please enter your name';
                }
                return null;
              },
            ),

            const SizedBox(height: 18),

            // Phone
            _buildLabel('Phone Number'),

            const SizedBox(height: 8),

            TextFormField(
              controller: phoneController,
              keyboardType: TextInputType.phone,
              textInputAction: TextInputAction.next,
              decoration: const InputDecoration(
                hintText: '+91 98765 43210',
                hintStyle: TextStyle(fontSize: 15),
                border: OutlineInputBorder(),
              ),
              validator: (value) {
                if (value == null || value.trim().isEmpty) {
                  return 'Please enter your phone number';
                }
                return null;
              },
            ),

            const SizedBox(height: 18),

            // Address
            _buildLabel('Address'),

            const SizedBox(height: 8),

            TextFormField(
              controller: addressController,
              maxLines: 3,
              textInputAction: TextInputAction.next,
              decoration: const InputDecoration(
                hintText: 'House No, Street, Area',
                hintStyle: TextStyle(fontSize: 15),
                border: OutlineInputBorder(),
              ),
              validator: (value) {
                if (value == null || value.trim().isEmpty) {
                  return 'Please enter your address';
                }
                return null;
              },
            ),

            const SizedBox(height: 18),

            // City / State / Pincode
            _buildLabel('City, State & Pincode'),

            const SizedBox(height: 8),

            TextFormField(
              controller: cityController,
              textInputAction: TextInputAction.done,
              decoration: const InputDecoration(
                hintText: 'Hyderabad, Telangana - 500001',
                hintStyle: TextStyle(fontSize: 15),
                border: OutlineInputBorder(),
              ),
              validator: (value) {
                if (value == null || value.trim().isEmpty) {
                  return 'Please enter city, state and pincode';
                }
                return null;
              },
            ),

            const SizedBox(height: 30),

            // Save Button
            SizedBox(
              height: 52,
              child: ElevatedButton(
                onPressed: _saveAddress,
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.green,
                  foregroundColor: AppColors.white,
                ),
                child: const Text(
                  'Save Address',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildLabel(String title) {
    return Text(
      title,
      style: const TextStyle(fontSize: 15, fontWeight: FontWeight.w600),
    );
  }
}
