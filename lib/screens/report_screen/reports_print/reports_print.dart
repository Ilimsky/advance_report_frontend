import 'package:advance_report_frontend/screens/report_screen/reports_print/pdf_service.dart';
import 'package:flutter/material.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';
import 'package:intl/intl.dart';

import '../../../models/Report.dart';
import '../../../models/Department.dart';
import '../../../models/Job.dart';
import '../../../models/Employee.dart';
import '../../../models/Account.dart';
import '../../../providers/account_provider.dart';
import '../../../providers/department_provider.dart';
import '../../../providers/employee_provider.dart';
import '../../../providers/job_provider.dart';
import 'build_table.dart';

// Кэш для шрифта
pw.Font? _cachedFont;

Future<pw.Font> _getPdfFont() async {
  _cachedFont ??= await PdfGoogleFonts.robotoRegular();
  return _cachedFont!;
}

Future<void> printReport(
    Report report,
    Department department,
    Job job,
    Employee employee,
    Account account,
    ) async {
  final pdf = pw.Document();
  final dateFormat = DateFormat('dd.MM.yyyy');
  final font = await PdfService.font;

  double cmToPoints(double cm) => cm * 28.3465;

  const double fontSize = 8.0;

  pdf.addPage(
    pw.Page(
      pageFormat: PdfPageFormat.a4,
      build: (pw.Context context) {
        return pw.Column(
          crossAxisAlignment: pw.CrossAxisAlignment.start,
          children: [
            buildTable(
              font,
              fontSize,
              cmToPoints,
              report,
              account,
              department,
              dateFormat,
              job,
              employee,
            ),
          ],
        );
      },
    ),
  );

  await Printing.layoutPdf(
    onLayout: (PdfPageFormat format) async => pdf.save(),
  );
}

void printAllReports({
  required BuildContext context,
  required List<Report> reports,
  required DepartmentProvider departmentProvider,
  required JobProvider jobProvider,
  required EmployeeProvider employeeProvider,
  required AccountProvider accountProvider,
}) async {
  if (reports.isEmpty) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Нет данных для печати')));
    return;
  }

  try {
    // Показываем индикатор загрузки
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => AlertDialog(
        content: Row(
          children: [
            CircularProgressIndicator(),
            SizedBox(width: 20),
            Text('Подготовка документа...'),
          ],
        ),
      ),
    );

    // Используем общий метод для получения шрифта
    final font = await _getPdfFont();

    // Создаем PDF документ
    final pdf = pw.Document();

    // Добавляем страницу
    pdf.addPage(
      pw.MultiPage(
        pageFormat: PdfPageFormat.a4,
        margin: pw.EdgeInsets.all(20),
        theme: pw.ThemeData.withFont(
          base: font,
        ),
        build: (context) => [
          _buildHeader(font),
          pw.SizedBox(height: 20),
          _buildReportsTable(
            font: font,
            reports: reports,
            departmentProvider: departmentProvider,
            jobProvider: jobProvider,
            employeeProvider: employeeProvider,
            accountProvider: accountProvider,
          ),
        ],
      ),
    );

    // Закрываем диалог загрузки
    Navigator.of(context).pop();

    // Печатаем документ
    await Printing.layoutPdf(
      onLayout: (PdfPageFormat format) async => pdf.save(),
    );
  } catch (e) {
    Navigator.of(context).pop();
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Ошибка при печати: $e')));
  }
}

// Обновляем методы, чтобы принимать шрифт как параметр
pw.Widget _buildHeader(pw.Font font) {
  return pw.Column(
    crossAxisAlignment: pw.CrossAxisAlignment.start,
    children: [
      pw.Text(
        'ЖУРНАЛ АВАНСОВЫХ ОТЧЕТОВ на ${DateFormat('dd.MM.yyyy').format(DateTime.now())}',
        style: pw.TextStyle(
          fontSize: 16,
          fontWeight: pw.FontWeight.bold,
          font: font, // Используем переданный шрифт
        ),
      ),
    ],
  );
}

pw.Widget _buildReportsTable({
  required pw.Font font,
  required List<Report> reports,
  required DepartmentProvider departmentProvider,
  required JobProvider jobProvider,
  required EmployeeProvider employeeProvider,
  required AccountProvider accountProvider,
}) {
  final dateFormat = DateFormat('dd.MM.yyyy');

  return pw.Table(
    border: pw.TableBorder.all(),
    columnWidths: {
      0: pw.FlexColumnWidth(0.3),
      1: pw.FlexColumnWidth(0.8),
      2: pw.FlexColumnWidth(0.8),
      3: pw.FlexColumnWidth(0.7),
      4: pw.FlexColumnWidth(0.8),
      5: pw.FlexColumnWidth(1.2),
      6: pw.FlexColumnWidth(1.5),
      7: pw.FlexColumnWidth(2.0),
      8: pw.FlexColumnWidth(0.7),
      9: pw.FlexColumnWidth(0.6),
      10: pw.FlexColumnWidth(1.5),
    },
    children: [
      pw.TableRow(
        children: [
          _buildHeaderCell('№ п/п', font),
          _buildHeaderCell('Номер отчета', font),
          _buildHeaderCell('Дата получения д/с', font),
          _buildHeaderCell('Выданная сумма', font),
          _buildHeaderCell('Дата утверждения а/о', font),
          _buildHeaderCell('Должность', font),
          _buildHeaderCell('Сотрудник', font),
          _buildHeaderCell('Назначение', font),
          _buildHeaderCell('Признанная сумма', font),
          _buildHeaderCell('Счет', font),
          _buildHeaderCell('Комментарии', font),
        ],
        decoration: pw.BoxDecoration(color: PdfColors.grey300),
      ),
      ...reports.asMap().entries.map((entry) {
        final index = entry.key;
        final report = entry.value;

        final department = departmentProvider.departments.firstWhere(
              (d) => d.id == report.departmentId,
          orElse: () => Department(id: 0, name: 'Неизвестно'),
        );
        final job = jobProvider.jobs.firstWhere(
              (j) => j.id == report.jobId,
          orElse: () => Job(id: 0, name: 'Неизвестно'),
        );
        final employee = employeeProvider.employees.firstWhere(
              (e) => e.id == report.employeeId,
          orElse: () => Employee(id: 0, name: 'Неизвестно'),
        );
        final account = accountProvider.accounts.firstWhere(
              (a) => a.id == report.accountId,
          orElse: () => Account(id: 0, name: 'Неизвестно'),
        );

        return pw.TableRow(
          children: [
            _buildDataCell('${index + 1}', font),
            _buildDataCell('${report.reportNumber}/${department.name}', font),
            _buildDataCell(dateFormat.format(report.dateReceived), font),
            _buildDataCell(report.amountIssued, font),
            _buildDataCell(
              report.dateApproved != null
                  ? dateFormat.format(report.dateApproved!)
                  : '-',
              font,
            ),
            _buildDataCell(_truncateText(job.name, 20), font),
            _buildDataCell(_truncateText(employee.name, 25), font),
            _buildDataCell(_truncateText(report.purpose, 30), font),
            _buildDataCell(report.recognizedAmount, font),
            _buildDataCell(account.name.length > 4
                ? account.name.substring(0, 4)
                : account.name, font),
            _buildDataCell(_truncateText(report.comments, 25), font),
          ],
        );
      }).toList(),
    ],
  );
}

// Обновляем методы ячеек для приема шрифта
pw.Widget _buildHeaderCell(String text, pw.Font font) {
  return pw.Padding(
    padding: pw.EdgeInsets.all(4),
    child: pw.Text(
      text,
      style: pw.TextStyle(
        fontSize: 7,
        fontWeight: pw.FontWeight.bold,
        font: font,
      ),
      textAlign: pw.TextAlign.center,
    ),
  );
}

pw.Widget _buildDataCell(String text, pw.Font font) {
  return pw.Padding(
    padding: pw.EdgeInsets.all(4),
    child: pw.Text(
      text,
      style: pw.TextStyle(fontSize: 6, font: font),
      textAlign: pw.TextAlign.center,
      maxLines: 2,
    ),
  );
}

String _truncateText(String text, int maxLength) {
  if (text.length <= maxLength) return text;
  return text.substring(0, maxLength) + '...';
}