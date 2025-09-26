import 'package:pdf/widgets.dart' as pw;

pw.Widget buildTable11(
  pw.Font font,
  double fontSize,
  double Function(double) cmToPoints,
) {
  return pw.Table(
    border: null,
    columnWidths: {
      0: pw.FixedColumnWidth(cmToPoints(6)),
      1: pw.FixedColumnWidth(cmToPoints(2)),
      2: pw.FixedColumnWidth(cmToPoints(6)),
      3: pw.FixedColumnWidth(cmToPoints(2)),
      4: pw.FixedColumnWidth(cmToPoints(2)),
    },
    children: [
      pw.TableRow(
        children: [
          pw.Padding(
            padding: pw.EdgeInsets.all(cmToPoints(0.2)),
            child: pw.Text(
              'Получено (от кого):',
              style: pw.TextStyle(font: font, fontSize: fontSize),
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
            child: pw.Text(
              '',
              style: pw.TextStyle(font: font, fontSize: fontSize),
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
            child: pw.Text(
              '',
              style: pw.TextStyle(font: font, fontSize: fontSize),
            ),
          ),
        ],
      ),
    ],
  );
}
