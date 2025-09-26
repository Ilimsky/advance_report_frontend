import 'package:pdf/widgets.dart' as pw;

import '../../../models/Employee.dart';
import '../../../models/Job.dart';

pw.Widget buildTable2(
    pw.Font font,
    double fontSize,
    double Function(double) cmToPoints,
    Job job,
    Employee employee,
    ) {
  return pw.Table(
    border: null,
    columnWidths: {
      0: pw.FixedColumnWidth(cmToPoints(4)),
      1: pw.FixedColumnWidth(cmToPoints(5)),
      2: pw.FixedColumnWidth(cmToPoints(5)),
      3: pw.FixedColumnWidth(cmToPoints(4)),
    },
    children: [
      pw.TableRow(
        children: [
          pw.Padding(
            padding: pw.EdgeInsets.all(cmToPoints(0.2)),
            child: pw.Container(
              alignment: pw.Alignment.centerRight,
              child: pw.Text(
                'Должность',
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
                job.name ?? '',
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
                'Ф.И.О.',
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
                employee.name ?? '',
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