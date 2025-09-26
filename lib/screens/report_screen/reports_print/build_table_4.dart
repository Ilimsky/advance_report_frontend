import 'package:pdf/widgets.dart' as pw;
import 'package:intl/intl.dart';

import '../../../models/Department.dart';
import '../../../models/Report.dart';

pw.Widget buildTable4(
    pw.Font font,
    double fontSize,
    double Function(double) cmToPoints,
    Report report,
    Department department,
    DateFormat dateFormat,
    ) {
  return pw.Table(
    border: null,
    columnWidths: {
      0: pw.FixedColumnWidth(cmToPoints(4)),
      1: pw.FixedColumnWidth(cmToPoints(3)),
      2: pw.FixedColumnWidth(cmToPoints(1)),
      3: pw.FixedColumnWidth(cmToPoints(2)),
      4: pw.FixedColumnWidth(cmToPoints(4)),
      5: pw.FixedColumnWidth(cmToPoints(4)),
    },
    children: [
      pw.TableRow(
        children: [
          pw.Padding(
            padding: pw.EdgeInsets.all(cmToPoints(0.2)),
            child: pw.Container(
              alignment: pw.Alignment.centerRight,
              child: pw.Text(
                'АВАНСОВЫЙ ОТЧЕТ №',
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
                '${report.reportNumber}/${department.name}',
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
                'от',
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
                dateFormat.format(report.dateReceived),
                style: pw.TextStyle(font: font, fontSize: fontSize),
                softWrap: false,
              ),
            ),
          ),
          pw.Padding(
            padding: pw.EdgeInsets.all(cmToPoints(0.2)),
            child: pw.Text(
              '',
              style: pw.TextStyle(font: font, fontSize: fontSize),
            ),
          ),
          pw.Padding(
            padding: pw.EdgeInsets.all(cmToPoints(0.2)),
            child: pw.Container(
              alignment: pw.Alignment.centerLeft,
              child: pw.Text(
                'Проводка №',
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