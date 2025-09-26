import 'package:flutter/cupertino.dart';

import '../service/api_service.dart';
import '../service/auth_service.dart';
import '../models/Job.dart';

class JobProvider extends ChangeNotifier {
  final ApiService apiService;
  List<Job> _jobs = [];
  bool _isLoading = false;

  List<Job> get jobs => _jobs;
  bool get isLoading => _isLoading;

  JobProvider(this.apiService) {
    fetchJobs();
  }

  void fetchJobs() async {
    _isLoading = true;
    notifyListeners();

    _jobs = await apiService.fetchJobs();
    _isLoading = false;
    notifyListeners();
  }
}