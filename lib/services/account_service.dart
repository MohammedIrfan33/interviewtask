// lib/services/home_service.dart

import 'dart:convert';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;

class AccountServiece {
  final FlutterSecureStorage _storage = const FlutterSecureStorage();

  Future<double?> getBalance() async {
    final token = await _storage.read(key: 'accessToken');
    if (token == null) return null;

    final url = Uri.parse('https://seclobbackendapi.seclob.com/v1/cPartner/wallet/balance');

    final response = await http.get(
      url,
      headers: {'Authorization': 'Bearer $token'},
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      final balances = data['balances'];
      if (balances is List && balances.isNotEmpty) {
        return balances[0]['balance']?.toDouble();
      }
    }

    throw  "Something went  wrong";
  }
}
