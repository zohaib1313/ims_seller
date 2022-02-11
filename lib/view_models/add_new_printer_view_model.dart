import 'package:flutter/material.dart';
import 'package:ims_seller/utils/utils.dart';
import 'package:printing/printing.dart';

class AddNewPrinterViewModel extends ChangeNotifier {
//  StreamController< >

  Future<List<Printer>> list() {
    return Printing.listPrinters();
  }

  info() async {
    var res = await Printing.info();

    printWrapped(res.toString());
  }

  /* Future<void> printTicket() async {
    final printer = PrinterBluetoothManager('192.168.0.123');
    final res = await printer.connect();

    if (res != PosPrintResult.success) {
      throw Exception('Unable to connect to the printer');
    }

    final profile = await CapabilityProfile.load();
    final generator = Generator(PaperSize.mm80, profile);
    var ticket = <int>[];

    await for (var page in Printing.raster(await _generateTicket())) {
      final image = page.asImage();
      ticket += generator.image(image);
      ticket += generator.feed(2);
      ticket += generator.cut();
    }

    printer.printTicket(ticket);
    printer.disconnect();
  }

  Future<Uint8List> _generateTicket() async {
    final pdf = Document();

    pdf.addPage(
      pw.Page(
        pageFormat: PdfPageFormat.roll80,
        build: (Context context) => pw.SizedBox(
          height: 300 * PdfPageFormat.mm,
          child: pw.Center(
            child: pw.Text('Hello World'),
          ),
        ),
      ),
    );

    return pdf.save();
  }*/
}
