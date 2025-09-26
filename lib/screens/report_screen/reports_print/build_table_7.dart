import 'package:advance_report_frontend/models/Department.dart';
import 'package:pdf/widgets.dart' as pw;

import '../../../models/Account.dart';
import '../../../models/Report.dart';

pw.Widget buildTable7(
  pw.Font font,
  double fontSize,
  double Function(double) cmToPoints,
  Report report,
  Account account,
  Department department,
) {
  return pw.Column(
    crossAxisAlignment: pw.CrossAxisAlignment.start,
    children: [
      // Первая строка с объединёнными первыми тремя ячейками
      pw.Row(
        children: [
          pw.Container(
            width: cmToPoints(6), // Ширина трёх столбцов (2 + 2 + 2)
            padding: pw.EdgeInsets.all(cmToPoints(0.2)),
            decoration: pw.BoxDecoration(border: null),
            child: pw.Text(
              '',
              style: pw.TextStyle(font: font, fontSize: fontSize),
              textAlign: pw.TextAlign.center,
            ),
          ),
          pw.Container(
            width: cmToPoints(2),
            padding: pw.EdgeInsets.all(cmToPoints(0.2)),
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
            padding: pw.EdgeInsets.all(cmToPoints(0.2)),
            decoration: pw.BoxDecoration(border: null),
            child: pw.Text(
              '',
              style: pw.TextStyle(font: font, fontSize: fontSize),
            ),
          ),
          pw.Container(
            width: cmToPoints(2),
            padding: pw.EdgeInsets.all(cmToPoints(0.2)),
            decoration: pw.BoxDecoration(border: null),
            child: pw.Text(
              '',
              style: pw.TextStyle(font: font, fontSize: fontSize),
              textAlign: pw.TextAlign.center,
            ),
          ),
          pw.Container(
            width: cmToPoints(2),
            padding: pw.EdgeInsets.all(cmToPoints(0.2)),
            decoration: pw.BoxDecoration(border: null),
            child: pw.Text(
              '',
              style: pw.TextStyle(font: font, fontSize: fontSize),
            ),
          ),
          pw.Container(
            width: cmToPoints(4), // Ширина двух столбцов (2 + 2)
            padding: pw.EdgeInsets.all(cmToPoints(0.2)),
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
      // Вторая строка
      pw.Row(
        children: [
          pw.Container(
            width: cmToPoints(2),
            padding: pw.EdgeInsets.all(cmToPoints(0.2)),
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
            width: cmToPoints(4), // Ширина двух столбцов (2 + 2)
            padding: pw.EdgeInsets.all(cmToPoints(0.2)),
            decoration: pw.BoxDecoration(
              border: pw.Border(
                left: pw.BorderSide(width: cmToPoints(0.01)),
                right: pw.BorderSide(width: cmToPoints(0.01)),
                bottom: pw.BorderSide.none,
                top: pw.BorderSide(
                  width: cmToPoints(0.01),
                ), // Убираем верхнюю границу
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
            padding: pw.EdgeInsets.all(cmToPoints(0.2)),
            decoration: pw.BoxDecoration(border: null),
            child: pw.Text(
              '',
              style: pw.TextStyle(font: font, fontSize: fontSize),
            ),
          ),
          pw.Container(
            width: cmToPoints(6), // Ширина двух столбцов (2 + 2)
            padding: pw.EdgeInsets.all(cmToPoints(0.2)),
            decoration: pw.BoxDecoration(
              border: pw.Border.all(width: cmToPoints(0.01)),
            ),
            child: pw.Text(
              'К утверждению',
              style: pw.TextStyle(font: font, fontSize: fontSize),
              textAlign: pw.TextAlign.left,
            ),
          ),
          pw.Container(
            width: cmToPoints(2),
            padding: pw.EdgeInsets.all(cmToPoints(0.2)),
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
            padding: pw.EdgeInsets.all(cmToPoints(0.2)),
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
      // Третья строка
      pw.Row(
        children: [
          pw.Container(
            width: cmToPoints(2),
            padding: pw.EdgeInsets.all(cmToPoints(0.2)),
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
            width: cmToPoints(4), // Ширина двух столбцов (2 + 2)
            padding: pw.EdgeInsets.all(cmToPoints(0.2)),
            decoration: pw.BoxDecoration(
              border: pw.Border(
                left: pw.BorderSide(width: cmToPoints(0.01)),
                right: pw.BorderSide(width: cmToPoints(0.01)),
                bottom: pw.BorderSide(width: cmToPoints(0.01)),
                top: pw.BorderSide.none, // Убираем верхнюю границу
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
            padding: pw.EdgeInsets.all(cmToPoints(0.2)),
            decoration: pw.BoxDecoration(border: null),
            child: pw.Text(
              '',
              style: pw.TextStyle(font: font, fontSize: fontSize),
            ),
          ),
          pw.Container(
            width: cmToPoints(6), // Ширина двух столбцов (2 + 2)
            padding: pw.EdgeInsets.all(cmToPoints(0.2)),
            decoration: pw.BoxDecoration(
              border: pw.Border.all(width: cmToPoints(0.01)),
            ),
            child: pw.Text(
              '${report.recognizedAmount} сом',
              style: pw.TextStyle(font: font, fontSize: fontSize),
              textAlign: pw.TextAlign.left,
            ),
          ),
          pw.Container(
            width: cmToPoints(2),
            padding: pw.EdgeInsets.all(cmToPoints(0.2)),
            decoration: pw.BoxDecoration(
              border: pw.Border.all(width: cmToPoints(0.01)),
            ),
            child: pw.Text(
              account.name,
              style: pw.TextStyle(font: font, fontSize: fontSize),
              textAlign: pw.TextAlign.center,
            ),
          ),
          pw.Container(
            width: cmToPoints(2),
            padding: pw.EdgeInsets.all(cmToPoints(0.2)),
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
      // Четвертая строка
      pw.Row(
        children: [
          pw.Container(
            width: cmToPoints(6),
            padding: pw.EdgeInsets.all(cmToPoints(0.2)),
            decoration: pw.BoxDecoration(
              border: null,
            ),
            child: pw.Text(
              'Получено (от кого)',
              style: pw.TextStyle(font: font, fontSize: 7.0),
              textAlign: pw.TextAlign.left,
            ),
          ),
          pw.Container(
            width: cmToPoints(2),
            padding: pw.EdgeInsets.all(cmToPoints(0.2)),
            decoration: pw.BoxDecoration(border: null),
            child: pw.Text(
              '',
              style: pw.TextStyle(font: font, fontSize: fontSize),
            ),
          ),
          pw.Container(
            width: cmToPoints(6),
            padding: pw.EdgeInsets.all(cmToPoints(0.2)),
            decoration: pw.BoxDecoration(border: null),
            child: pw.Text(
              '',
              style: pw.TextStyle(font: font, fontSize: fontSize),
            ),
          ),
          pw.Container(
            width: cmToPoints(2),
            padding: pw.EdgeInsets.all(cmToPoints(0.2)),
            decoration: pw.BoxDecoration(
              border: null,
            ),
            child: pw.Text(
              '',
              style: pw.TextStyle(font: font, fontSize: fontSize),
              textAlign: pw.TextAlign.left,
            ),
          ),
          pw.Container(
            width: cmToPoints(2),
            padding: pw.EdgeInsets.all(cmToPoints(0.2)),
            decoration: pw.BoxDecoration(
              border: null,
            ),
            child: pw.Text(
              '',
              style: pw.TextStyle(font: font, fontSize: fontSize),
              textAlign: pw.TextAlign.center,
            ),
          ),
        ],
      ),
      // Пятая строка
      pw.Row(
        children: [
          pw.Container(
            width: cmToPoints(6),
            padding: pw.EdgeInsets.all(cmToPoints(0.2)),
            decoration: pw.BoxDecoration(
              border: pw.Border.all(width: cmToPoints(0.01)),
            ),
            child: pw.Text(
              '1. Из кассы ФРЛ-${department.name}',
              style: pw.TextStyle(font: font, fontSize: 7.0),
              textAlign: pw.TextAlign.left,
            ),
          ),
          pw.Container(
            width: cmToPoints(2),
            padding: pw.EdgeInsets.all(cmToPoints(0.2)),
            decoration: pw.BoxDecoration(
              border: pw.Border.all(width: cmToPoints(0.01)),
            ),
            child: pw.Text(
              report.recognizedAmount,
              style: pw.TextStyle(font: font, fontSize: 7.0),
              textAlign: pw.TextAlign.left,
            ),
          ),
          pw.Container(
            width: cmToPoints(6),
            padding: pw.EdgeInsets.all(cmToPoints(0.2)),
            decoration: pw.BoxDecoration(border: null),
            child: pw.Text(
              'Бухгалтер __________',
              style: pw.TextStyle(font: font, fontSize: fontSize),
            ),
          ),
          pw.Container(
            width: cmToPoints(2),
            padding: pw.EdgeInsets.all(cmToPoints(0.2)),
            decoration: pw.BoxDecoration(
              border: null,
            ),
            child: pw.Text(
              '',
              style: pw.TextStyle(font: font, fontSize: fontSize),
            ),
          ),
          pw.Container(
            width: cmToPoints(2),
            padding: pw.EdgeInsets.all(cmToPoints(0.2)),
            decoration: pw.BoxDecoration(
              border: null,
            ),
            child: pw.Text(
              '',
              style: pw.TextStyle(font: font, fontSize: fontSize),
              textAlign: pw.TextAlign.center,
            ),
          ),
        ],
      ),
    ],
  );
}
