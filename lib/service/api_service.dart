import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:intl/intl.dart';

import '../models/UserDepartmentBinding.dart';
import 'auth_service.dart';
import '../models/User.dart';
import '../models/Account.dart';
import '../models/Department.dart';
import '../models/Employee.dart';
import '../models/Binding.dart';
import '../models/Job.dart';
import '../models/Report.dart';

class ApiService {
  final Dio _dio;
  final AuthService _authService;

  ApiService(this._dio, this._authService);

  Future<List<UserDepartmentBinding>> fetchUserDepartmentBindings() async {
    try {
      final response = await _dio.get('/user-departments'); // Убедитесь что это правильный endpoint
      if (response.data is List) {
        final list = (response.data as List).map((e) => UserDepartmentBinding.fromJson(e)).toList();
        debugPrint('ApiService: Parsed ${list.length} user-department bindings.');
        return list;
      } else {
        debugPrint('ApiService: Response data is not a List: ${response.data}');
        return [];
      }
    } catch (e) {
      debugPrint('ApiService: fetchUserDepartmentBindings failed: $e');
      rethrow;
    }
  }

  Future<Report> updateReport(
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
      final requestData = {
        'reportNumber': reportNumber,
        'departmentId': departmentId,
        'jobId': jobId,
        'employeeId': employeeId,
        'accountId': accountId,
        'dateReceived': dateReceived.toIso8601String(),
        'amountIssued': amountIssued,
        'dateApproved': dateApproved.toIso8601String(),
        'purpose': purpose,
        'recognizedAmount': recognizedAmount,
        'comments': comments,
      };

      final response = await _dio.put(
        '/reports/$reportId',
        data: requestData,
        options: Options(headers: {'Content-Type': 'application/json'}),
      );
      return Report.fromJson(response.data);
    } on DioException catch (e) {
      rethrow;
    } catch (e) {
      rethrow;
    }
  }

  Future<Report> createReport({
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
      final response = await _dio.post(
        '/reports',
        data: {
          'departmentId': departmentId,
          'jobId': jobId,
          'employeeId': employeeId,
          'accountId': accountId,
          'dateReceived': DateFormat('yyyy-MM-dd').format(dateReceived),
          'amountIssued': amountIssued,
          'dateApproved': DateFormat('yyyy-MM-dd').format(dateApproved),
          'purpose': purpose,
          'recognizedAmount': recognizedAmount,
          'comments': comments,
        },
      );
      return Report.fromJson(response.data);
    } catch (e) {
      rethrow;
    }
  }

  Future<List<Report>> fetchAllReports() async {
    try {
      final response = await _dio.get(
        '/reports',
        options: Options(validateStatus: (status) => status! < 500),
      );
      if (response.statusCode == 200) {
        return (response.data as List)
            .map((json) => Report.fromJson(json))
            .toList();
      } else {
        throw Exception('Failed to load reports');
      }
    } catch (e) {
      if (e is DioException) {
      } else {}
      rethrow;
    }
  }


  Future<List<Report>> fetchReportsByDepartment(int departmentId) async {
    try {
      final response = await _dio.get('/reports/department/$departmentId');
      return (response.data as List)
          .map((json) => Report.fromJson(json))
          .toList();
    } catch (e) {
      rethrow;
    }
  }

  Future<List<User>> fetchUsers() async {
    final response = await _dio.get('/users');
    return (response.data as List).map((e) => User.fromJson(e)).toList();
  }

  Future<void> deleteReport(int reportId) async {
    try {
      await _dio.delete('/reports/$reportId');
    } catch (e) {
      rethrow;
    }
  }

  Future<List<Binding>> fetchBindings() async {
    try {
      final response = await _dio.get('/employee-departments');
      return (response.data as List)
          .map((json) => Binding.fromJson(json))
          .toList();
    } catch (e) {
      rethrow;
    }
  }

  Future<List<Account>> fetchAccounts() async {
    try {
      final response = await _dio.get('/accounts');
      return (response.data as List)
          .map((json) => Account.fromJson(json))
          .toList();
    } catch (e) {
      rethrow;
    }
  }

  Future<List<Department>> fetchDepartments() async {
    try {
      final response = await _dio.get('/departments');
      return (response.data as List)
          .map((json) => Department.fromJson(json))
          .toList();
    } catch (e) {
      rethrow;
    }
  }

  Future<List<Employee>> fetchEmployees() async {
    try {
      final response = await _dio.get('/employees');
      return (response.data as List)
          .map((json) => Employee.fromJson(json))
          .toList();
    } catch (e) {
      rethrow;
    }
  }

  Future<List<Job>> fetchJobs() async {
    try {
      final response = await _dio.get('/jobs');
      return (response.data as List).map((json) => Job.fromJson(json)).toList();
    } catch (e) {
      rethrow;
    }
  }
}
