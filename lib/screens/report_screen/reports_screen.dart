import 'package:advance_report_frontend/screens/report_screen/reports_print/reports_print.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../providers/account_provider.dart';
import '../../providers/department_provider.dart';
import '../../providers/employee_provider.dart';
import '../../providers/job_provider.dart';
import '../../providers/report_provider.dart';
import 'reports_table.dart';
import 'reports_search.dart';

class ReportsScreen extends StatefulWidget {
  @override
  _ReportsScreenState createState() => _ReportsScreenState();
}

class _ReportsScreenState extends State<ReportsScreen> {
  final TextEditingController _searchController = TextEditingController();
  String _searchQuery = '';

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<ReportProvider>(context, listen: false).fetchAllReports();
    });
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  void _printAllReports(BuildContext context) {
    final reportProvider = Provider.of<ReportProvider>(context, listen: false);
    final departmentProvider = Provider.of<DepartmentProvider>(context, listen: false);
    final jobProvider = Provider.of<JobProvider>(context, listen: false);
    final employeeProvider = Provider.of<EmployeeProvider>(context, listen: false);
    final accountProvider = Provider.of<AccountProvider>(context, listen: false);

    printAllReports(
      context: context,
      reports: reportProvider.reports,
      departmentProvider: departmentProvider,
      jobProvider: jobProvider,
      employeeProvider: employeeProvider,
      accountProvider: accountProvider,
    );
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(title: Text('Отчеты'),
          actions: [
          IconButton(
          icon: Icon(Icons.print),
      onPressed: () => _printAllReports(context),
      tooltip: 'Печать всех отчетов',
    ),
    ],
      ),

      body: Column(
        children: [
          SearchReportsField(
            controller: _searchController,
            onChanged: (value) => setState(() => _searchQuery = value),
          ),
          Expanded(
            child: Consumer<ReportProvider>(
                builder: (context, reportProvider, child) {
              if (reportProvider.isLoading) {
                return Center(child: CircularProgressIndicator());
              }
              return ReportsTable(
                searchQuery: _searchQuery,
              );
            }),
          ),
        ],
      ),
    );
  }
}
