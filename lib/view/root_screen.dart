// File: view/screens/root_screen.dart
import 'package:flutter/material.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:provider/provider.dart';
import 'package:task/constance/color_constant.dart';
import 'package:task/view/profile_screen.dart';
import 'package:task/view_model/root_view_model.dart';
import 'home_screen.dart';


class RootScreen extends StatelessWidget {
   RootScreen({super.key});

  final List<Widget> _screens =  [
    HomeScreen(),
    Scaffold(),
    Scaffold(),
    ProfileScreen()
  ];

  @override
  Widget build(BuildContext context) {
    final viewModel = Provider.of<RootViewModel>(context);

    return Scaffold(
      body: _screens[viewModel.currentIndex],
      bottomNavigationBar: BottomNavigationBar(
  currentIndex: viewModel.currentIndex,
  onTap: viewModel.changeTab,
  selectedItemColor: kPrimaryColor,
  unselectedItemColor: Colors.grey,
  type: BottomNavigationBarType.fixed,
  items: const [
    BottomNavigationBarItem(
      icon: Icon(LucideIcons.home),
      label: 'Home',
    ),
    BottomNavigationBarItem(
      icon: Icon(LucideIcons.indianRupee),
      label: 'Revenue',
    ),
    BottomNavigationBarItem(
      icon: Icon(LucideIcons.fileText),
      label: 'History',
    ),
    BottomNavigationBarItem(
      icon: Icon(LucideIcons.userCircle),
      label: 'Profile',
    ),
  ],
),

    );
  }
}
