import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';
import 'package:task/constance/color_constant.dart';
import 'package:task/view/profile_screen.dart';
import 'package:task/view_model/root_view_model.dart';
import 'home_screen.dart';
import 'dart:io'; // for exit()

class RootScreen extends StatelessWidget {
  RootScreen({super.key});

  final List<Widget> _screens = [
    HomeScreen(),
    Scaffold(),
    Scaffold(),
    ProfileScreen()
  ];

  @override
  Widget build(BuildContext context) {
    final viewModel = Provider.of<RootViewModel>(context);

    return WillPopScope(
      onWillPop: () async {
        bool shouldExit = await showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: Text('Exit App'),
            content: Text('Are you sure you want to exit the app?'),
            actions: [
              TextButton(
                onPressed: () => Navigator.of(context).pop(false),
                child: Text('No'),
              ),
              TextButton(
                onPressed: () => exit(0), // Force closes the app
                child: Text('Yes'),
              ),
            ],
          ),
        );
        return Future.value(false); // Prevent default back action
      },
      child: Scaffold(
        body: _screens[viewModel.currentIndex],
        bottomNavigationBar: BottomNavigationBar(
          currentIndex: viewModel.currentIndex,
          onTap: viewModel.changeTab,
          selectedItemColor: kPrimaryColor,
          unselectedItemColor: Colors.grey,
          type: BottomNavigationBarType.fixed,
          items: [
            BottomNavigationBarItem(
              icon: SvgPicture.asset(
                'asset/images/svg/home.svg',
                colorFilter: ColorFilter.mode(
                  viewModel.currentIndex == 0 ? kPrimaryColor : Colors.grey,
                  BlendMode.srcIn,
                ),
              ),
              label: 'Home',
            ),
            BottomNavigationBarItem(
              icon: SvgPicture.asset(
                'asset/images/svg/revenue.svg',
                colorFilter: ColorFilter.mode(
                  viewModel.currentIndex == 1 ? kPrimaryColor : Colors.grey,
                  BlendMode.srcIn,
                ),
              ),
              label: 'Revenue',
            ),
            BottomNavigationBarItem(
              icon: SvgPicture.asset(
                'asset/images/svg/history.svg',
                colorFilter: ColorFilter.mode(
                  viewModel.currentIndex == 2 ? kPrimaryColor : Colors.grey,
                  BlendMode.srcIn,
                ),
              ),
              label: 'History',
            ),
            BottomNavigationBarItem(
              icon: SvgPicture.asset(
                'asset/images/svg/profile.svg',
                colorFilter: ColorFilter.mode(
                  viewModel.currentIndex == 3 ? kPrimaryColor : Colors.grey,
                  BlendMode.srcIn,
                ),
              ),
              label: 'Profile',
            ),
          ],
        ),
      ),
    );
  }
}
