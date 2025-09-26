import 'package:flutter/cupertino.dart';

import '../service/api_service.dart';
import '../service/auth_service.dart';
import '../models/Report.dart';

class ReportProvider extends ChangeNotifier {
  final ApiService apiService;
  List<Report> _reports = [];
  bool _isLoading = false;

  List<Report> get reports => _reports;
  bool get isLoading => _isLoading;


  ReportProvider(this.apiService);

  Future<void> updateReport(
      int reportId, {
        required int reportNumber,
        required int departmentId,
        required int jobId,
        required int employeeId,
        required int accountId,
        required DateTime dateReceived,
        required String amountIssued,
        required DateTime dateApproved,
        required String purpose,
        required String recognizedAmount,
        required String comments,
      }) async {
    try {
      final updatedReport = await apiService.updateReport(
        reportId,
        reportNumber: reportNumber,
        departmentId: departmentId,
        jobId: jobId,
        employeeId: employeeId,
        accountId: accountId,
        dateReceived: dateReceived,
        amountIssued: amountIssued,
        dateApproved: dateApproved,
        purpose: purpose,
        recognizedAmount: recognizedAmount,
        comments: comments,
      );
      int index = _reports.indexWhere((report) => report.id == reportId);
      if (index != -1) {
        _reports[index] = updatedReport;
        notifyListeners();
      } else {
      }
    } catch (e) {
      rethrow;
    }
  }

  void fetchReportsByDepartment(int departmentId) async {
    _isLoading = true;
    notifyListeners();
    _reports = await apiService.fetchReportsByDepartment(departmentId);
    _isLoading = false;
    notifyListeners();
  }

  void fetchAllReports() async {
    _isLoading = true;
    notifyListeners();
    _reports = await apiService.fetchAllReports();
    _isLoading = false;
    notifyListeners();
  }

  Future<void> createReport({
    required int departmentId,
    required int jobId,
    required int employeeId,
    required int accountId,
    required DateTime dateReceived,
    required String amountIssued,
    required DateTime dateApproved,
    required String purpose,
    required String recognizedAmount,
    required String comments,
  }) async {
    final newReport = await apiService.createReport(
      departmentId: departmentId,
      jobId: jobId,
      employeeId: employeeId,
      accountId: accountId,
      dateReceived: dateReceived,
      amountIssued: amountIssued,
      dateApproved: dateApproved,
      purpose: purpose,
      recognizedAmount: recognizedAmount,
      comments: comments,
    );
    _reports.add(newReport);
    notifyListeners();
  }

  Future<void> deleteReport(int reportId) async {
    await apiService.deleteReport(reportId);
    _reports.removeWhere((report) => report.id == reportId);
    notifyListeners();
  }

  void sortReports(Comparator<Report> comparator) {
    _reports.sort(comparator);
    notifyListeners();
  }
}