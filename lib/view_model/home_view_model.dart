// lib/view_model/home_view_model.dart

import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:task/services/account_service.dart';

class HomeViewModel extends ChangeNotifier {
  final FlutterSecureStorage _storage = const FlutterSecureStorage();
  final AccountServiece _accService = AccountServiece();

  String _userName = '';
  String get userName => _userName;

  double? _balance;
  double? get balance => _balance;

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  String? _errorMessage;
  String? get errorMessage => _errorMessage;

  HomeViewModel() {
    initialize();
  }

  Future<void> initialize() async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    try {
      await loadUserName();
      await fetchBalance();
    } catch (e) {
      _errorMessage = 'Something went wrong: $e';
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> loadUserName() async {
    try {
      _userName = await _storage.read(key: 'name') ?? 'User';
    } catch (e) {
      _userName = 'User';
      _errorMessage = 'Failed to load username.';
    }
  }

  Future<void> fetchBalance() async {
    try {
      _balance = await _accService.getBalance();
    } catch (e) {
      _balance = null;
      _errorMessage = 'Failed to fetch balance.';
    }
  }
}
