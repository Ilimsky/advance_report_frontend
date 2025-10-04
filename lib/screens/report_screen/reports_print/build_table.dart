import 'package:advance_report_frontend/models/Department.dart';
import 'package:advance_report_frontend/models/Job.dart';
import 'package:intl/intl.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;

import '../../../models/Account.dart';
import '../../../models/Employee.dart';
import '../../../models/Report.dart';
import 'number_to_words.dart';

pw.Widget buildTable(
  pw.Font font,
  double fontSize,
  double Function(double) cmToPoints,
  Report report,
  Account account,
  Department department,
  DateFormat dateFormat,
  Job job,
  Employee employee,

) {
  final cellPadding = pw.EdgeInsets.symmetric(
    vertical: cmToPoints(0.1),
    horizontal: cmToPoints(0.3),
  );

  return pw.Column(

    crossAxisAlignment: pw.CrossAxisAlignment.start,

    children: [
      // Первая строка
      pw.Row(
        children: [
          pw.Container(
            width: cmToPoints(4),
            padding: cellPadding,
            decoration: pw.BoxDecoration(border: null),
            child: pw.Text(
              'Организация: ',
              style: pw.TextStyle(font: font, fontSize: fontSize),
              textAlign: pw.TextAlign.right,
            ),
          ),
          pw.Container(
            width: cmToPoints(4),
            padding: cellPadding,
            decoration: pw.BoxDecoration(border: null),
            child: pw.Text(
              'ОсДО РосЛомбард',
              style: pw.TextStyle(font: font, fontSize: fontSize),
              textAlign: pw.TextAlign.left,
            ),
          ),
          pw.Container(
            width: cmToPoints(4),
            padding: cellPadding,
            decoration: pw.BoxDecoration(border: null),
            child: pw.Text(
              '',
              style: pw.TextStyle(font: font, fontSize: fontSize),
            ),
          ),
          pw.Container(
            width: cmToPoints(2),
            padding: cellPadding,
            decoration: pw.BoxDecoration(border: null),
            child: pw.Text(
              'Филиал: ',
              style: pw.TextStyle(font: font, fontSize: fontSize),
              textAlign: pw.TextAlign.right,
            ),
          ),
          pw.Container(
            width: cmToPoints(4),
            padding: cellPadding,
            decoration: pw.BoxDecoration(border: null),
            child: pw.Text(
              'Ломбард №${department.name}',
              style: pw.TextStyle(font: font, fontSize: fontSize),
              textAlign: pw.TextAlign.left,
            ),
          ),
        ],
      ),
      pw.SizedBox(height: cmToPoints(0.00)),
      // Вторая строка
      pw.Row(
        children: [
          pw.Container(
            width: cmToPoints(4),
            padding: cellPadding,
            decoration: pw.BoxDecoration(border: null),
            child: pw.Text(
              'Должность: ',
              style: pw.TextStyle(font: font, fontSize: fontSize),
              textAlign: pw.TextAlign.right,
            ),
          ),
          pw.Container(
            width: cmToPoints(4),
            padding: cellPadding,
            decoration: pw.BoxDecoration(border: null),
            child: pw.Text(
              job.name,
              style: pw.TextStyle(font: font, fontSize: fontSize),
              textAlign: pw.TextAlign.left,
            ),
          ),
          pw.Container(
            width: cmToPoints(4),
            padding: cellPadding,
            decoration: pw.BoxDecoration(border: null),
            child: pw.Text(
              '',
              style: pw.TextStyle(font: font, fontSize: fontSize),
            ),
          ),
          pw.Container(
            width: cmToPoints(2),
            padding: cellPadding,
            decoration: pw.BoxDecoration(border: null),
            child: pw.Text(
              'Ф.И.О.: ',
              style: pw.TextStyle(font: font, fontSize: fontSize),
              textAlign: pw.TextAlign.right,
            ),
          ),
          pw.Container(
            width: cmToPoints(4),
            padding: cellPadding,
            decoration: pw.BoxDecoration(border: null),
            child: pw.Text(
              employee.name,
              style: pw.TextStyle(font: font, fontSize: fontSize),
              textAlign: pw.TextAlign.left,
            ),
          ),
        ],
      ),
      pw.SizedBox(height: cmToPoints(0.00)),
      // Третья строка
      pw.Row(
        children: [
          pw.Container(
            width: cmToPoints(10),
            padding: cellPadding,
            decoration: pw.BoxDecoration(border: null),
            child: pw.Text(
              'АВАНСОВЫЙ ОТЧЕТ №${report.reportNumber}/${department.name} от ${dateFormat.format(report.dateReceived)}',
              style: pw.TextStyle(font: font, fontSize: fontSize),
              textAlign: pw.TextAlign.left,
            ),
          ),
          pw.Container(
            width: cmToPoints(4),
            padding: cellPadding,
            decoration: pw.BoxDecoration(border: null),
            child: pw.Text(
              '',
              style: pw.TextStyle(font: font, fontSize: fontSize),
            ),
          ),
          pw.Container(
            width: cmToPoints(4),
            padding: cellPadding,
            decoration: pw.BoxDecoration(
              border: pw.Border(
                left: pw.BorderSide(width: cmToPoints(0.01)),
                right: pw.BorderSide(width: cmToPoints(0.01)),
                bottom: pw.BorderSide.none,
                top: pw.BorderSide(width: cmToPoints(0.01)),
              ),
            ),
            child: pw.Text(
              'Проводка №________',
              style: pw.TextStyle(font: font, fontSize: fontSize),
            ),
          ),
        ],
      ),
      pw.SizedBox(height: cmToPoints(0.00)),
      // Четвертая строка
      pw.Row(
        children: [
          pw.Container(
            width: cmToPoints(4),
            padding: cellPadding,
            decoration: pw.BoxDecoration(border: null),
            child: pw.Text(
              'НАЗНАЧЕНИЕ АВАНСА: ',
              style: pw.TextStyle(font: font, fontSize: fontSize),
              textAlign: pw.TextAlign.left,
            ),
          ),
          pw.Container(
            width: cmToPoints(10),
            padding: cellPadding,
            decoration: pw.BoxDecoration(border: null),
            child: pw.Text(
              report.purpose,
              style: pw.TextStyle(font: font, fontSize: fontSize),
              textAlign: pw.TextAlign.left,
            ),
          ),
          pw.Container(
            width: cmToPoints(4),
            padding: cellPadding,
            decoration: pw.BoxDecoration(
              border: pw.Border(
                left: pw.BorderSide(width: cmToPoints(0.01)),
                right: pw.BorderSide(width: cmToPoints(0.01)),
                bottom: pw.BorderSide.none,
                top: pw.BorderSide.none,
              ),
            ),
            child: pw.Text(
              'от ${dateFormat.format(report.dateReceived)}',
              style: pw.TextStyle(font: font, fontSize: fontSize),
            ),
          ),
          // pw.Container(
          //   width: cmToPoints(3),
          //   padding: cellPadding,
          //   decoration: pw.BoxDecoration(
          //     border: pw.Border(
          //       left: pw.BorderSide.none,
          //       right: pw.BorderSide(width: cmToPoints(0.01)),
          //       bottom: pw.BorderSide.none,
          //       top: pw.BorderSide.none,
          //     ),
          //   ),
          //   child: pw.Text(
          //     dateFormat.format(report.dateReceived),
          //     style: pw.TextStyle(font: font, fontSize: fontSize),
          //     textAlign: pw.TextAlign.center,
          //   ),
          // ),
        ],
      ),
      pw.SizedBox(height: cmToPoints(0.00)),
      // Пятая строка
      pw.Row(
        children: [
          pw.Container(
            width: cmToPoints(6),
            padding: cellPadding,
            decoration: pw.BoxDecoration(border: null),
            child: pw.Text(
              '',
              style: pw.TextStyle(font: font, fontSize: fontSize),
              textAlign: pw.TextAlign.center,
            ),
          ),
          pw.Container(
            width: cmToPoints(2),
            padding: cellPadding,
            decoration: pw.BoxDecoration(
              border: pw.Border.all(width: cmToPoints(0.01)),
            ),
            child: pw.Text(
              'Сумма',
              style: pw.TextStyle(font: font, fontSize: fontSize),
              textAlign: pw.TextAlign.center,
            ),
          ),
          pw.Container(
            width: cmToPoints(2),
            padding: cellPadding,
            decoration: pw.BoxDecoration(border: null),
            child: pw.Text(
              '',
              style: pw.TextStyle(font: font, fontSize: fontSize),
            ),
          ),
          pw.Container(
            width: cmToPoints(2),
            padding: cellPadding,
            decoration: pw.BoxDecoration(border: null),
            child: pw.Text(
              '',
              style: pw.TextStyle(font: font, fontSize: fontSize),
              textAlign: pw.TextAlign.center,
            ),
          ),
          pw.Container(
            width: cmToPoints(2),
            padding: cellPadding,
            decoration: pw.BoxDecoration(border: null),
            child: pw.Text(
              '',
              style: pw.TextStyle(font: font, fontSize: fontSize),
            ),
          ),
          pw.Container(
            width: cmToPoints(4), // Ширина двух столбцов (2 + 2)
            padding: cellPadding,
            decoration: pw.BoxDecoration(
              border: pw.Border.all(width: cmToPoints(0.01)),
            ),
            child: pw.Text(
              'Дебет',
              style: pw.TextStyle(font: font, fontSize: fontSize),
              textAlign: pw.TextAlign.center,
            ),
          ),
        ],
      ),
      pw.SizedBox(height: cmToPoints(0.00)),
      // Шестая строка
      pw.Row(
        children: [
          pw.Container(
            width: cmToPoints(2),
            padding: cellPadding,
            decoration: pw.BoxDecoration(
              border: pw.Border.all(width: cmToPoints(0.01)),
            ),
            child: pw.Text(
              'Остаток',
              style: pw.TextStyle(font: font, fontSize: fontSize),
              textAlign: pw.TextAlign.right,
            ),
          ),
          pw.Container(
            width: cmToPoints(4),
            padding: cellPadding,
            decoration: pw.BoxDecoration(
              border: pw.Border(
                left: pw.BorderSide(width: cmToPoints(0.01)),
                right: pw.BorderSide(width: cmToPoints(0.01)),
                bottom: pw.BorderSide.none,
                top: pw.BorderSide(width: cmToPoints(0.01)),
              ),
            ),
            child: pw.Text(
              'предыдущего',
              style: pw.TextStyle(font: font, fontSize: fontSize),
              textAlign: pw.TextAlign.center,
            ),
          ),
          pw.Container(
            width: cmToPoints(2),
            padding: cellPadding,
            decoration: pw.BoxDecoration(
              border: pw.Border.all(width: cmToPoints(0.01)),
            ),
            child: pw.Text(
              '__',
              style: pw.TextStyle(
                font: font,
                fontSize: fontSize,
                color: PdfColor(1, 1, 1),
              ),
            ),
          ),
          pw.Container(
            width: cmToPoints(6),
            padding: cellPadding,
            decoration: pw.BoxDecoration(
              border: pw.Border(
                left: pw.BorderSide(width: cmToPoints(0.01)),
                right: pw.BorderSide(width: cmToPoints(0.01)),
                bottom: pw.BorderSide.none,
                top: pw.BorderSide(width: cmToPoints(0.01)),
              ),
            ),
            child: pw.Text(
              'К утверждению',
              style: pw.TextStyle(font: font, fontSize: fontSize),
              textAlign: pw.TextAlign.left,
            ),
          ),
          pw.Container(
            width: cmToPoints(2),
            padding: cellPadding,
            decoration: pw.BoxDecoration(
              border: pw.Border.all(width: cmToPoints(0.01)),
            ),
            child: pw.Text(
              'счет',
              style: pw.TextStyle(font: font, fontSize: fontSize),
              textAlign: pw.TextAlign.center,
            ),
          ),
          pw.Container(
            width: cmToPoints(2),
            padding: cellPadding,
            decoration: pw.BoxDecoration(
              border: pw.Border.all(width: cmToPoints(0.01)),
            ),
            child: pw.Text(
              'сумма',
              style: pw.TextStyle(font: font, fontSize: fontSize),
              textAlign: pw.TextAlign.center,
            ),
          ),
        ],
      ),
      pw.SizedBox(height: cmToPoints(0.00)),
      // Седьмая строка
      pw.Row(
        children: [
          pw.Container(
            width: cmToPoints(2),
            padding: cellPadding,
            decoration: pw.BoxDecoration(
              border: pw.Border.all(width: cmToPoints(0.01)),
            ),
            child: pw.Text(
              'Перерасход',
              style: pw.TextStyle(font: font, fontSize: 7.0),
              textAlign: pw.TextAlign.right,
            ),
          ),
          pw.Container(
            width: cmToPoints(4),
            padding: cellPadding,
            decoration: pw.BoxDecoration(
              border: pw.Border(
                left: pw.BorderSide(width: cmToPoints(0.01)),
                right: pw.BorderSide(width: cmToPoints(0.01)),
                bottom: pw.BorderSide(width: cmToPoints(0.01)),
                top: pw.BorderSide.none,
              ),
            ),
            child: pw.Text(
              'аванса',
              style: pw.TextStyle(font: font, fontSize: fontSize),
              textAlign: pw.TextAlign.center,
            ),
          ),
          pw.Container(
            width: cmToPoints(2),
            padding: cellPadding,
            decoration: pw.BoxDecoration(
              border: pw.Border.all(width: cmToPoints(0.01)),
            ),
            child: pw.Text(
              '__',
              style: pw.TextStyle(
                font: font,
                fontSize: fontSize,
                color: PdfColor(1, 1, 1),
              ),
            ),
          ),
          pw.Container(
            width: cmToPoints(6),
            padding: cellPadding,
            decoration: pw.BoxDecoration(
              border: pw.Border(
                left: pw.BorderSide(width: cmToPoints(0.01)),
                right: pw.BorderSide(width: cmToPoints(0.01)),
                bottom: pw.BorderSide.none,
                top: pw.BorderSide.none,
              ),
            ),
            child: pw.Text(
              '${report.recognizedAmount} сом',
              style: pw.TextStyle(font: font, fontSize: fontSize),
              textAlign: pw.TextAlign.left,
            ),
          ),
          pw.Container(
            width: cmToPoints(2),
            padding: cellPadding,
            decoration: pw.BoxDecoration(
              border: pw.Border.all(width: cmToPoints(0.01)),
            ),
            child: pw.Text(
              account.name.length > 4
                  ? account.name.substring(0, 4)
                  : account.name,
              style: pw.TextStyle(font: font, fontSize: fontSize),
              textAlign: pw.TextAlign.center,
            ),
          ),
          pw.Container(
            width: cmToPoints(2),
            padding: cellPadding,
            decoration: pw.BoxDecoration(
              border: pw.Border.all(width: cmToPoints(0.01)),
            ),
            child: pw.Text(
              report.recognizedAmount,
              style: pw.TextStyle(font: font, fontSize: fontSize),
              textAlign: pw.TextAlign.center,
            ),
          ),
        ],
      ),
      pw.SizedBox(height: cmToPoints(0.00)),
      // Восьмая строка
      pw.Row(
        children: [
          pw.Container(
            width: cmToPoints(6),
            padding: cellPadding,
            decoration: pw.BoxDecoration(border: null),
            child: pw.Text(
              'Получено (от кого)',
              style: pw.TextStyle(font: font, fontSize: 7.0),
              textAlign: pw.TextAlign.left,
            ),
          ),
          pw.Container(
            width: cmToPoints(2),
            padding: cellPadding,
            decoration: pw.BoxDecoration(
              border: pw.Border.all(width: cmToPoints(0.01)),
            ),
            child: pw.Text(
              '_',
              style: pw.TextStyle(
                font: font,
                fontSize: fontSize,
                color: PdfColor(1, 1, 1),
              ),
            ),
          ),
          pw.Container(
            width: cmToPoints(6),
            padding: cellPadding,
            decoration: pw.BoxDecoration(border: null),
            child: pw.Text(
              '',
              style: pw.TextStyle(font: font, fontSize: fontSize),
            ),
          ),
          pw.Container(
            width: cmToPoints(2),
            padding: cellPadding,
            decoration: pw.BoxDecoration(
              border: pw.Border.all(width: cmToPoints(0.01)),
            ),
            child: pw.Text(
              '_',
              style: pw.TextStyle(
                font: font,
                fontSize: fontSize,
                color: PdfColor(1, 1, 1),
              ),
              textAlign: pw.TextAlign.left,
            ),
          ),
          pw.Container(
            width: cmToPoints(2),
            padding: cellPadding,
            decoration: pw.BoxDecoration(
              border: pw.Border.all(width: cmToPoints(0.01)),
            ),
            child: pw.Text(
              '_',
              style: pw.TextStyle(
                font: font,
                fontSize: fontSize,
                color: PdfColor(1, 1, 1),
              ),
              textAlign: pw.TextAlign.center,
            ),
          ),
        ],
      ),
      pw.SizedBox(height: cmToPoints(0.00)),
      // Девятая строка
      pw.Row(
        children: [
          pw.Container(
            width: cmToPoints(6),
            padding: cellPadding,
            decoration: pw.BoxDecoration(
              border: pw.Border(
                left: pw.BorderSide.none,
                right: pw.BorderSide.none,
                bottom: pw.BorderSide.none,
                top: pw.BorderSide.none,
              ),
            ),
            child: pw.Text(
              '1. Из кассы ФРЛ-${department.name}',
              style: pw.TextStyle(font: font, fontSize: 7.0),
              textAlign: pw.TextAlign.left,
            ),
          ),
          pw.Container(
            width: cmToPoints(2),
            padding: cellPadding,
            decoration: pw.BoxDecoration(
              border: pw.Border.all(width: cmToPoints(0.01)),
            ),
            child: pw.Text(
              report.recognizedAmount,
              style: pw.TextStyle(font: font, fontSize: 7.0),
              textAlign: pw.TextAlign.center,
            ),
          ),
          pw.Container(
            width: cmToPoints(6),
            padding: cellPadding,
            decoration: pw.BoxDecoration(border: null),
            child: pw.Text(
              'Бухгалтер __________',
              style: pw.TextStyle(font: font, fontSize: fontSize),
            ),
          ),
          pw.Container(
            width: cmToPoints(2),
            padding: cellPadding,
            decoration: pw.BoxDecoration(
              border: pw.Border.all(width: cmToPoints(0.01)),
            ),
            child: pw.Text(
              '__',
              style: pw.TextStyle(
                font: font,
                fontSize: fontSize,
                color: PdfColor(1, 1, 1),
              ),
            ),
          ),
          pw.Container(
            width: cmToPoints(2),
            padding: cellPadding,
            decoration: pw.BoxDecoration(
              border: pw.Border.all(width: cmToPoints(0.01)),
            ),
            child: pw.Text(
              '__',
              style: pw.TextStyle(
                font: font,
                fontSize: fontSize,
                color: PdfColor(1, 1, 1),
              ),
              textAlign: pw.TextAlign.center,
            ),
          ),
        ],
      ),
      pw.SizedBox(height: cmToPoints(0.00)),
      // Десятая строка
      pw.Row(
        children: [
          pw.Container(
            width: cmToPoints(6),
            padding: cellPadding,
            decoration: pw.BoxDecoration(
              border: pw.Border(
                left: pw.BorderSide.none,
                right: pw.BorderSide.none,
                bottom: pw.BorderSide.none,
                top: pw.BorderSide.none,
              ),
            ),
            child: pw.Text(
              '2. _____________________________',
              style: pw.TextStyle(font: font, fontSize: 7.0),
              textAlign: pw.TextAlign.left,
            ),
          ),
          pw.Container(
            width: cmToPoints(2),
            padding: cellPadding,
            decoration: pw.BoxDecoration(
              border: pw.Border.all(width: cmToPoints(0.01)),
            ),
            child: pw.Text(
              '_',
              style: pw.TextStyle(
                font: font,
                fontSize: fontSize,
                color: PdfColor(1, 1, 1),
              ),
              textAlign: pw.TextAlign.left,
            ),
          ),
          pw.Container(
            width: cmToPoints(6),
            padding: cellPadding,
            decoration: pw.BoxDecoration(border: null),
            child: pw.Text(
              '',
              style: pw.TextStyle(font: font, fontSize: fontSize),
            ),
          ),
          pw.Container(
            width: cmToPoints(2),
            padding: cellPadding,
            decoration: pw.BoxDecoration(
              border: pw.Border.all(width: cmToPoints(0.01)),
            ),
            child: pw.Text(
              '__',
              style: pw.TextStyle(
                font: font,
                fontSize: fontSize,
                color: PdfColor(1, 1, 1),
              ),
            ),
          ),
          pw.Container(
            width: cmToPoints(2),
            padding: cellPadding,
            decoration: pw.BoxDecoration(
              border: pw.Border.all(width: cmToPoints(0.01)),
            ),
            child: pw.Text(
              '__',
              style: pw.TextStyle(
                font: font,
                fontSize: fontSize,
                color: PdfColor(1, 1, 1),
              ),
              textAlign: pw.TextAlign.center,
            ),
          ),
        ],
      ),
      pw.SizedBox(height: cmToPoints(0.00)),
      // Одинадцатая строка
      pw.Row(
        children: [
          pw.Container(
            width: cmToPoints(6),
            padding: cellPadding,
            decoration: pw.BoxDecoration(
              border: pw.Border(
                left: pw.BorderSide.none,
                right: pw.BorderSide.none,
                bottom: pw.BorderSide.none,
                top: pw.BorderSide.none,
              ),
            ),
            child: pw.Text(
              '3. _____________________________',
              style: pw.TextStyle(font: font, fontSize: 7.0),
              textAlign: pw.TextAlign.left,
            ),
          ),
          pw.Container(
            width: cmToPoints(2),
            padding: cellPadding,
            decoration: pw.BoxDecoration(
              border: pw.Border.all(width: cmToPoints(0.01)),
            ),
            child: pw.Text(
              '_',
              style: pw.TextStyle(
                font: font,
                fontSize: fontSize,
                color: PdfColor(1, 1, 1),
              ),
              textAlign: pw.TextAlign.left,
            ),
          ),
          pw.Container(
            width: cmToPoints(6),
            padding: cellPadding,
            decoration: pw.BoxDecoration(border: null),
            child: pw.Text(
              '',
              style: pw.TextStyle(font: font, fontSize: fontSize),
            ),
          ),
          pw.Container(
            width: cmToPoints(2),
            padding: cellPadding,
            decoration: pw.BoxDecoration(
              border: pw.Border.all(width: cmToPoints(0.01)),
            ),
            child: pw.Text(
              '__',
              style: pw.TextStyle(
                font: font,
                fontSize: fontSize,
                color: PdfColor(1, 1, 1),
              ),
            ),
          ),
          pw.Container(
            width: cmToPoints(2),
            padding: cellPadding,
            decoration: pw.BoxDecoration(
              border: pw.Border.all(width: cmToPoints(0.01)),
            ),
            child: pw.Text(
              '__',
              style: pw.TextStyle(
                font: font,
                fontSize: fontSize,
                color: PdfColor(1, 1, 1),
              ),
              textAlign: pw.TextAlign.center,
            ),
          ),
        ],
      ),
      pw.SizedBox(height: cmToPoints(0.00)),
      // Двенадцатая строка
      pw.Row(
        children: [
          pw.Container(
            width: cmToPoints(6),
            padding: cellPadding,
            decoration: pw.BoxDecoration(border: null),
            child: pw.Text(
              'Итого получено',
              style: pw.TextStyle(font: font, fontSize: fontSize),
              textAlign: pw.TextAlign.center,
            ),
          ),
          pw.Container(
            width: cmToPoints(2),
            padding: cellPadding,
            decoration: pw.BoxDecoration(
              border: pw.Border.all(width: cmToPoints(0.01)),
            ),
            child: pw.Text(
              report.recognizedAmount,
              style: pw.TextStyle(font: font, fontSize: fontSize),
              textAlign: pw.TextAlign.center,
            ),
          ),
          pw.Container(
            width: cmToPoints(6),
            padding: cellPadding,
            decoration: pw.BoxDecoration(
              border: pw.Border(
                left: pw.BorderSide.none,
                right: pw.BorderSide.none,
                bottom: pw.BorderSide.none,
                top: pw.BorderSide(width: cmToPoints(0.01)),
              ),
            ),
            child: pw.Text(
              'Отчет утверждаю в сумме:',
              style: pw.TextStyle(font: font, fontSize: fontSize),
            ),
          ),
          pw.Container(
            width: cmToPoints(4),
            padding: cellPadding,
            decoration: pw.BoxDecoration(
              border: pw.Border.all(width: cmToPoints(0.01)),
            ),
            child: pw.Text(
              'Кредит',
              style: pw.TextStyle(font: font, fontSize: fontSize),
              textAlign: pw.TextAlign.center,
            ),
          ),
        ],
      ),
      pw.SizedBox(height: cmToPoints(0.00)),
      // Тринадцатая строка
      pw.Row(
        children: [
          pw.Container(
            width: cmToPoints(6),
            padding: cellPadding,
            decoration: pw.BoxDecoration(border: null),
            child: pw.Text(
              'Израсходовано',
              style: pw.TextStyle(font: font, fontSize: fontSize),
              textAlign: pw.TextAlign.center,
            ),
          ),
          pw.Container(
            width: cmToPoints(2),
            padding: cellPadding,
            decoration: pw.BoxDecoration(
              border: pw.Border.all(width: cmToPoints(0.01)),
            ),
            child: pw.Text(
              report.recognizedAmount,
              style: pw.TextStyle(font: font, fontSize: fontSize),
              textAlign: pw.TextAlign.center,
            ),
          ),
          pw.Container(
            width: cmToPoints(6),
            padding: cellPadding,
            decoration: pw.BoxDecoration(
              border: pw.Border(
                left: pw.BorderSide.none,
                right: pw.BorderSide.none,
                bottom: pw.BorderSide.none,
                top: pw.BorderSide.none,
              ),
            ),
            child: pw.Text(
              '${report.recognizedAmount} (${numberToWords(report.recognizedAmount)})',
              style: pw.TextStyle(font: font, fontSize: fontSize),
            ),
          ),
          pw.Container(
            width: cmToPoints(2),
            padding: cellPadding,
            decoration: pw.BoxDecoration(
              border: pw.Border.all(width: cmToPoints(0.01)),
            ),
            child: pw.Text(
              '1100',
              style: pw.TextStyle(font: font, fontSize: fontSize),
              textAlign: pw.TextAlign.center,
            ),
          ),
          pw.Container(
            width: cmToPoints(2),
            padding: cellPadding,
            decoration: pw.BoxDecoration(
              border: pw.Border.all(width: cmToPoints(0.01)),
            ),
            child: pw.Text(
              report.recognizedAmount,
              style: pw.TextStyle(font: font, fontSize: fontSize),
              textAlign: pw.TextAlign.center,
            ),
          ),
        ],
      ),
      pw.SizedBox(height: cmToPoints(0.00)),
      // Четырнадцатая строка
      pw.Row(
        children: [
          pw.Container(
            width: cmToPoints(6),
            padding: cellPadding,
            decoration: pw.BoxDecoration(border: null),
            child: pw.Text(
              'Остаток',
              style: pw.TextStyle(font: font, fontSize: fontSize),
              textAlign: pw.TextAlign.center,
            ),
          ),
          pw.Container(
            width: cmToPoints(2),
            padding: cellPadding,
            decoration: pw.BoxDecoration(
              border: pw.Border.all(width: cmToPoints(0.01)),
            ),
            child: pw.Text(
              ' - ',
              style: pw.TextStyle(font: font, fontSize: fontSize),
              textAlign: pw.TextAlign.center,
            ),
          ),
          pw.Container(
            width: cmToPoints(6),
            padding: cellPadding,
            decoration: pw.BoxDecoration(
              border: pw.Border(
                left: pw.BorderSide.none,
                right: pw.BorderSide.none,
                bottom: pw.BorderSide.none,
                top: pw.BorderSide.none,
              ),
            ),
            child: pw.Text(
              '_',
              style: pw.TextStyle(
                font: font,
                fontSize: fontSize,
                color: PdfColor(1, 1, 1),
              ),
            ),
          ),
          pw.Container(
            width: cmToPoints(2),
            padding: cellPadding,
            decoration: pw.BoxDecoration(
              border: pw.Border.all(width: cmToPoints(0.01)),
            ),
            child: pw.Text(
              '_',
              style: pw.TextStyle(
                font: font,
                fontSize: fontSize,
                color: PdfColor(1, 1, 1),
              ),
              textAlign: pw.TextAlign.center,
            ),
          ),
          pw.Container(
            width: cmToPoints(2),
            padding: cellPadding,
            decoration: pw.BoxDecoration(
              border: pw.Border.all(width: cmToPoints(0.01)),
            ),
            child: pw.Text(
              '_',
              style: pw.TextStyle(
                font: font,
                fontSize: fontSize,
                color: PdfColor(1, 1, 1),
              ),
              textAlign: pw.TextAlign.center,
            ),
          ),
        ],
      ),
      pw.SizedBox(height: cmToPoints(0.00)),
      // Пятнадцатая строка
      pw.Row(
        children: [
          pw.Container(
            width: cmToPoints(6),
            padding: cellPadding,
            decoration: pw.BoxDecoration(border: null),
            child: pw.Text(
              'Перерасход',
              style: pw.TextStyle(font: font, fontSize: fontSize),
              textAlign: pw.TextAlign.center,
            ),
          ),
          pw.Container(
            width: cmToPoints(2),
            padding: cellPadding,
            decoration: pw.BoxDecoration(
              border: pw.Border.all(width: cmToPoints(0.01)),
            ),
            child: pw.Text(
              ' - ',
              style: pw.TextStyle(font: font, fontSize: fontSize),
              textAlign: pw.TextAlign.center,
            ),
          ),
          pw.Container(
            width: cmToPoints(6),
            padding: cellPadding,
            decoration: pw.BoxDecoration(
              border: pw.Border(
                left: pw.BorderSide.none,
                right: pw.BorderSide.none,
                bottom: pw.BorderSide.none,
                top: pw.BorderSide.none,
              ),
            ),
            child: pw.Text(
              '_',
              style: pw.TextStyle(
                font: font,
                fontSize: fontSize,
                color: PdfColor(1, 1, 1),
              ),
            ),
          ),
          pw.Container(
            width: cmToPoints(2),
            padding: cellPadding,
            decoration: pw.BoxDecoration(
              border: pw.Border.all(width: cmToPoints(0.01)),
            ),
            child: pw.Text(
              '_',
              style: pw.TextStyle(
                font: font,
                fontSize: fontSize,
                color: PdfColor(1, 1, 1),
              ),
              textAlign: pw.TextAlign.center,
            ),
          ),
          pw.Container(
            width: cmToPoints(2),
            padding: cellPadding,
            decoration: pw.BoxDecoration(
              border: pw.Border.all(width: cmToPoints(0.01)),
            ),
            child: pw.Text(
              '_',
              style: pw.TextStyle(
                font: font,
                fontSize: fontSize,
                color: PdfColor(1, 1, 1),
              ),
              textAlign: pw.TextAlign.center,
            ),
          ),
        ],
      ),
      pw.SizedBox(height: cmToPoints(0.00)),
      // Шестнадцатая строка
      pw.Row(
        children: [
          pw.Container(
            width: cmToPoints(8),
            padding: cellPadding,
            decoration: pw.BoxDecoration(border: null),
            child: pw.Text(
              '',
              style: pw.TextStyle(font: font, fontSize: fontSize),
              textAlign: pw.TextAlign.center,
            ),
          ),
          pw.Container(
            width: cmToPoints(6),
            padding: cellPadding,
            decoration: pw.BoxDecoration(
              border: pw.Border(
                left: pw.BorderSide(width: cmToPoints(0.01)),
                right: pw.BorderSide.none,
                bottom: pw.BorderSide.none,
                top: pw.BorderSide.none,
              ),
            ),
            child: pw.Text(
              'Руководитель ____________',
              style: pw.TextStyle(font: font, fontSize: fontSize),
              textAlign: pw.TextAlign.left,
            ),
          ),
          pw.Container(
            width: cmToPoints(2),
            padding: cellPadding,
            decoration: pw.BoxDecoration(
              border: pw.Border.all(width: cmToPoints(0.01)),
            ),
            child: pw.Text(
              '_',
              style: pw.TextStyle(
                font: font,
                fontSize: fontSize,
                color: PdfColor(1, 1, 1),
              ),
            ),
          ),
          pw.Container(
            width: cmToPoints(2),
            padding: cellPadding,
            decoration: pw.BoxDecoration(
              border: pw.Border.all(width: cmToPoints(0.01)),
            ),
            child: pw.Text(
              '_',
              style: pw.TextStyle(
                font: font,
                fontSize: fontSize,
                color: PdfColor(1, 1, 1),
              ),
              textAlign: pw.TextAlign.center,
            ),
          ),
        ],
      ),
      pw.SizedBox(height: cmToPoints(0.00)),
      // Семнадцатая строка
      pw.Row(
        children: [
          pw.Container(
            width: cmToPoints(8),
            padding: cellPadding,
            decoration: pw.BoxDecoration(border: null),
            child: pw.Text(
              'Приложение _____ документов',
              style: pw.TextStyle(font: font, fontSize: fontSize),
              textAlign: pw.TextAlign.left,
            ),
          ),
          pw.Container(
            width: cmToPoints(6),
            padding: cellPadding,
            decoration: pw.BoxDecoration(
              border: pw.Border(
                left: pw.BorderSide(width: cmToPoints(0.1)),
                right: pw.BorderSide.none,
                bottom: pw.BorderSide.none,
                top: pw.BorderSide.none,
              ),
            ),
            child: pw.Text(
              '_',
              style: pw.TextStyle(
                font: font,
                fontSize: fontSize,
                color: PdfColor(1, 1, 1),
              ),
              textAlign: pw.TextAlign.left,
            ),
          ),
          pw.Container(
            width: cmToPoints(2),
            padding: cellPadding,
            decoration: pw.BoxDecoration(
              border: pw.Border.all(width: cmToPoints(0.01)),
            ),
            child: pw.Text(
              '_',
              style: pw.TextStyle(
                font: font,
                fontSize: fontSize,
                color: PdfColor(1, 1, 1),
              ),
            ),
          ),
          pw.Container(
            width: cmToPoints(2),
            padding: cellPadding,
            decoration: pw.BoxDecoration(
              border: pw.Border.all(width: cmToPoints(0.01)),
            ),
            child: pw.Text(
              '_',
              style: pw.TextStyle(
                font: font,
                fontSize: fontSize,
                color: PdfColor(1, 1, 1),
              ),
              textAlign: pw.TextAlign.center,
            ),
          ),
        ],
      ),
      pw.SizedBox(height: cmToPoints(0.00)),
      // Восемнадцатая строка
      pw.Row(
        children: [
          pw.Container(
            width: cmToPoints(2),
            padding: cellPadding,
            decoration: pw.BoxDecoration(
              border: pw.Border.all(width: cmToPoints(0.01)),
            ),
            child: pw.Text(
              'Дата',
              style: pw.TextStyle(font: font, fontSize: fontSize),
              textAlign: pw.TextAlign.center,
            ),
          ),
          pw.Container(
            width: cmToPoints(2),
            padding: cellPadding,
            decoration: pw.BoxDecoration(
              border: pw.Border.all(width: cmToPoints(0.01)),
            ),
            child: pw.Text(
              'Пор. № док-та',
              style: pw.TextStyle(font: font, fontSize: 6.0),
              textAlign: pw.TextAlign.left,
            ),
          ),
          pw.Container(
            width: cmToPoints(12),
            padding: cellPadding,
            decoration: pw.BoxDecoration(
              border: pw.Border.all(width: cmToPoints(0.01)),
            ),
            child: pw.Text(
              'Кому, за что и по какому документу уплачено',
              style: pw.TextStyle(font: font, fontSize: fontSize),
            ),
          ),
          pw.Container(
            width: cmToPoints(2),
            padding: cellPadding,
            decoration: pw.BoxDecoration(
              border: pw.Border.all(width: cmToPoints(0.01)),
            ),
            child: pw.Text(
              'Сумма',
              style: pw.TextStyle(font: font, fontSize: fontSize),
              textAlign: pw.TextAlign.center,
            ),
          ),
        ],
      ),
      pw.SizedBox(height: cmToPoints(0.00)),
      // Девятнадцатая строка
      pw.Row(
        children: [
          pw.Container(
            width: cmToPoints(2),
            padding: cellPadding,
            decoration: pw.BoxDecoration(
              border: pw.Border.all(width: cmToPoints(0.01)),
            ),
            child: pw.Text(
              dateFormat.format(report.dateReceived),
              style: pw.TextStyle(font: font, fontSize: fontSize),
              textAlign: pw.TextAlign.center,
            ),
          ),
          pw.Container(
            width: cmToPoints(2),
            padding: cellPadding,
            decoration: pw.BoxDecoration(
              border: pw.Border.all(width: cmToPoints(0.01)),
            ),
            child: pw.Text(
              '_',
              style: pw.TextStyle(
                font: font,
                fontSize: fontSize,
                color: PdfColor(1, 1, 1),
              ),
              textAlign: pw.TextAlign.left,
            ),
          ),
          pw.Container(
            width: cmToPoints(12),
            padding: cellPadding,
            decoration: pw.BoxDecoration(
              border: pw.Border.all(width: cmToPoints(0.01)),
            ),
            child: pw.Text(
              report.purpose,
              style: pw.TextStyle(font: font, fontSize: fontSize),
            ),
          ),
          pw.Container(
            width: cmToPoints(2),
            padding: cellPadding,
            decoration: pw.BoxDecoration(
              border: pw.Border.all(width: cmToPoints(0.01)),
            ),
            child: pw.Text(
              report.recognizedAmount,
              style: pw.TextStyle(font: font, fontSize: fontSize),
              textAlign: pw.TextAlign.center,
            ),
          ),
        ],
      ),
      pw.SizedBox(height: cmToPoints(0.00)),
      // Двадцатая строка
      pw.Row(
        children: [
          pw.Container(
            width: cmToPoints(2),
            padding: cellPadding,
            decoration: pw.BoxDecoration(
              border: pw.Border.all(width: cmToPoints(0.01)),
            ),
            child: pw.Text(
              '_',
              style: pw.TextStyle(
                font: font,
                fontSize: fontSize,
                color: PdfColor(1, 1, 1),
              ),
              textAlign: pw.TextAlign.center,
            ),
          ),
          pw.Container(
            width: cmToPoints(2),
            padding: cellPadding,
            decoration: pw.BoxDecoration(
              border: pw.Border.all(width: cmToPoints(0.01)),
            ),
            child: pw.Text(
              '_',
              style: pw.TextStyle(
                font: font,
                fontSize: fontSize,
                color: PdfColor(1, 1, 1),
              ),
            ),
          ),
          pw.Container(
            width: cmToPoints(12),
            padding: cellPadding,
            decoration: pw.BoxDecoration(
              border: pw.Border.all(width: cmToPoints(0.01)),
            ),
            child: pw.Text(
              '_',
              style: pw.TextStyle(
                font: font,
                fontSize: fontSize,
                color: PdfColor(1, 1, 1),
              ),
            ),
          ),
          pw.Container(
            width: cmToPoints(2),
            padding: cellPadding,
            decoration: pw.BoxDecoration(
              border: pw.Border.all(width: cmToPoints(0.01)),
            ),
            child: pw.Text(
              '_',
              style: pw.TextStyle(
                font: font,
                fontSize: fontSize,
                color: PdfColor(1, 1, 1),
              ),
              textAlign: pw.TextAlign.center,
            ),
          ),
        ],
      ),
      pw.SizedBox(height: cmToPoints(0.00)),
      // Двадцать первая строка
      pw.Row(
        children: [
          pw.Container(
            width: cmToPoints(2),
            padding: cellPadding,
            decoration: pw.BoxDecoration(
              border: pw.Border.all(width: cmToPoints(0.01)),
            ),
            child: pw.Text(
              '_',
              style: pw.TextStyle(
                font: font,
                fontSize: fontSize,
                color: PdfColor(1, 1, 1),
              ),
              textAlign: pw.TextAlign.center,
            ),
          ),
          pw.Container(
            width: cmToPoints(2),
            padding: cellPadding,
            decoration: pw.BoxDecoration(
              border: pw.Border.all(width: cmToPoints(0.01)),
            ),
            child: pw.Text(
              '_',
              style: pw.TextStyle(
                font: font,
                fontSize: fontSize,
                color: PdfColor(1, 1, 1),
              ),
            ),
          ),
          pw.Container(
            width: cmToPoints(12),
            padding: cellPadding,
            decoration: pw.BoxDecoration(
              border: pw.Border.all(width: cmToPoints(0.01)),
            ),
            child: pw.Text(
              '_',
              style: pw.TextStyle(
                font: font,
                fontSize: fontSize,
                color: PdfColor(1, 1, 1),
              ),
            ),
          ),
          pw.Container(
            width: cmToPoints(2),
            padding: cellPadding,
            decoration: pw.BoxDecoration(
              border: pw.Border.all(width: cmToPoints(0.01)),
            ),
            child: pw.Text(
              '_',
              style: pw.TextStyle(
                font: font,
                fontSize: fontSize,
                color: PdfColor(1, 1, 1),
              ),
              textAlign: pw.TextAlign.center,
            ),
          ),
        ],
      ),
      pw.SizedBox(height: cmToPoints(0.00)),
      // Двадцать вторая строка
      pw.Row(
        children: [
          pw.Container(
            width: cmToPoints(2),
            padding: cellPadding,
            decoration: pw.BoxDecoration(
              border: pw.Border.all(width: cmToPoints(0.01)),
            ),
            child: pw.Text(
              '_',
              style: pw.TextStyle(
                font: font,
                fontSize: fontSize,
                color: PdfColor(1, 1, 1),
              ),
              textAlign: pw.TextAlign.center,
            ),
          ),
          pw.Container(
            width: cmToPoints(2),
            padding: cellPadding,
            decoration: pw.BoxDecoration(
              border: pw.Border.all(width: cmToPoints(0.01)),
            ),
            child: pw.Text(
              '_',
              style: pw.TextStyle(
                font: font,
                fontSize: fontSize,
                color: PdfColor(1, 1, 1),
              ),
            ),
          ),
          pw.Container(
            width: cmToPoints(12),
            padding: cellPadding,
            decoration: pw.BoxDecoration(
              border: pw.Border.all(width: cmToPoints(0.01)),
            ),
            child: pw.Text(
              '_',
              style: pw.TextStyle(
                font: font,
                fontSize: fontSize,
                color: PdfColor(1, 1, 1),
              ),
            ),
          ),
          pw.Container(
            width: cmToPoints(2),
            padding: cellPadding,
            decoration: pw.BoxDecoration(
              border: pw.Border.all(width: cmToPoints(0.01)),
            ),
            child: pw.Text(
              '_',
              style: pw.TextStyle(
                font: font,
                fontSize: fontSize,
                color: PdfColor(1, 1, 1),
              ),
              textAlign: pw.TextAlign.center,
            ),
          ),
        ],
      ),
      pw.SizedBox(height: cmToPoints(0.00)),
      // Двадцать третья строка
      pw.Row(
        children: [
          pw.Container(
            width: cmToPoints(14),
            padding: cellPadding,
            decoration: pw.BoxDecoration(
              border: pw.Border(
                left: pw.BorderSide.none,
                right: pw.BorderSide.none,
                bottom: pw.BorderSide.none,
                top: pw.BorderSide.none,
              ),
            ),
            child: pw.Text(
              'Подпись подотчетного лица ___________',
              style: pw.TextStyle(font: font, fontSize: fontSize),
              textAlign: pw.TextAlign.center,
            ),
          ),
          pw.Container(
            width: cmToPoints(2),
            padding: cellPadding,
            decoration: pw.BoxDecoration(
              border: pw.Border(
                left: pw.BorderSide.none,
                right: pw.BorderSide.none,
                bottom: pw.BorderSide.none,
                top: pw.BorderSide.none,
              ),
            ),
            child: pw.Text(
              'Всего',
              style: pw.TextStyle(font: font, fontSize: fontSize),
              textAlign: pw.TextAlign.center,
            ),
          ),
          pw.Container(
            width: cmToPoints(2),
            padding: cellPadding,
            decoration: pw.BoxDecoration(
              border: pw.Border.all(width: cmToPoints(0.01)),
            ),
            child: pw.Text(
              report.recognizedAmount,
              style: pw.TextStyle(font: font, fontSize: fontSize),
              textAlign: pw.TextAlign.center,
            ),
          ),
        ],
      ),
    ],
  );
}
