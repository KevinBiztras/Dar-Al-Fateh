


import 'package:flutter/material.dart';
import 'package:flutter_project_structure/constants/app_constants.dart';

class AddMyAddress extends StatefulWidget {
  final List<Map<String, dynamic>> addresses;

  const AddMyAddress({super.key, required this.addresses});

  @override
  State<AddMyAddress> createState() => _AddMyAddressState();
}

class _AddMyAddressState extends State<AddMyAddress> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController addressTypeController = TextEditingController();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController addressController = TextEditingController();
  final TextEditingController cityController = TextEditingController();

  static const Color _background = Color(0xFFF8F7F2);
  static const Color _textPrimary = Color(0xFF29362D);
  static const Color _textSecondary = Color(0xFF798077);
  static const Color _border = Color(0xFFE7E9DF);
  static const Color _fieldBackground = Color(0xFFFAFBF8);

  @override
  void dispose() {
    addressTypeController.dispose();
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

    final newAddress = {
      'type': addressTypeController.text.trim(),
      'name': nameController.text.trim(),
      'phone': phoneController.text.trim(),
      'address': addressController.text.trim(),
      'city': cityController.text.trim(),
    };

    widget.addresses.add(newAddress);
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: _background,
      appBar: AppBar(
        title: const Text(
          'Add Address',
          style: TextStyle(
            color: _textPrimary,
            fontSize: 20,
            fontWeight: FontWeight.w700,
          ),
        ),
        centerTitle: true,
        backgroundColor: _background,
        surfaceTintColor: Colors.transparent,
        foregroundColor: _textPrimary,
        elevation: 0,
        scrolledUnderElevation: 0,
        toolbarHeight: 68,
        iconTheme: const IconThemeData(
          color: _textPrimary,
          size: 22,
        ),
      ),
      body: SafeArea(
        top: false,
        child: Form(
          key: _formKey,
          child: ListView(
            padding: const EdgeInsets.fromLTRB(20, 16, 20, 28),
            keyboardDismissBehavior:
                ScrollViewKeyboardDismissBehavior.onDrag,
            children: [
              _buildIntroduction(),
              const SizedBox(height: 26),

              Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(24),
                  border: Border.all(color: _border),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.03),
                      blurRadius: 20,
                      offset: const Offset(0, 6),
                    ),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildSectionHeading(
                      icon: Icons.person_outline_rounded,
                      title: 'Contact details',
                    ),
                    const SizedBox(height: 22),

                    _buildLabel('Address Type'),
                    const SizedBox(height: 8),
                    TextFormField(
                      controller: addressTypeController,
                      textInputAction: TextInputAction.next,
                      cursorColor: AppColors.green,
                      style: _inputTextStyle,
                      decoration: _inputDecoration(
                        hint: 'Enter your address type',
                        icon: Icons.home_outlined,
                      ),
                      validator: (value) {
                        if (value == null || value.trim().isEmpty) {
                          return 'Please enter your name';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 20),

                    _buildLabel('Full Name'),
                    const SizedBox(height: 8),
                    TextFormField(
                      controller: nameController,
                      textInputAction: TextInputAction.next,
                      cursorColor: AppColors.green,
                      style: _inputTextStyle,
                      decoration: _inputDecoration(
                        hint: 'Enter your name',
                        icon: Icons.person_outline_rounded,
                      ),
                      validator: (value) {
                        if (value == null || value.trim().isEmpty) {
                          return 'Please enter your name';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 20),

                    _buildLabel('Phone Number'),
                    const SizedBox(height: 8),
                    TextFormField(
                      controller: phoneController,
                      keyboardType: TextInputType.phone,
                      textInputAction: TextInputAction.next,
                      cursorColor: AppColors.green,
                      style: _inputTextStyle,
                      decoration: _inputDecoration(
                        hint: '+91 98765 43210',
                        icon: Icons.phone_outlined,
                      ),
                      validator: (value) {
                        if (value == null || value.trim().isEmpty) {
                          return 'Please enter your phone number';
                        }
                        return null;
                      },
                    ),

                    const Padding(
                      padding: EdgeInsets.symmetric(vertical: 26),
                      child: Divider(
                        height: 1,
                        thickness: 1,
                        color: _border,
                      ),
                    ),

                    _buildSectionHeading(
                      icon: Icons.location_on_outlined,
                      title: 'Delivery address',
                    ),
                    const SizedBox(height: 22),

                    _buildLabel('Address'),
                    const SizedBox(height: 8),
                    TextFormField(
                      controller: addressController,
                      maxLines: 3,
                      textInputAction: TextInputAction.next,
                      cursorColor: AppColors.green,
                      style: _inputTextStyle,
                      decoration: _inputDecoration(
                        hint: 'House No, Street, Area',
                      ),
                      validator: (value) {
                        if (value == null || value.trim().isEmpty) {
                          return 'Please enter your address';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 20),

                    _buildLabel('City, State & Pincode'),
                    const SizedBox(height: 8),
                    TextFormField(
                      controller: cityController,
                      textInputAction: TextInputAction.done,
                      cursorColor: AppColors.green,
                      style: _inputTextStyle,
                      decoration: _inputDecoration(
                        hint: 'Hyderabad, Telangana - 500001',
                        icon: Icons.location_city_outlined,
                      ),
                      validator: (value) {
                        if (value == null || value.trim().isEmpty) {
                          return 'Please enter city, state and pincode';
                        }
                        return null;
                      },
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 26),

              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: _saveAddress,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.green,
                    foregroundColor: AppColors.white,
                    elevation: 0,
                    minimumSize: const Size(0, 56),
                    padding: const EdgeInsets.symmetric(
                      horizontal: 24,
                      vertical: 16,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                  ),
                  child: const Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.check_rounded, size: 21),
                      SizedBox(width: 10),
                      Flexible(
                        child: Text(
                          'Save Address',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildIntroduction() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: 58,
          height: 58,
          decoration: BoxDecoration(
            color: AppColors.green.withOpacity(0.08),
            borderRadius: BorderRadius.circular(18),
          ),
          child: Icon(
            Icons.add_location_alt_outlined,
            color: AppColors.green,
            size: 29,
          ),
        ),
        const SizedBox(height: 18),
        const Text(
          'Add a new address',
          style: TextStyle(
            color: _textPrimary,
            fontSize: 26,
            fontWeight: FontWeight.w700,
            letterSpacing: -0.5,
          ),
        ),
        const SizedBox(height: 8),
        const Text(
          'Save your delivery details for a smoother checkout.',
          style: TextStyle(
            color: _textSecondary,
            fontSize: 14,
            height: 1.6,
          ),
        ),
      ],
    );
  }

  Widget _buildSectionHeading({
    required IconData icon,
    required String title,
  }) {
    return Row(
      children: [
        Icon(
          icon,
          color: AppColors.green,
          size: 21,
        ),
        const SizedBox(width: 10),
        Expanded(
          child: Text(
            title,
            style: const TextStyle(
              color: _textPrimary,
              fontSize: 16,
              fontWeight: FontWeight.w700,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildLabel(String title) {
    return Text(
      title,
      style: const TextStyle(
        color: _textPrimary,
        fontSize: 14,
        fontWeight: FontWeight.w600,
      ),
    );
  }

  TextStyle get _inputTextStyle => const TextStyle(
        color: _textPrimary,
        fontSize: 15,
        height: 1.4,
      );

  InputDecoration _inputDecoration({
    required String hint,
    IconData? icon,
  }) {
    return InputDecoration(
      hintText: hint,
      hintStyle: const TextStyle(
        color: Color(0xFF9AA195),
        fontSize: 14,
        fontWeight: FontWeight.w400,
      ),
      filled: true,
      fillColor: _fieldBackground,
      contentPadding: const EdgeInsets.symmetric(
        horizontal: 16,
        vertical: 17,
      ),
      prefixIcon: icon == null
          ? null
          : Icon(
              icon,
              color: _textSecondary,
              size: 21,
            ),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(14),
        borderSide: const BorderSide(color: _border),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(14),
        borderSide: const BorderSide(color: _border),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(14),
        borderSide: BorderSide(
          color: AppColors.green,
          width: 1.5,
        ),
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(14),
        borderSide: const BorderSide(
          color: Color(0xFFC65B50),
        ),
      ),
      focusedErrorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(14),
        borderSide: const BorderSide(
          color: Color(0xFFC65B50),
          width: 1.5,
        ),
      ),
      errorStyle: const TextStyle(
        color: Color(0xFFC65B50),
        fontSize: 12,
      ),
      errorMaxLines: 3,
    );
  }
}