import 'package:pdf/widgets.dart' as pw;
import 'package:intl/intl.dart';

import '../../../models/Report.dart';

pw.Widget buildTable5(
    pw.Font font,
    double fontSize,
    double Function(double) cmToPoints,
    Report report,
    DateFormat dateFormat,
    ) {
  return pw.Table(
    border: pw.TableBorder.all(width: cmToPoints(0.01)),
    columnWidths: {
      0: pw.FixedColumnWidth(cmToPoints(4)),
      1: pw.FixedColumnWidth(cmToPoints(10)),
      2: pw.FixedColumnWidth(cmToPoints(1)),
      3: pw.FixedColumnWidth(cmToPoints(3)),
    },
    children: [
      pw.TableRow(
        children: [
          pw.Padding(
            padding: pw.EdgeInsets.all(cmToPoints(0.2)),
            child: pw.Container(
              alignment: pw.Alignment.centerRight,
              child: pw.Text(
                'НАЗНАЧЕНИЕ АВАНСА',
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
                '${report.purpose}',
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
        ],
      ),
    ],
  );
}