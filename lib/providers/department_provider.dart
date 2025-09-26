import 'package:flutter/cupertino.dart';

import '../service/api_service.dart';
import '../service/auth_service.dart';
import '../models/Department.dart';


class DepartmentProvider extends ChangeNotifier {
  final ApiService apiService;
  List<Department> _departments = [];
  bool _isLoading = false;

  List<Department> get departments => _departments;
  bool get isLoading => _isLoading;

  DepartmentProvider(this.apiService) {
    fetchDepartments();
  }

  void fetchDepartments() async {
    _isLoading = true;
    notifyListeners();

    _departments = await apiService.fetchDepartments();
    _isLoading = false;
    notifyListeners();
  }
}