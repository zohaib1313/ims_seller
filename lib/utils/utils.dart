import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';

void printWrapped(String text) {
  final pattern = RegExp('.{1,800}'); // 800 is the size of each chunk
  pattern.allMatches(text).forEach((match) => print(match.group(0)));
}

void printNow({required child}) async {
  final doc = pw.Document();

  doc.addPage(pw.Page(
      pageFormat: PdfPageFormat.roll57,
      build: (pw.Context context) {
        return pw.Center(child: child); // Center
      })); // Page // Page

  await Printing.layoutPdf(
    format: PdfPageFormat.roll57,
    onLayout: (PdfPageFormat format) async => doc.save(),
  );
}
