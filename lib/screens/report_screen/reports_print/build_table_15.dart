import 'package:advance_report_frontend/models/Department.dart';
import 'package:pdf/widgets.dart' as pw;

import '../../../models/Report.dart';

pw.Widget buildTable15(
  pw.Font font,
  double fontSize,
  double Function(double) cmToPoints,
  Report report,
  Department department,
) {
  return pw.Table(
    border: pw.TableBorder.all(width: cmToPoints(0.01)),
    columnWidths: {
      0: pw.FixedColumnWidth(cmToPoints(6)),
      1: pw.FixedColumnWidth(cmToPoints(2)),
      2: pw.FixedColumnWidth(cmToPoints(6)),
      3: pw.FixedColumnWidth(cmToPoints(4)),
    },
    children: [
      pw.TableRow(
        children: [
          pw.Padding(
            padding: pw.EdgeInsets.all(cmToPoints(0.2)),
            child: pw.Text(
              'Итого получено',
              style: pw.TextStyle(font: font, fontSize: fontSize),
            ),
          ),
          pw.Padding(
            padding: pw.EdgeInsets.all(cmToPoints(0.2)),
            child: pw.Text(
              report.recognizedAmount,
              style: pw.TextStyle(font: font, fontSize: fontSize),
            ),
          ),
          pw.Padding(
            padding: pw.EdgeInsets.all(cmToPoints(0.2)),
            child: pw.Text(
              'Отчет утверждаю в сумме:',
              style: pw.TextStyle(font: font, fontSize: fontSize),
            ),
          ),
          pw.Padding(
            padding: pw.EdgeInsets.all(cmToPoints(0.2)),
            child: pw.Text(
              'Кредит',
              style: pw.TextStyle(font: font, fontSize: fontSize),
            ),
          ),
        ],
      ),
    ],
  );
}
