import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:task/models/user_profile_model.dart';
import 'package:task/services/auth_servieces.dart';
import 'package:task/view/signin_screen.dart';

class AuthViewModel extends ChangeNotifier {
  final AuthService _authService = AuthService();
  final FlutterSecureStorage _secureStorage = const FlutterSecureStorage();


  bool _isLoading = false;
  bool get isLoading => _isLoading;

  UserProfile? _userProfile;
  UserProfile? get userProfile => _userProfile;

  void _setLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }

  Future<String?> loginUser(String email, String password,BuildContext context) async {
    _setLoading(true);
    try {
      final user = await _authService.login(email, password);
      if (user != null) {
        await _secureStorage.write(key: 'name', value: user.name);
        await _secureStorage.write(key: 'userId', value: user.userId);
        await _secureStorage.write(key: 'accessToken', value: user.accessToken);
        await _secureStorage.write(key: 'refreshToken', value: user.refreshToken);
        return "Login success";
      } else {
        return "Login failed";
      }
    } catch (e) {
      return e.toString();
    } finally {
      _setLoading(false);
    }
  }


   Future<String?> getUserProfile() async {
    _setLoading(true);
    try {
      _userProfile = await _authService.fetchUserProfile();
      return "Profile loaded";
    } catch (e) {
      return e.toString();
    } finally {
      _setLoading(false);
    }
  }

  Future<void> logoutUser(BuildContext context) async {
  _setLoading(true);
  try {
    await _secureStorage.deleteAll();

    _userProfile = null;

    Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => SignInScreen(),),(route) => false, );

  } catch (e) {
    debugPrint("Logout error: $e");
  } finally {
    _setLoading(false);
  }
}
}
