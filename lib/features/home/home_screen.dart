import 'package:flutter/material.dart';
import '../../constrants/Appconstraints.dart';
import 'uiModel/NavItems.dart';
import '../../core/resources/app_colors.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.homepageColor,
      body: SafeArea(
        child: AppUiConstants.bottomNavItems[_selectedIndex].page,
      ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: AppColors.globalDarkMode,
        currentIndex: _selectedIndex,
        type: BottomNavigationBarType.fixed,
        selectedItemColor: AppColors.greenIcon,
        unselectedItemColor: AppColors.whiteIcon,
        onTap: (index) {
          setState(() {
            _selectedIndex = index;
          });
        },
        items: AppUiConstants.bottomNavItems
            .map((e) => BottomNavigationBarItem(
          icon: Icon(e.icon),
          label: e.label,
        ))
            .toList(),
      ),
    );
  }
}
