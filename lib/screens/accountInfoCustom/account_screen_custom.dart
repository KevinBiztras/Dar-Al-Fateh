import 'package:flutter/material.dart';
import 'package:flutter_project_structure/constants/route_constant.dart';
import 'package:flutter_project_structure/customWidgtes/app_bar.dart';
import 'package:flutter_project_structure/constants/app_string_constant.dart';
import 'package:flutter_project_structure/constants/app_constants.dart';
import 'package:flutter_project_structure/helper/app_localizations.dart';
import 'package:flutter_project_structure/screens/accountInfoCustom/views/list_tile_widget.dart';
import 'package:flutter_project_structure/screens/accountInfoCustom/views/profile_drawer.dart';

const List<Map<String, dynamic>> orderItems = [
  {
    'title': 'Your Orders',
    'subtitle': 'Follow, view or pay your orders',
    'image': 'lib/assets/images/bag.png',
  },
  {
    'title': 'Your Invoices',
    'subtitle': 'Follow, download or pay your invoices',
    'image': 'lib/assets/images/bill.png',
  },
  {
    'title': 'Connection & Security',
    'subtitle': 'Configure your connection parameters',
    'image': 'lib/assets/images/portal-connection.png',
  },
  {
    'title': 'My Address',
    'subtitle': 'Configure your connection parameters',
    'image': 'lib/assets/images/location.png',
  },
  {
    'title': 'Sign In or Sign Up',
    'subtitle': 'Configure your connection parameters',
    'image': 'lib/assets/images/login.png',
  },
];

class AccountScreenCustom extends StatefulWidget {
  const AccountScreenCustom({super.key});

  @override
  State<AccountScreenCustom> createState() => _AccountScreenCustomState();
}

class _AccountScreenCustomState extends State<AccountScreenCustom> {
  AppLocalizations? _localizations;

  @override
  void didChangeDependencies() {
    _localizations = AppLocalizations.of(context);
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: commonAppBar(
        _localizations?.translate(AppStringConstant.profile) ?? '',
        context,
        actions: [
          Builder(
            builder: (context) => IconButton(
              icon: Icon(Icons.person, color: AppColors.green),
              onPressed: () => Scaffold.of(context).openEndDrawer(),
            ),
          ),
        ],
      ),
      endDrawer: ProfileDrawer(fullName: 'Your Name', email: 'Your email'),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: CustomScrollView(
            slivers: [
              SliverList(
                delegate: SliverChildListDelegate([
                  CustomListTileCard(
                    title: 'Your Orders',
                    subtitle: 'Follow, view or pay your orders',
                    image: 'lib/assets/images/bag.png',
                    onTap: () {},
                  ),

                  const SizedBox(height: 10),

                  CustomListTileCard(
                    title: 'Your Invoices',
                    subtitle: 'Follow, download or pay your invoices',
                    image: 'lib/assets/images/bill.png',
                    onTap: () {},
                  ),

                  const SizedBox(height: 10),

                  CustomListTileCard(
                    title: 'Connection & Security',
                    subtitle: 'Configure your connection parameters',
                    image: 'lib/assets/images/portal-connection.png',
                    onTap: () {},
                  ),

                  const SizedBox(height: 40),

                  CustomListTileCard(
                    title: 'My Address',
                    subtitle: 'Manage your delivery and billing addresses',
                    image: 'lib/assets/images/location.png',
                    onTap: () {},
                  ),

                  const SizedBox(height: 10),

                  CustomListTileCard(
                    title: 'Sign In or Sign Up',
                    subtitle: 'Access your account and manage your profile',
                    image: 'lib/assets/images/login.png',
                    onTap: () {
                      Navigator.of(
                        context,
                      ).pushNamed(loginSignup, arguments: false);
                    },
                  ),

                  const SizedBox(height: 50),
                ]),
              ),
            ],
          ),
        ),
      ),
      // SafeArea(
      //   child: CustomScrollView(
      //     slivers: [
      //       SliverList(
      //         delegate: SliverChildListDelegate([
      //           const SizedBox(height: 8),

      //           // Profile header
      //           ProfileHeader(
      //             name: 'Your Name',
      //             imageUrl: 'lib/assets/images/profile_avatar.png',
      //             email:
      //                 _localizations?.translate(AppStringConstant.email) ?? '',
      //             buttonText: 'LOG IN',
      //             buttonAction: () {
      //               Navigator.of(
      //                 context,
      //               ).pushNamed(loginSignup, arguments: false);
      //             },
      //           ),

      //           const SizedBox(height: 20),

      //           Padding(
      //             padding: const EdgeInsets.symmetric(horizontal: 16),
      //             child: Column(
      //               crossAxisAlignment: CrossAxisAlignment.start,
      //               children: [
      //                 const SectionTitle(title: 'Your Travel Profile'),
      //                 const SizedBox(height: 12),

      //                 CustomListTileCard(
      //                   title: 'Your Orders',
      //                   subtitle: 'Follow, view or pay your orders',
      //                   icon: Icons.shopping_bag,
      //                   iconBgColor: const Color(0xFFFFEDD5),
      //                   iconColor: const Color(0xFFF59E0B),
      //                   onTap: () {},
      //                 ),
      //                 const SizedBox(height: 10),

      //                 CustomListTileCard(
      //                   title: 'Your Invoices',
      //                   subtitle: 'Follow, download or pay your invoices',
      //                   icon: Icons.receipt_long,
      //                   iconBgColor: const Color(0xFFFEE2E2),
      //                   iconColor: const Color(0xFFEF4444),
      //                   onTap: () {},
      //                 ),
      //                 const SizedBox(height: 10),

      //                 CustomListTileCard(
      //                   title: 'My Address',
      //                   subtitle: 'Configure your connection parameters',
      //                   icon: Icons.location_on,
      //                   iconBgColor: const Color(0xFFE0E7FF),
      //                   iconColor: const Color(0xFF6366F1),
      //                   onTap: () {},
      //                 ),

      //                 const SizedBox(height: 24),

      //                 const SectionTitle(title: 'Your Preferences'),
      //                 const SizedBox(height: 12),

      //                 CustomListTileCard(
      //                   title: 'Connection & Security',
      //                   subtitle: 'Configure your connection parameters',
      //                   icon: Icons.connect_without_contact,
      //                   iconBgColor: const Color(0xFFE0E7FF),
      //                   iconColor: const Color(0xFF6366F1),
      //                   onTap: () {},
      //                 ),
      //                 const SizedBox(height: 10),

      //                 CustomListTileCard(
      //                   title: 'Contact Us',
      //                   subtitle: 'For any enquiry',
      //                   icon: Icons.phone,
      //                   iconBgColor: const Color(0xFFFEF3C7),
      //                   iconColor: const Color(0xFFF59E0B),
      //                   onTap: () {},
      //                 ),
      //                 const SizedBox(height: 10),

      //                 CustomListTileCard(
      //                   title: 'Language',
      //                   subtitle: 'English',
      //                   icon: Icons.language,
      //                   iconBgColor: const Color(0xFFDCFCE7),
      //                   iconColor: const Color(0xFF22C55E),
      //                   onTap: () {},
      //                 ),

      //                 const SizedBox(height: 24),

      //                 const SectionTitle(title: 'Your Travel Profile'),
      //                 const SizedBox(height: 12),

      //                 CustomListTileCard(
      //                   title: 'Settings',
      //                   subtitle: 'Customize your app',
      //                   icon: Icons.settings,
      //                   iconBgColor: const Color(0xFFE0E7FF),
      //                   iconColor: const Color(0xFF6366F1),
      //                   onTap: () {
      //                     showSettingBottomSheet(context);
      //                   },
      //                 ),
      //                 const SizedBox(height: 10),

      //                 CustomListTileCard(
      //                   title: 'Log Out',
      //                   subtitle: 'Customize your app',
      //                   icon: Icons.logout,
      //                   iconBgColor: const Color(0xFFFEE2E2),
      //                   iconColor: const Color(0xFFEF4444),
      //                   onTap: () {},
      //                 ),
      //                 const SizedBox(height: 50),
      //               ],
      //             ),
      //           ),
      //         ]),
      //       ),
      //     ],
      //   ),
      // ),
    );
  }
}
