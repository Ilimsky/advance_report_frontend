import 'package:flutter/cupertino.dart';

import '../service/api_service.dart';
import '../service/auth_service.dart';
import '../models/Employee.dart';

class EmployeeProvider extends ChangeNotifier {
  final ApiService apiService;
  List<Employee> _employees = [];
  bool _isLoading = false;

  List<Employee> get employees => _employees;
  bool get isLoading => _isLoading;

  EmployeeProvider(this.apiService) {
    fetchEmployees();
  }

  void fetchEmployees() async {
    _isLoading = true;
    notifyListeners();

    _employees = await apiService.fetchEmployees();
    _isLoading = false;
    notifyListeners();
  }
}