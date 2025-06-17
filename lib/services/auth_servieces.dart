import 'dart:convert';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;
import 'package:task/models/user_model.dart';
import 'package:task/models/user_profile_model.dart';

class AuthService {
  static const String _loginUrl =
      'https://seclobbackendapi.seclob.com/v1/cPartner-no/auth/login';

  static const String _profileUrl =
      'https://seclobbackendapi.seclob.com/v1/cPartner/user/details';

    final FlutterSecureStorage _storage = const FlutterSecureStorage();


  Future<UserModel?> login(String email, String password) async {
    final response = await http.post(
      Uri.parse(_loginUrl),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        'email': email,
        'password': password,
      }),
    );


    if (response.statusCode == 200) {
      final Map<String, dynamic> data = jsonDecode(response.body);
      return UserModel.fromJson(data);
    } else {
      throw "User not found";
    }
  }


  Future<UserProfile?> fetchUserProfile() async {
    final token = await _storage.read(key: 'accessToken');
    if (token == null) throw 'Access token not found';

    final response = await http.get(
      Uri.parse(_profileUrl),
      headers: {
        'Authorization': 'Bearer $token',
        'Content-Type': 'application/json',
      },
    );


    if (response.statusCode == 200) {
      final json = jsonDecode(response.body);
      return UserProfile.fromJson(json['data']);
    } else {
      throw "Failed to load user profile";
    }
  }
}