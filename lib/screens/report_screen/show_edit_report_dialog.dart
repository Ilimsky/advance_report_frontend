import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../../service/api_service.dart';
import '../../service/auth_service.dart';
import '../../models/Account.dart';
import '../../models/Department.dart';
import '../../models/Employee.dart';
import '../../models/Job.dart';
import '../../models/Report.dart';
import '../../providers/report_provider.dart';

void showEditReportDialog(BuildContext context, Report report) {
  final reportProvider = Provider.of<ReportProvider>(context, listen: false);
  final authService = Provider.of<AuthService>(context, listen: false);
  final apiService = ApiService(authService.dioInstance, authService);

  final reportNumberController = TextEditingController(
    text: report.reportNumber.toString(),
  );
  final dateReceivedController = TextEditingController(
    text: DateFormat('yyyy-MM-dd').format(report.dateReceived),
  );
  final dateApprovedController = TextEditingController(
    text: DateFormat('yyyy-MM-dd').format(report.dateApproved),
  );
  final amountIssuedController = TextEditingController(
    text: report.amountIssued,
  );
  final purposeController = TextEditingController(text: report.purpose);
  final recognizedAmountController = TextEditingController(
    text: report.recognizedAmount,
  );
  final commentsController = TextEditingController(text: report.comments);

  final selectedDepartmentId = ValueNotifier<int?>(report.departmentId);
  final selectedJobId = ValueNotifier<int?>(report.jobId);
  final selectedEmployeeId = ValueNotifier<int?>(report.employeeId);
  final selectedAccountId = ValueNotifier<int?>(report.accountId);

  showDialog(
    context: context,
    builder: (context) => AlertDialog(
      title: Text('Редактировать отчет'),
      content: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: dateReceivedController,
              decoration: InputDecoration(
                labelText: 'Дата получения',
                suffixIcon: Icon(Icons.calendar_today),
              ),
              readOnly: true,
              onTap: () async {
                final date = await showDatePicker(
                  context: context,
                  initialDate: report.dateReceived,
                  firstDate: DateTime(2000),
                  lastDate: DateTime(2100),
                );
                if (date != null) {
                  dateReceivedController.text = DateFormat(
                    'yyyy-MM-dd',
                  ).format(date);
                }
              },
            ),
            TextField(
              controller: amountIssuedController,
              decoration: InputDecoration(labelText: 'Выданная сумма'),
              keyboardType: TextInputType.numberWithOptions(decimal: true),
              onChanged: (value) {},
            ),
            TextField(
              controller: dateApprovedController,
              decoration: InputDecoration(
                labelText: 'Дата утверждения',
                suffixIcon: Icon(Icons.calendar_today),
              ),
              readOnly: true,
              onTap: () async {
                final date = await showDatePicker(
                  context: context,
                  initialDate: report.dateApproved,
                  firstDate: DateTime(2000),
                  lastDate: DateTime(2100),
                );
                if (date != null) {
                  dateApprovedController.text = DateFormat(
                    'yyyy-MM-dd',
                  ).format(date);
                }
              },
            ),
            // Job dropdown
            FutureBuilder<List<Job>>(
              future: apiService.fetchJobs(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return CircularProgressIndicator();
                }
                if (snapshot.hasError) {
                  return Text('Ошибка загрузки должностей');
                }
                if (!snapshot.hasData || snapshot.data!.isEmpty) {
                  return Text('Нет доступных должностей');
                }
                return ValueListenableBuilder<int?>(
                  valueListenable: selectedJobId,
                  builder: (context, value, child) {
                    return DropdownButtonFormField<int>(
                      value: value,
                      items: snapshot.data!.map((job) {
                        return DropdownMenuItem<int>(
                          value: job.id,
                          child: Text(job.name),
                        );
                      }).toList(),
                      onChanged: (newValue) {
                        selectedJobId.value = newValue;
                      },
                      decoration: InputDecoration(labelText: 'Должность'),
                    );
                  },
                );
              },
            ),
            // Employee dropdown
            FutureBuilder<List<Employee>>(
              future: apiService.fetchEmployees(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return CircularProgressIndicator();
                }
                if (snapshot.hasError) {
                  print(
                    '[ERROR] Ошибка загрузки сотрудников: ${snapshot.error}',
                  );
                  return Text('Ошибка загрузки сотрудников');
                }
                if (!snapshot.hasData || snapshot.data!.isEmpty) {
                  print('[WARN] Нет данных о сотрудниках');
                  return Text('Нет доступных сотрудников');
                }

                print(
                  '[DEBUG] Загружено сотрудников: ${snapshot.data!.length}',
                );
                return ValueListenableBuilder<int?>(
                  valueListenable: selectedEmployeeId,
                  builder: (context, value, child) {
                    print('[DEBUG] Employee dropdown value: $value');
                    return DropdownButtonFormField<int>(
                      value: value,
                      items: snapshot.data!.map((employee) {
                        return DropdownMenuItem<int>(
                          value: employee.id,
                          child: Text(employee.name),
                        );
                      }).toList(),
                      onChanged: (newValue) {
                        print('[DEBUG] Employee changed to: $newValue');
                        selectedEmployeeId.value = newValue;
                      },
                      decoration: InputDecoration(labelText: 'Сотрудник'),
                    );
                  },
                );
              },
            ),

            TextField(
              controller: purposeController,
              decoration: InputDecoration(labelText: 'Назначение'),
              maxLines: 3,
              onChanged: (value) {},
            ),

            TextField(
              controller: recognizedAmountController,
              decoration: InputDecoration(labelText: 'Признанная сумма'),
              keyboardType: TextInputType.numberWithOptions(decimal: true),
              onChanged: (value) {},
            ),

            // Account dropdown
            FutureBuilder<List<Account>>(
              future: apiService.fetchAccounts(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return CircularProgressIndicator();
                }
                if (snapshot.hasError) {
                  return Text('Ошибка загрузки счетов');
                }
                if (!snapshot.hasData || snapshot.data!.isEmpty) {
                  return Text('Нет доступных счетов');
                }
                return ValueListenableBuilder<int?>(
                  valueListenable: selectedAccountId,
                  builder: (context, value, child) {
                    return DropdownButtonFormField<int>(
                      value: value,
                      items: snapshot.data!.map((account) {
                        return DropdownMenuItem<int>(
                          value: account.id,
                          child: Text(account.name),
                        );
                      }).toList(),
                      onChanged: (newValue) {
                        selectedAccountId.value = newValue;
                      },
                      decoration: InputDecoration(labelText: 'Счет'),
                    );
                  },
                );
              },
            ),
            TextField(
              controller: commentsController,
              decoration: InputDecoration(labelText: 'Комментарии'),
              maxLines: 3,
              onChanged: (value) {},
            ),
          ],
        ),
      ),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.pop(context);
          },
          child: Text('Отмена'),
        ),
        TextButton(
          onPressed: () {
            if (selectedDepartmentId.value == null ||
                selectedJobId.value == null ||
                selectedEmployeeId.value == null ||
                selectedAccountId.value == null) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text('Заполните все обязательные поля')),
              );
              return;
            }
            try {
              reportProvider.updateReport(
                report.id,
                reportNumber: int.parse(reportNumberController.text),
                departmentId: selectedDepartmentId.value!,
                jobId: selectedJobId.value!,
                employeeId: selectedEmployeeId.value!,
                accountId: selectedAccountId.value!,
                dateReceived: DateFormat(
                  'yyyy-MM-dd',
                ).parse(dateReceivedController.text),
                amountIssued: amountIssuedController.text,
                dateApproved: DateFormat(
                  'yyyy-MM-dd',
                ).parse(dateApprovedController.text),
                purpose: purposeController.text,
                recognizedAmount: recognizedAmountController.text,
                comments: commentsController.text,
              );
              Navigator.pop(context);
            } catch (e) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text('Ошибка при сохранении: $e')),
              );
            }
          },
          child: Text('Сохранить'),
        ),
      ],
    ),
  );
}
