import 'package:advance_report_frontend/models/Department.dart';
import 'package:pdf/widgets.dart' as pw;

import '../../../models/Report.dart';

pw.Widget buildTable22(
  pw.Font font,
  double fontSize,
  double Function(double) cmToPoints,
  Report report,
  Department department,
) {
  return pw.Table(
    border: pw.TableBorder.all(width: cmToPoints(0.01)),
    columnWidths: {
      0: pw.FixedColumnWidth(cmToPoints(2)),
      1: pw.FixedColumnWidth(cmToPoints(2)),
      2: pw.FixedColumnWidth(cmToPoints(12)),
      3: pw.FixedColumnWidth(cmToPoints(2)),
    },
    children: [
      pw.TableRow(
        children: [
          pw.Padding(
            padding: pw.EdgeInsets.all(cmToPoints(0.2)),
            child: pw.Text(
              'Дата',
              style: pw.TextStyle(font: font, fontSize: fontSize),
            ),
          ),
          pw.Padding(
            padding: pw.EdgeInsets.all(cmToPoints(0.2)),
            child: pw.Text(
              'Пор. № док-та',
              style: pw.TextStyle(font: font, fontSize: fontSize),
            ),
          ),
          pw.Padding(
            padding: pw.EdgeInsets.all(cmToPoints(0.2)),
            child: pw.Text(
              'Кому, за что и по какому документу уплачено',
              style: pw.TextStyle(font: font, fontSize: fontSize),
            ),
          ),
          pw.Padding(
            padding: pw.EdgeInsets.all(cmToPoints(0.2)),
            child: pw.Text(
              'Сумма',
              style: pw.TextStyle(font: font, fontSize: fontSize),
            ),
          ),
        ],
      ),
    ],
  );
}
