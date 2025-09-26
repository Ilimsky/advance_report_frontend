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
import 'build_table_2.dart';
import 'build_table_4.dart';
import 'build_table_5.dart';
import 'build_table_7.dart';

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
  const double fontSize = 8.0;

  pdf.addPage(
    pw.Page(
      pageFormat: PdfPageFormat.a4,
      build: (pw.Context context) {
        return pw.Column(
          crossAxisAlignment: pw.CrossAxisAlignment.start,
          children: [
            buildTable7(font, fontSize, cmToPoints, report, account, department, dateFormat, job, employee),

          ],
        );
      },
    ),
  );

  await Printing.layoutPdf(
    onLayout: (PdfPageFormat format) async => pdf.save(),
  );
}
