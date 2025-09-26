import 'package:flutter/material.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';
import 'package:intl/intl.dart';

import '../../../models/Report.dart';
import '../../../models/Department.dart';
import '../../../models/Job.dart';
import '../../../models/Employee.dart';
import '../../../models/Account.dart';
import 'build_table_1.dart';
import 'build_table_10.dart';
import 'build_table_11.dart';
import 'build_table_12.dart';
import 'build_table_13.dart';
import 'build_table_14.dart';
import 'build_table_15.dart';
import 'build_table_16.dart';
import 'build_table_17.dart';
import 'build_table_18.dart';
import 'build_table_19.dart';
import 'build_table_2.dart';
import 'build_table_20.dart';
import 'build_table_21.dart';
import 'build_table_22.dart';
import 'build_table_23.dart';
import 'build_table_24.dart';
import 'build_table_25.dart';
import 'build_table_26.dart';
import 'build_table_27.dart';
import 'build_table_3.dart';
import 'build_table_4.dart';
import 'build_table_5.dart';
import 'build_table_6.dart';
import 'build_table_7.dart';
import 'build_table_8.dart';
import 'build_table_9.dart';

Future<void> printReport(
  Report report,
  Department department,
  Job job,
  Employee employee,
  Account account,
) async {
  final pdf = pw.Document();
  final dateFormat = DateFormat('dd.MM.yyyy');

  // Function to convert centimeters to points
  double cmToPoints(double cm) => cm * 28.3465;

  // Load font with Cyrillic support
  final font = await PdfGoogleFonts.robotoRegular();

  // Font size constant
  const double fontSize = 9.0;

  pdf.addPage(
    pw.Page(
      pageFormat: PdfPageFormat.a4,
      build: (pw.Context context) {
        return pw.Column(
          crossAxisAlignment: pw.CrossAxisAlignment.start,
          children: [
            buildTable1(font, fontSize, cmToPoints, department),
            buildTable2(font, fontSize, cmToPoints, job, employee),
            buildTable3(font, fontSize, cmToPoints),
            buildTable4(
              font,
              fontSize,
              cmToPoints,
              report,
              department,
              dateFormat,
            ),
            buildTable5(font, fontSize, cmToPoints, report, dateFormat),
            buildTable6(font, fontSize, cmToPoints),
            buildTable7(font, fontSize, cmToPoints),
            buildTable8(
              font,
              fontSize,
              cmToPoints,
              report,
              department,
              dateFormat,
            ),
            buildTable9(
              font,
              fontSize,
              cmToPoints,
              report,
              account,
              department,
              dateFormat,
            ),
            buildTable10(font, fontSize, cmToPoints),
            buildTable11(font, fontSize, cmToPoints),
            buildTable12(font, fontSize, cmToPoints, report, department),
            buildTable13(font, fontSize, cmToPoints, report, department),
            buildTable14(font, fontSize, cmToPoints, report, department),
            buildTable15(font, fontSize, cmToPoints, report, department),
            buildTable16(font, fontSize, cmToPoints, report, department),
            buildTable17(font, fontSize, cmToPoints, report, department),
            buildTable18(font, fontSize, cmToPoints, report, department),
            buildTable19(font, fontSize, cmToPoints, report, department),
            buildTable20(font, fontSize, cmToPoints, report, department),
            buildTable21(font, fontSize, cmToPoints, report, department),
            buildTable22(font, fontSize, cmToPoints, report, department),
            buildTable23(
              font,
              fontSize,
              cmToPoints,
              report,
              department,
              dateFormat,
            ),
            buildTable24(
              font,
              fontSize,
              cmToPoints,
              report,
              department,
              dateFormat,
            ),
            buildTable25(
              font,
              fontSize,
              cmToPoints,
              report,
              department,
              dateFormat,
            ),
            buildTable26(
              font,
              fontSize,
              cmToPoints,
              report,
              department,
              dateFormat,
            ),
            buildTable27(
              font,
              fontSize,
              cmToPoints,
              report,
              department,
              dateFormat,
            ),
          ],
        );
      },
    ),
  );

  await Printing.layoutPdf(
    onLayout: (PdfPageFormat format) async => pdf.save(),
  );
}
