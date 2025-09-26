import 'package:advance_report_frontend/models/Account.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:intl/intl.dart';

import '../../../models/Department.dart';
import '../../../models/Report.dart';

pw.Widget buildTable9(
    pw.Font font,
    double fontSize,
    double Function(double) cmToPoints,
    Report report,
    Account account,
    Department department,
    DateFormat dateFormat,
    ) {
  return pw.Table(
    border: pw.TableBorder.all(width: cmToPoints(0.01)),
    columnWidths: {
      0: pw.FixedColumnWidth(cmToPoints(2)),
      1: pw.FixedColumnWidth(cmToPoints(4)),
      2: pw.FixedColumnWidth(cmToPoints(2)),
      3: pw.FixedColumnWidth(cmToPoints(6)),
      4: pw.FixedColumnWidth(cmToPoints(2)),
      5: pw.FixedColumnWidth(cmToPoints(2)),
    },
    children: [
      pw.TableRow(
        children: [
          pw.Padding(
            padding: pw.EdgeInsets.all(cmToPoints(0.2)),
            child: pw.Container(
              alignment: pw.Alignment.centerRight,
              child: pw.Text(
                'Перерасход',
                style: pw.TextStyle(font: font, fontSize: fontSize),
                softWrap: false,
              ),
            ),
          ),
          pw.Padding(
            padding: pw.EdgeInsets.all(cmToPoints(0.2)),
            child: pw.Container(
              alignment: pw.Alignment.centerLeft,
              child: pw.Text(
                'аванса',
                style: pw.TextStyle(font: font, fontSize: fontSize),
                softWrap: false,
              ),
            ),
          ),
          pw.Padding(
            padding: pw.EdgeInsets.all(cmToPoints(0.2)),
            child: pw.Container(
              alignment: pw.Alignment.centerRight,
              child: pw.Text(
                '',
                style: pw.TextStyle(font: font, fontSize: fontSize),
                softWrap: false,
              ),
            ),
          ),
          pw.Padding(
            padding: pw.EdgeInsets.all(cmToPoints(0.2)),
            child: pw.Container(
              alignment: pw.Alignment.centerLeft,
              child: pw.Text(
                '${report.recognizedAmount} сом',
                style: pw.TextStyle(font: font, fontSize: fontSize),
                softWrap: false,
              ),
            ),
          ),
          pw.Padding(
            padding: pw.EdgeInsets.all(cmToPoints(0.2)),
            child: pw.Text(
              account.name,
              style: pw.TextStyle(font: font, fontSize: fontSize),
            ),
          ),
          pw.Padding(
            padding: pw.EdgeInsets.all(cmToPoints(0.2)),
            child: pw.Container(
              alignment: pw.Alignment.centerRight,
              child: pw.Text(
                report.recognizedAmount,
                style: pw.TextStyle(font: font, fontSize: fontSize),
                softWrap: false,
              ),
            ),
          ),
        ],
      ),
    ],
  );
}