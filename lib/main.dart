import 'package:advance_report_frontend/providers/binding_provider.dart';
import 'package:advance_report_frontend/providers/department_provider.dart';
import 'package:advance_report_frontend/providers/employee_provider.dart';
import 'package:advance_report_frontend/providers/user_department_binding_provider.dart';
import 'package:advance_report_frontend/screens/create_report_screen.dart';
import 'package:advance_report_frontend/screens/report_screen/reports_screen.dart';
import 'package:advance_report_frontend/service/api_service.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'service/auth_service.dart';
import 'screens/login_screen.dart';
import 'providers/user_provider.dart';
import 'providers/account_provider.dart';
import 'providers/job_provider.dart';
import 'providers/report_provider.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final authService = AuthService();
  await authService.autoLogin(); // Проверяем сохраненный токен
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider<AuthService>.value(value: authService),  // Один экземпляр с токеном

        ProxyProvider<AuthService, ApiService>(
          update: (_, authService, __) => ApiService(authService.dioInstance, authService),
        ),
        ChangeNotifierProxyProvider<ApiService, UserProvider>(
          create: (_) => UserProvider(ApiService(authService.dioInstance, authService)),
          update: (_, apiService, __) => UserProvider(apiService),
        ),
        ChangeNotifierProxyProvider<ApiService, BindingProvider>(
          create: (_) => BindingProvider(ApiService(authService.dioInstance, authService)),
          update: (_, apiService, __) => BindingProvider(apiService),
        ),
        ChangeNotifierProxyProvider<ApiService, DepartmentProvider>(
          create: (_) => DepartmentProvider(ApiService(authService.dioInstance, authService)),
          update: (_, apiService, __) => DepartmentProvider(apiService),
        ),
        ChangeNotifierProxyProvider<ApiService, EmployeeProvider>(
          create: (_) => EmployeeProvider(ApiService(authService.dioInstance, authService)),
          update: (_, apiService, __) => EmployeeProvider(apiService),
        ),
        ChangeNotifierProxyProvider<ApiService, JobProvider>(
          create: (_) => JobProvider(ApiService(authService.dioInstance, authService)),
          update: (_, apiService, __) => JobProvider(apiService),
        ),
        ChangeNotifierProxyProvider<ApiService, AccountProvider>(
          create: (_) => AccountProvider(ApiService(authService.dioInstance, authService)),
          update: (_, apiService, __) => AccountProvider(apiService),
        ),
        ChangeNotifierProxyProvider<ApiService, ReportProvider>(
          create: (_) => ReportProvider(ApiService(authService.dioInstance, authService)),
          update: (_, apiService, __) => ReportProvider(apiService),
        ),
        ChangeNotifierProxyProvider<ApiService, UserDepartmentBindingProvider>(
          create: (_) => UserDepartmentBindingProvider(ApiService(authService.dioInstance, authService)),
          update: (_, apiService, __) => UserDepartmentBindingProvider(apiService),
        ),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Авансовые отчеты',
      theme: ThemeData(primarySwatch: Colors.blue),
      initialRoute: '/login',
      routes: {
        '/login': (context) => const LoginScreen(),
        '/home': (context) => HomeScreen(),
      },
    );
  }
}

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0;

  final List<Widget> _screens = [
    ReportsScreen(), // Список отчетов
    CreateReportScreen(), // Создание отчетов
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Управление отчетами'),
        actions: [
          IconButton(
            icon: Icon(Icons.logout),
            onPressed: () async {
              try {
                final authService = Provider.of<AuthService>(context, listen: false);
                await authService.logout();
                Navigator.of(context).pushReplacementNamed('/login');
              } catch (e) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('Ошибка при выходе: $e')),
                );
              }
            },
            tooltip: 'Выйти',
          ),
        ],
      ),
      body: _screens[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: (index) => setState(() => _selectedIndex = index),
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.list), label: 'Журнал учета авансовых отчетов'),
          BottomNavigationBarItem(icon: Icon(Icons.add), label: 'Создание отчетов'),
        ],
      ),
    );
  }
}