import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../models/Account.dart';
import '../models/Employee.dart';
import '../models/Job.dart';
import '../providers/account_provider.dart';
import '../models/Department.dart';
import '../providers/department_provider.dart';
import '../providers/employee_provider.dart';
import '../providers/job_provider.dart';
import '../providers/report_provider.dart';
import '../providers/user_department_binding_provider.dart';
import '../providers/user_provider.dart';
import '../service/auth_service.dart';

class CreateReportScreen extends StatefulWidget {
  const CreateReportScreen({super.key});

  @override
  _CreateReportScreenState createState() => _CreateReportScreenState();
}

class _CreateReportScreenState extends State<CreateReportScreen> {
  int? selectedDepartmentId;
  Department? selectedDepartment;
  int? selectedJobId;
  Job? selectedJob;
  int? selectedEmployeeId;
  Employee? selectedEmployee;
  int? selectedAccountId;
  Account? selectedAccount;
  DateTime? selectedDateReceived;
  DateTime? selectedDateApproved;
  DateTime? selectedDateCreated;

  final TextEditingController _dateReceivedController = TextEditingController();
  final TextEditingController _amountIssuedController = TextEditingController();
  final TextEditingController _dateApprovedController = TextEditingController();
  final TextEditingController _purposeController = TextEditingController();
  final TextEditingController _recognizedAmountController =
  TextEditingController();
  final TextEditingController _commentsController = TextEditingController();

  bool _showViewFields = false;

  final List<Map<String, String>> _viewFields = [];

  final List<String> purposeTemplates = [
    'Оплата за интернет за (месяц) 202. г. согл. чека №. от (день месяц) 202. г.',
    'Оплата за электричество за (месяц) 202. г. согл. чека №. от (день месяц) 202. г.',
    'Оплата за аренду за (месяц) 202. г. согл. чека №. от (день месяц) 202. г.',
    'ГСМ по путевому за (месяц) 202. (Ф.И.О)',
    'Оплата за доставку через курьерскую службу (название) согл. квит. №. от (день месяц) 202.',
    'Покупка бензина для генератора согл. чека №. от (день месяц) 202.',
  ];

  bool _initialDepartmentSet = false;
  int? _currentUserId; // Добавляем ID текущего пользователя

  @override
  void initState() {
    super.initState();
    _initializeDefaultValues();

    print('CreateReportScreen: initState, пользователь: ${Provider.of<AuthService>(context, listen: false).username}');

    WidgetsBinding.instance.addPostFrameCallback((_) {
      _getCurrentUserId();
    });
  }

  void _getCurrentUserId() async {
    final authService = Provider.of<AuthService>(context, listen: false);
    final userProvider = Provider.of<UserProvider>(context, listen: false);

    if (!authService.isAuthenticated || authService.username == null) {
      print('Пользователь не аутентифицирован');
      return;
    }

    // Ждем загрузки пользователей
    if (userProvider.users.isEmpty) {
      print('Загружаем список пользователей...');
      await userProvider.fetchUsers();
    }

    try {
      final currentUser = userProvider.users.firstWhere(
            (user) => user.username == authService.username,
      );

      setState(() {
        _currentUserId = currentUser.id;
      });

      print('Установлен ID текущего пользователя: $_currentUserId');

      // Сразу после установки ID пользователя загружаем привязки
      _loadUserBindings();

    } catch (e) {
      print('Ошибка: Пользователь "${authService.username}" не найден в системе');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Ваш пользователь не найден в системе')),
      );
    }
  }

  void _loadUserBindings() {
    final bindingProvider = Provider.of<UserDepartmentBindingProvider>(context, listen: false);

    if (bindingProvider.bindings.isEmpty) {
      print('Загружаем привязки пользователей...');
      bindingProvider.fetchBindings().then((_) {
        if (mounted) {
          print('Привязки загружены, устанавливаем филиал...');
          _setCurrentUserDepartment();
        }
      }).catchError((error) {
        print('Ошибка загрузки привязок: $error');
      });
    } else {
      print('Привязки уже загружены, устанавливаем филиал...');
      _setCurrentUserDepartment();
    }
  }

  void _setCurrentUserDepartment() {
    if (_currentUserId == null) {
      // print('ID пользователя не установлен');
      return;
    }

    final bindingProvider = Provider.of<UserDepartmentBindingProvider>(context, listen: false);
    final departmentProvider = Provider.of<DepartmentProvider>(context, listen: false);

    // print('Ищем привязку для пользователя $_currentUserId');
    // print('Доступно привязок: ${bindingProvider.bindings.length}');
    // print('Доступно филиалов: ${departmentProvider.departments.length}');

    // Детальная отладка привязок
    // print('Детальная информация о привязках:');
    for (var binding in bindingProvider.bindings) {
      print('  - $binding');
    }

    try {
      // Ищем привязку для текущего пользователя
      final userBinding = bindingProvider.bindings.firstWhere(
            (binding) => binding.userId == _currentUserId,
      );

      // print('Найдена привязка: userId=${userBinding.userId}, departmentId=${userBinding.departmentId}');

      // Находим соответствующий филиал
      final userDepartment = departmentProvider.departments.firstWhere(
            (dept) => dept.id == userBinding.departmentId,
      );

      // print('Найден филиал: ${userDepartment.name} (id: ${userDepartment.id})');

      setState(() {
        selectedDepartmentId = userDepartment.id;
        selectedDepartment = userDepartment;
        _initialDepartmentSet = true;
      });

      // print('Автоматически установлен филиал: ${userDepartment.name}');

    } catch (e) {
      // print('Филиал для пользователя $_currentUserId не найден: $e');
      // print('Доступные привязки: ${bindingProvider.bindings.map((b) => 'userId:${b.userId}->dept:${b.departmentId}').toList()}');

      // Отложенный показ SnackBar
      WidgetsBinding.instance.addPostFrameCallback((_) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Для вашего пользователя не настроен филиал')),
        );
      });
    }
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
  }



  void _initializeDefaultValues() {
    // Устанавливаем сегодняшнюю дату для даты получения и даты утверждения
    final today = DateTime.now();
    selectedDateReceived = today;
    selectedDateApproved = today;

    _dateReceivedController.text = DateFormat('yyyy-MM-dd').format(today);
    _dateApprovedController.text = DateFormat('yyyy-MM-dd').format(today);

    // Слушатель для автоматического обновления признанной суммы при изменении выданной суммы
    _amountIssuedController.addListener(_updateRecognizedAmount);
  }

  void _updateRecognizedAmount() {
    if (_recognizedAmountController.text != _amountIssuedController.text) {
      // Обновляем только если пользователь не редактировал признанную сумму вручную
      // или если признанная сумма пустая
      if (_recognizedAmountController.text.isEmpty ||
          _recognizedAmountController.text == _getPreviousAmountIssued()) {
        setState(() {
          _recognizedAmountController.text = _amountIssuedController.text;
        });
      }
    }
    _setPreviousAmountIssued(_amountIssuedController.text);
  }

  String? _previousAmountIssued;

  String _getPreviousAmountIssued() {
    return _previousAmountIssued ?? '';
  }

  void _setPreviousAmountIssued(String value) {
    _previousAmountIssued = value;
  }

  Future<void> _selectDate(BuildContext context,
      TextEditingController controller,
      void Function(DateTime) onDateSelected,) async {
    final DateTime? selectedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );

    if (selectedDate != null) {
      setState(() {
        onDateSelected(selectedDate); // обновляем нужную переменную
        controller.text = DateFormat('yyyy-MM-dd').format(selectedDate);
      });
    }
  }

  @override
  void dispose() {
    _amountIssuedController.removeListener(_updateRecognizedAmount);
    _dateReceivedController.dispose();
    _amountIssuedController.dispose();
    _dateApprovedController.dispose();
    _purposeController.dispose();
    _recognizedAmountController.dispose();
    _commentsController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final departmentProvider = Provider.of<DepartmentProvider>(context);
    final jobProvider = Provider.of<JobProvider>(context);
    final employeeProvider = Provider.of<EmployeeProvider>(context);
    final accountProvider = Provider.of<AccountProvider>(context);
    final reportProvider = Provider.of<ReportProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text('Создать отчет'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            // Первая строка
            Row(
              children: [
                // Филиал
                // Expanded(
                //   child: Card(
                //     child: Padding(
                //       padding: const EdgeInsets.all(8.0),
                //       child: DropdownButton<int>(
                //         isExpanded: true,
                //         hint: Text('Филиал',
                //             style: TextStyle(fontSize: 14),
                //             overflow: TextOverflow.ellipsis),
                //         value: selectedDepartmentId,
                //         onChanged: (newId) {
                //           setState(() {
                //             selectedDepartmentId = newId;
                //             selectedDepartment = departmentProvider.departments
                //                 .firstWhere((dept) => dept.id == newId);
                //           });
                //         },
                //         items: departmentProvider.departments.map((dept) {
                //           return DropdownMenuItem(
                //             value: dept.id,
                //             child: Text(dept.name,
                //                 style: TextStyle(fontSize: 14),
                //                 overflow: TextOverflow.ellipsis),
                //           );
                //         }).toList(),
                //       ),
                //     ),
                //   ),
                // ),
                // SizedBox(width: 10),

                // Дата получения
                Expanded(
                  child: InkWell(
                    onTap: () =>
                        _selectDate(context, _dateReceivedController, (date) {
                          selectedDateReceived = date;
                        }),
                    child: Card(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: AbsorbPointer(
                          child: TextField(
                            controller: _dateReceivedController,
                            decoration: InputDecoration(
                              labelText: 'Дата получения д/с',
                              labelStyle: TextStyle(fontSize: 14),
                              border: InputBorder.none,
                            ),
                            style: TextStyle(fontSize: 14),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),

                SizedBox(width: 10),

                // Выданная сумма
                Expanded(
                  child: Card(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: TextField(
                        controller: _amountIssuedController,
                        decoration: InputDecoration(
                          labelText: 'Выданная сумма',
                          labelStyle: TextStyle(fontSize: 14),
                          border: InputBorder.none,
                        ),
                        style: TextStyle(fontSize: 14),
                        keyboardType: TextInputType.number,
                        onChanged: (value) {
                          if (_recognizedAmountController.text.isEmpty ||
                              _recognizedAmountController.text ==
                                  _getPreviousAmountIssued()) {
                            setState(() {
                              _recognizedAmountController.text = value;
                            });
                          }
                          _setPreviousAmountIssued(value);
                        },
                      ),
                    ),
                  ),
                ),
                SizedBox(width: 10),

                // Дата утверждения
                Expanded(
                  child: InkWell(
                    onTap: () =>
                        _selectDate(context, _dateApprovedController, (date) {
                          selectedDateApproved = date;
                        }),
                    child: Card(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: AbsorbPointer(
                          child: TextField(
                            controller: _dateApprovedController,
                            decoration: InputDecoration(
                              labelText: 'Дата утверждения а/о',
                              labelStyle: TextStyle(fontSize: 14),
                              border: InputBorder.none,
                            ),
                            style: TextStyle(fontSize: 14),
                            readOnly: true,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(width: 10),

                // Должность
                Expanded(
                  child: Card(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: DropdownButton<int>(
                        isExpanded: true,
                        hint: Text('Должность',
                            style: TextStyle(fontSize: 14),
                            overflow: TextOverflow.ellipsis),
                        value: selectedJobId,
                        onChanged: (newId) {
                          setState(() {
                            selectedJobId = newId;
                            selectedJob = jobProvider.jobs
                                .firstWhere((job) => job.id == newId);
                          });
                        },
                        items: jobProvider.jobs.map((job) {
                          return DropdownMenuItem(
                            value: job.id,
                            child: Text(job.name,
                                style: TextStyle(fontSize: 14),
                                overflow: TextOverflow.ellipsis),
                          );
                        }).toList(),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 20),

            // Вторая строка
            Row(
              children: [
                // Сотрудник
                Expanded(
                  child: Card(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: DropdownButton<int>(
                        isExpanded: true,
                        hint: Text('Сотрудник',
                            style: TextStyle(fontSize: 14),
                            overflow: TextOverflow.ellipsis),
                        value: selectedEmployeeId,
                        onChanged: (newId) {
                          setState(() {
                            selectedEmployeeId = newId;
                            selectedEmployee = employeeProvider.employees
                                .firstWhere((employee) => employee.id == newId);
                          });
                        },
                        items: employeeProvider.employees.map((employee) {
                          return DropdownMenuItem(
                            value: employee.id,
                            child: Text(employee.name,
                                style: TextStyle(fontSize: 14),
                                overflow: TextOverflow.ellipsis),
                          );
                        }).toList(),
                      ),
                    ),
                  ),
                ),
                SizedBox(width: 10),

                // Назначение
                Expanded(
                  child: Card(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        children: [
                          Expanded(
                            child: TextField(
                              controller: _purposeController,
                              decoration: InputDecoration(
                                labelText: 'Назначение',
                                labelStyle: TextStyle(fontSize: 14),
                                border: InputBorder.none,
                                hintText: 'Введите или выберите шаблон',
                              ),
                              style: TextStyle(fontSize: 14),
                              maxLines: 3,
                              minLines: 1,
                            ),
                          ),
                          MouseRegion(
                            cursor: SystemMouseCursors.click,
                            child: GestureDetector(
                              onTap: () {
                                _showPurposeDialog(context);
                              },
                              child: Container(
                                padding: EdgeInsets.all(4),
                                child: Icon(
                                    Icons.list, size: 10, color: Colors.blue),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                SizedBox(width: 10),

                // Признанная сумма
                Expanded(
                  child: Card(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: TextField(
                        controller: _recognizedAmountController,
                        decoration: InputDecoration(
                          labelText: 'Признанная сумма затрат по а/о',
                          labelStyle: TextStyle(fontSize: 14),
                          border: InputBorder.none,
                        ),
                        style: TextStyle(fontSize: 14),
                        keyboardType: TextInputType.number,
                      ),
                    ),
                  ),
                ),
                SizedBox(width: 10),

                // Счет
                Expanded(
                  child: Card(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: DropdownButton<int>(
                        isExpanded: true,
                        hint: Text('Счет',
                            style: TextStyle(fontSize: 14),
                            overflow: TextOverflow.ellipsis),
                        value: selectedAccountId,
                        onChanged: (newId) {
                          setState(() {
                            selectedAccountId = newId;
                            selectedAccount = accountProvider.accounts
                                .firstWhere((account) => account.id == newId);
                          });
                        },
                        items: accountProvider.accounts.map((account) {
                          return DropdownMenuItem(
                            value: account.id,
                            child: Text(account.name,
                                style: TextStyle(fontSize: 14),
                                overflow: TextOverflow.ellipsis),
                          );
                        }).toList(),
                      ),
                    ),
                  ),
                ),
                SizedBox(width: 10),

                // Комментарии
                Expanded(
                  child: Card(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: TextField(
                        controller: _commentsController,
                        decoration: InputDecoration(
                          labelText: 'Комментарии',
                          labelStyle: TextStyle(fontSize: 14),
                          border: InputBorder.none,
                        ),
                        style: TextStyle(fontSize: 14),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 20),

            // Кнопки
            Row(
              children: [
                Expanded(
                  child: ElevatedButton(
                    onPressed: () {
                      if (selectedDepartmentId != null &&
                          selectedJobId != null &&
                          selectedEmployeeId != null &&
                          selectedAccountId != null &&
                          selectedDateReceived != null &&
                          selectedDateApproved != null) {
                        reportProvider
                            .createReport(
                          departmentId: selectedDepartmentId!,
                          jobId: selectedJobId!,
                          employeeId: selectedEmployeeId!,
                          accountId: selectedAccountId!,
                          dateReceived: selectedDateReceived!,
                          amountIssued: _amountIssuedController.text,
                          dateApproved: selectedDateApproved!,
                          purpose: _purposeController.text,
                          recognizedAmount: _recognizedAmountController.text,
                          comments: _commentsController.text,
                        )
                            .then((_) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text('Отчет успешно создан!')),
                          );
                          setState(() {
                            selectedDepartmentId = null;
                            selectedJobId = null;
                            selectedEmployeeId = null;
                            selectedAccountId = null;
                            _dateReceivedController.clear();
                            _amountIssuedController.clear();
                            _dateApprovedController.clear();
                            _purposeController.clear();
                            _recognizedAmountController.clear();
                            _commentsController.clear();
                            _initializeDefaultValues();
                          });
                        }).catchError((error) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                                content:
                                Text('Ошибка при создании отчета: $error')),
                          );
                        });
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                              content: Text(
                                  'Выберите филиал, должность, сотрудника и счет!')),
                        );
                      }
                    },
                    child: Text('Создать отчет'),
                  ),
                ),
                SizedBox(width: 10),
                Expanded(
                  child: ElevatedButton(
                    onPressed: () {
                      setState(() {
                        _showViewFields = !_showViewFields;
                        if (_showViewFields) {
                          _viewFields.add({
                            'Филиал': selectedDepartment?.name ?? 'Не выбран',
                            'Должность': selectedJob?.name ?? 'Не выбран',
                            'Сотрудник': selectedEmployee?.name ?? 'Не выбран',
                            'Счет': selectedAccount?.name ?? 'Не выбран',
                            'Дата получения д/с': _dateReceivedController.text,
                            'Выданная сумма': _amountIssuedController.text,
                            'Дата утверждения а/о':
                            _dateApprovedController.text,
                            'Назначение': _purposeController.text,
                            'Признанная сумма затрат по а/о':
                            _recognizedAmountController.text,
                            'Комментарии': _commentsController.text,
                          });
                        }
                      });
                    },
                    child: Text('Просмотр'),
                  ),
                ),
              ],
            ),

            // Просмотр
            if (_showViewFields)
              Column(
                children: _viewFields.map((field) {
                  return _buildViewRow(field);
                }).toList(),
              ),
          ],
        ),
      ),
    );
  }

  Widget _buildViewRow(Map<String, String> field) {
    return Card(
      margin: EdgeInsets.symmetric(vertical: 5),
      child: Row(
        children: [
          Expanded(
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: field.entries.map((entry) {
                  return Container(
                    width: 150, // Фиксированная ширина для каждого поля
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          entry.key,
                          style: TextStyle(
                              fontSize: 12, fontWeight: FontWeight.bold),
                        ),
                        Text(
                          entry.value,
                          style: TextStyle(fontSize: 12),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ],
                    ),
                  );
                }).toList(),
              ),
            ),
          ),
          IconButton(
            icon: Icon(Icons.delete, color: Colors.red),
            onPressed: () {
              _showDeleteDialog(field);
            },
          ),
        ],
      ),
    );
  }

  void _showDeleteDialog(Map<String, String> field) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Удалить запись?'),
          content: Text('Вы уверены, что хотите удалить эту запись?'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text('Отмена'),
            ),
            TextButton(
              onPressed: () {
                setState(() {
                  _viewFields.remove(field);
                });
                Navigator.pop(context);
              },
              child: Text('Удалить', style: TextStyle(color: Colors.red)),
            ),
          ],
        );
      },
    );
  }

  void _showPurposeDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) =>
          AlertDialog(
            title: Text('Выбери шаблон назначения'),
            content: SizedBox(
              width: double.maxFinite,
              child: ListView.builder(
                shrinkWrap: true,
                itemCount: purposeTemplates.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    title: Text(
                      purposeTemplates[index],
                      style: TextStyle(fontSize: 14),
                    ),
                    onTap: () {
                      setState(() {
                        _purposeController.text = purposeTemplates[index];
                      });
                      Navigator.pop(context);
                    },
                  );
                },
              ),
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: Text('Отмена'),
              ),
            ],
          ),
    );
  }
}