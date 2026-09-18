import 'package:flutter/material.dart';
import 'package:flutter_project_structure/constants/app_constants.dart';

class ProfileDrawer extends StatelessWidget {
  final String fullName;
  final String email;
  
  const ProfileDrawer({super.key, required this.fullName, required this.email});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          UserAccountsDrawerHeader(
            accountName: Text(
              fullName,
              style: TextStyle(color: AppColors.black),
            ),
            accountEmail: Text(email),
            currentAccountPicture: CircleAvatar(child: Icon(Icons.person)),
          ),
          ListTile(
            leading: const Icon(Icons.mail),
            title: Text(email),
            onTap: () {},
          ),
          ListTile(
            leading: const Icon(Icons.edit),
            title: const Text('Edit Information'),
            onTap: () {},
          ),
          ListTile(
            leading: const Icon(Icons.logout),
            title: const Text('Logout'),
            onTap: () {},
          ),
        ],
      ),
    );
  }
}
