import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:task/view/onboard_screen.dart';
import 'package:task/view/root_screen.dart';
import 'package:task/view/signin_screen.dart';

class GlobalViewModel extends ChangeNotifier {
  final FlutterSecureStorage _secureStorage = const FlutterSecureStorage();

  Future<void> checkLoginStatus(BuildContext context) async {
    String? token = await _secureStorage.read(key: 'accessToken');


    await Future.delayed(const Duration(milliseconds: 800));

    if (token != null && token.isNotEmpty) {
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (_) =>  RootScreen()),
        (_) => false,
      );
    } else {
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (_) =>  OnboardingScreen()),
        (_) => false,
      );
    }
  }
}
