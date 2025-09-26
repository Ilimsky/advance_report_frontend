import 'package:pdf/widgets.dart' as pw;

import '../../../models/Department.dart';

pw.Widget buildTable1(
    pw.Font font,
    double fontSize,
    double Function(double) cmToPoints,
    Department department,
    ) {
  return pw.Table(
    border: null,
    columnWidths: {
      0: pw.FixedColumnWidth(cmToPoints(4)),
      1: pw.FixedColumnWidth(cmToPoints(4)),
      2: pw.FixedColumnWidth(cmToPoints(6)),
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
                'Организация:',
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
                'ОсДО РосЛомбард',
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
                'Филиал:',
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
                'Ломбард №${department.name ?? ''}',
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