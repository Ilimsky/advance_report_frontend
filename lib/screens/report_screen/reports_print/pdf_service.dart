import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';

class PdfService {
  static pw.Font? _cachedFont;

  static Future<pw.Font> get font async {
    _cachedFont ??= await PdfGoogleFonts.robotoRegular();
    return _cachedFont!;
  }
}