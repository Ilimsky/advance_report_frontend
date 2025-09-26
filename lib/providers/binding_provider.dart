import 'package:flutter/material.dart';
import '../service/api_service.dart';
import '../service/auth_service.dart';
import '../models/Binding.dart';

class BindingProvider extends ChangeNotifier {
  final ApiService apiService;
  List<Binding> _bindings = [];
  bool _isLoading = false;

  List<Binding> get bindings => _bindings;
  bool get isLoading => _isLoading;

  BindingProvider(this.apiService) {
    fetchBindings();
  }

  Future<void> fetchBindings() async {
    _isLoading = true;
    notifyListeners();

    try {
      _bindings = await apiService.fetchBindings();
    } catch (e) {
      print('[ERROR] Failed to fetch bindings: $e');
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}
