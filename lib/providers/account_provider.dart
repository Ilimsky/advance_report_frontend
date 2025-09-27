import 'package:flutter/cupertino.dart';

import '../service/api_service.dart';
import '../service/auth_service.dart';
import '../models/Account.dart';

class AccountProvider extends ChangeNotifier {
  final ApiService apiService;
  List<Account> _accounts = [];
  bool _isLoading = false;

  List<Account> get accounts => _accounts;
  bool get isLoading => _isLoading;

  AccountProvider(this.apiService) {
    fetchAccounts();
  }

  void fetchAccounts() async {
    _isLoading = true;
    notifyListeners();
    _accounts = await apiService.fetchAccounts();
    _isLoading = false;
    notifyListeners();
  }
}