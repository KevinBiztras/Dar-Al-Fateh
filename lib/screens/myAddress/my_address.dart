


import 'package:flutter/material.dart';
import 'package:flutter_project_structure/constants/app_constants.dart';
import 'package:flutter_project_structure/constants/app_string_constant.dart';
import 'package:flutter_project_structure/helper/app_localizations.dart';
import 'package:flutter_project_structure/screens/addMyAddress/add_my_address.dart';
import 'package:flutter_project_structure/screens/myAddressDetail/my_address_details.dart';

class MyAddress extends StatefulWidget {
  const MyAddress({super.key});

  @override
  State<MyAddress> createState() => _MyAddressState();
}

class _MyAddressState extends State<MyAddress> {
  AppLocalizations? _localizations;

  static const Color _background = Color(0xFFF8F7F2);
  static const Color _textPrimary = Color(0xFF29362D);
  static const Color _textSecondary = Color(0xFF798077);
  static const Color _border = Color(0xFFE7E9DF);
  static const Color _brown = Color(0xFF8B6B4A);

  @override
  void didChangeDependencies() {
    _localizations = AppLocalizations.of(context);
    super.didChangeDependencies();
  }

  final List<Map<String, dynamic>> addresses = [
    {
      'type': 'Home',
      'name': 'Your Name',
      'phone': '+91 98765 43210',
      'address': '12-4-56, Main Road, Hyderabad',
      'city': 'Telangana - 500001',
    },
    {
      'type': 'Office',
      'name': 'Your Name',
      'phone': '+91 98765 43210',
      'address': 'Tech Park, Hitech City',
      'city': 'Hyderabad, Telangana - 500081',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: _background,
      appBar: AppBar(
        backgroundColor: _background,
        surfaceTintColor: Colors.transparent,
        foregroundColor: _textPrimary,
        elevation: 0,
        scrolledUnderElevation: 0,
        centerTitle: true,
        toolbarHeight: 68,
        title: Text(
          _localizations?.translate(AppStringConstant.addressBook) ?? '',
          style: const TextStyle(
            color: _textPrimary,
            fontSize: 20,
            fontWeight: FontWeight.w700,
          ),
        ),
        iconTheme: const IconThemeData(
          color: _textPrimary,
          size: 22,
        ),
      ),
      body: SafeArea(
        top: false,
        child: addresses.isEmpty
            ? _buildEmptyState()
            : ListView.builder(
                padding: const EdgeInsets.fromLTRB(20, 12, 20, 110),
                itemCount: addresses.length + 1,
                itemBuilder: (context, index) {
                  if (index == 0) {
                    return _buildIntroduction();
                  }

                  final addressIndex = index - 1;
                  final address = addresses[addressIndex];

                  return _buildAddressCard(
                    index: addressIndex,
                    address: address,
                  );
                },
              ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => AddMyAddress(addresses: addresses),
            ),
          ).then((_) {
            setState(() {});
          });
        },
        backgroundColor: AppColors.green,
        foregroundColor: AppColors.white,
        elevation: 3,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(18),
        ),
        icon: const Icon(Icons.add_rounded, size: 24),
        label: const Text(
          'Add new address',
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }

  Widget _buildIntroduction() {
    return Padding(
      padding: const EdgeInsets.only(top: 8, bottom: 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Your saved addresses',
            style: TextStyle(
              color: _textPrimary,
              fontSize: 25,
              fontWeight: FontWeight.w700,
              letterSpacing: -0.5,
            ),
          ),
          const SizedBox(height: 8),
          const Text(
            'Keep your delivery details in one place.',
            style: TextStyle(
              color: _textSecondary,
              fontSize: 14,
              height: 1.5,
            ),
          ),
          const SizedBox(height: 16),
          Container(
            padding: const EdgeInsets.symmetric(
              horizontal: 12,
              vertical: 7,
            ),
            decoration: BoxDecoration(
              color: AppColors.green.withOpacity(0.08),
              borderRadius: BorderRadius.circular(20),
            ),
            child: Text(
              '${addresses.length} saved '
              '${addresses.length == 1 ? 'address' : 'addresses'}',
              style: TextStyle(
                color: AppColors.green,
                fontSize: 12,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAddressCard({
    required int index,
    required Map<String, dynamic> address,
  }) {
    final bool isHome = address['type'] == 'Home';

    return Padding(
      padding: const EdgeInsets.only(bottom: 18),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(22),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.035),
              blurRadius: 20,
              offset: const Offset(0, 6),
            ),
          ],
        ),
        child: Material(
          color: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(22),
            side: const BorderSide(color: _border),
          ),
          clipBehavior: Clip.antiAlias,
          child: InkWell(
            onTap: () async {
              final updatedAddress = await Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => MyAddressDetails(address: address),
                ),
              );

              if (updatedAddress != null) {
                setState(() {
                  addresses[index] = updatedAddress;
                });
              }
            },
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Container(
                        width: 48,
                        height: 48,
                        decoration: BoxDecoration(
                          color: AppColors.green.withOpacity(0.08),
                          borderRadius: BorderRadius.circular(15),
                        ),
                        child: Icon(
                          isHome
                              ? Icons.home_outlined
                              : Icons.business_outlined,
                          color: AppColors.green,
                          size: 25,
                        ),
                      ),
                      const SizedBox(width: 13),
                      Expanded(
                        child: Text(
                          address['type'],
                          style: const TextStyle(
                            color: _textPrimary,
                            fontSize: 18,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ),
                      IconButton(
                        // Original callback preserved.
                        onPressed: () {},
                        tooltip: 'Delete address',
                        style: IconButton.styleFrom(
                          backgroundColor: const Color(0xFFFCF3EF),
                          foregroundColor: const Color(0xFFB77B65),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                        icon: const Icon(
                          Icons.delete_outline_rounded,
                          size: 21,
                        ),
                      ),
                    ],
                  ),
                  const Padding(
                    padding: EdgeInsets.symmetric(vertical: 18),
                    child: Divider(
                      height: 1,
                      thickness: 1,
                      color: _border,
                    ),
                  ),
                  Text(
                    address['name'],
                    style: const TextStyle(
                      color: _textPrimary,
                      fontSize: 17,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 15),
                  _buildDetailRow(
                    icon: Icons.phone_outlined,
                    child: Text(
                      address['phone'],
                      style: const TextStyle(
                        color: _textSecondary,
                        fontSize: 14,
                        height: 1.5,
                      ),
                    ),
                  ),
                  const SizedBox(height: 12),
                  _buildDetailRow(
                    icon: Icons.location_on_outlined,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          address['address'],
                          style: const TextStyle(
                            color: _textSecondary,
                            fontSize: 14,
                            height: 1.6,
                          ),
                        ),
                        const SizedBox(height: 2),
                        Text(
                          address['city'],
                          style: const TextStyle(
                            color: _textSecondary,
                            fontSize: 14,
                            height: 1.6,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 20),
                  const Row(
                    children: [
                      Expanded(
                        child: Text(
                          'View address details',
                          style: TextStyle(
                            color: _brown,
                            fontSize: 13,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                      Icon(
                        Icons.arrow_forward_rounded,
                        color: _brown,
                        size: 18,
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildDetailRow({
    required IconData icon,
    required Widget child,
  }) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 2),
          child: Icon(
            icon,
            size: 19,
            color: _textSecondary,
          ),
        ),
        const SizedBox(width: 10),
        Expanded(child: child),
      ],
    );
  }

  Widget _buildEmptyState() {
    return LayoutBuilder(
      builder: (context, constraints) {
        return SingleChildScrollView(
          padding: const EdgeInsets.fromLTRB(28, 24, 28, 110),
          child: ConstrainedBox(
            constraints: BoxConstraints(
              minHeight: constraints.maxHeight > 134
                  ? constraints.maxHeight - 134
                  : 0,
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  width: 116,
                  height: 116,
                  decoration: BoxDecoration(
                    color: AppColors.green.withOpacity(0.08),
                    shape: BoxShape.circle,
                  ),
                  child: Center(
                    child: Container(
                      width: 82,
                      height: 82,
                      decoration: const BoxDecoration(
                        color: Colors.white,
                        shape: BoxShape.circle,
                      ),
                      child: Icon(
                        Icons.location_on_outlined,
                        size: 42,
                        color: AppColors.green,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 26),
                const Text(
                  'No addresses saved',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: _textPrimary,
                    fontSize: 23,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const SizedBox(height: 10),
                const Text(
                  'Add your home or office address\n'
                  'for a smoother checkout.',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: _textSecondary,
                    fontSize: 15,
                    height: 1.6,
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
