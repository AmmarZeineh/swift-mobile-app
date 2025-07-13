import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:swift_mobile_app/core/utils/app_colors.dart';

class NavBar extends StatelessWidget {
  final int selectedIndex;
  final ValueChanged<int> onTabChange;

  const NavBar({
    super.key,
    required this.selectedIndex,
    required this.onTabChange,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12),
        child: GNav(
          backgroundColor: Colors.white,
          color: AppColors.secondaryColor,
          activeColor: AppColors.backgroundColor,
          tabBackgroundColor: AppColors.primaryColor,
          padding: const EdgeInsets.all(20),
          gap: 8,
          selectedIndex: selectedIndex,
          onTabChange: onTabChange,
          tabs: const [
            GButton(icon: Icons.home, text: "الرئيسية"),
            GButton(icon: FontAwesomeIcons.box, text: "الطلبات"),
            GButton(icon: Icons.person, text: " الحساب"),
          ],
        ),
      ),
    );
  }
}
