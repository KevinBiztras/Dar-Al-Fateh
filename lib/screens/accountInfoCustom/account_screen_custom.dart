import 'package:flutter/material.dart';
import 'package:flutter_project_structure/customWidgtes/app_bar.dart';
import 'package:flutter_project_structure/constants/app_string_constant.dart';
import 'package:flutter_project_structure/constants/app_constants.dart';
import 'package:flutter_project_structure/helper/app_localizations.dart';
import 'package:flutter_project_structure/screens/accountInfoCustom/views/list_tile_widget.dart';
import 'package:flutter_project_structure/screens/accountInfoCustom/views/newsletter_card.dart';
import 'package:flutter_project_structure/screens/accountInfoCustom/views/profile_drawer.dart';

class AccountScreenCustom extends StatelessWidget {
  const AccountScreenCustom({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: commonAppBar(
        'Profile',
        context,
        actions: [
          IconButton(
            onPressed: () {},
            icon: Icon(Icons.logout, color: AppColors.red),
          ),
          Builder(
            builder: (context) => IconButton(
              icon: Icon(Icons.person, color: AppColors.green),
              onPressed: () => Scaffold.of(context).openEndDrawer(),
            ),
          ),
        ],
      ),
      endDrawer: ProfileDrawer(
        fullName: 'Sukreth O M',
        email: 'sukrethom2000@gmail.com',
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: CustomScrollView(
            slivers: [
              SliverList.separated(
                itemCount: orderItems.length,
                itemBuilder: (context, index) {
                  final item = orderItems[index];
                  return CustomListTileCard(
                    title: item['title'],
                    subtitle: item['subtitle'],
                    image: item['image'],
                    onTap: () {},
                  );
                },
                separatorBuilder: (context, index) =>
                    const SizedBox(height: 10),
              ),
              const SliverToBoxAdapter(child: SizedBox(height: 50)),
              const SliverToBoxAdapter(
                child: SizedBox(width: double.infinity, child: SubscribeCard()),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
