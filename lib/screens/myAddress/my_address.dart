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
      appBar: 
      AppBar(
        title: Text(
          _localizations?.translate(AppStringConstant.addressBook) ?? '',
        ),
        centerTitle: true,
      ),

      body: addresses.isEmpty
          ? _buildEmptyState()
          : ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: addresses.length,
              itemBuilder: (context, index) {
                final address = addresses[index];
                return _buildAddressCard(index: index, address: address);
              },
            ),

      floatingActionButton: FloatingActionButton(
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
        child: Icon(Icons.add),
      ),
    );
  }

  Widget _buildAddressCard({
    required int index,
    required Map<String, dynamic> address,
  }) {
    return InkWell(
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
      child: Container(
        margin: const EdgeInsets.only(bottom: 14),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          border: Border.all(color: Colors.grey.shade300, width: 1),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header
            Row(
              children: [
                const SizedBox(width: 4),
                Icon(
                  address['type'] == 'Home'
                      ? Icons.home_outlined
                      : Icons.business_outlined,
                ),
                const SizedBox(width: 8),

                Text(
                  address['type'],
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),

                const Spacer(),

                IconButton(onPressed: () {}, icon: Icon(Icons.delete)),
              ],
            ),

            const Divider(height: 20),

            // Name
            Text(
              address['name'],
              style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 15),
            ),

            const SizedBox(height: 6),

            // Phone
            Text(
              address['phone'],
              style: TextStyle(color: Colors.grey.shade700),
            ),

            const SizedBox(height: 6),

            // Address
            Text(
              address['address'],
              style: TextStyle(color: Colors.grey.shade700, height: 1.4),
            ),

            Text(
              address['city'],
              style: TextStyle(color: Colors.grey.shade700, height: 1.4),
            ),

            const SizedBox(height: 12),

            // Actions
          ],
        ),
      ),
    );
  }

  Widget _buildEmptyState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.location_on_outlined,
            size: 70,
            color: Colors.grey.shade400,
          ),

          const SizedBox(height: 16),

          const Text(
            'No addresses saved',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
          ),

          const SizedBox(height: 8),

          Text(
            'Add an address for faster checkout',
            style: TextStyle(color: Colors.grey.shade600),
          ),
        ],
      ),
    );
  }
}
