import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:swift_mobile_app/core/utils/app_colors.dart';

class NavBar extends StatelessWidget {
  const NavBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12),
        child: GNav(
          backgroundColor: Colors.white,
          color: Colors.black,
          activeColor: AppColors.secondaryColor,
          tabBackgroundColor: AppColors.primaryColor,
          padding: EdgeInsets.all(20),
          gap: 8,
          tabs: const [
            GButton(icon: Icons.home, text: "Home", ),
            GButton(icon: Icons.favorite, text: "Favorites"),
            GButton(icon: Icons.person, text: "Profile"),
          ],
        ),
      ),
    );
  }
}
