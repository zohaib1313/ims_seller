import 'package:ims_seller/models/mode_printer_product.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:pdf/widgets.dart';
import 'package:printing/printing.dart';

class CustomPrinter {
  print(List<ModelPrinterProduct> _product) {
    Printing.layoutPdf(
      onLayout: (format) {
        final doc = pw.Document();
        doc.addPage(
          pw.MultiPage(
              crossAxisAlignment: pw.CrossAxisAlignment.start,
              build: (pw.Context context) => <pw.Widget>[
                    _topHeaderLayout(),
                    for (int i = 0; i < _product.length; i++)
                      _productLayout(_product[i]),
                  ]),
        );
        return doc.save();
      },
      name: 'order_id_#' + "123",
    );
  }

  _topHeaderLayout() {
    return new pw.Container(
        // height: 60.0,
        margin: pw.EdgeInsets.only(bottom: 20.0),
        child: pw.Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            pw.Expanded(
              child: pw.Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <pw.Widget>[
                  pw.Container(
                    child: pw.Text(
                      'ITEM',
                      style: pw.TextStyle(
                          fontWeight: pw.FontWeight.bold, fontSize: 60),
                    ),
                  ),
                ],
              ),
            ),
            pw.Expanded(
              child: pw.Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: <pw.Widget>[
                  pw.Text(
                    'PRICE',
                    style: pw.TextStyle(
                        fontWeight: pw.FontWeight.bold, fontSize: 60),
                  ),
                ],
              ),
            )
          ],
        ));
  }

  _productLayout(ModelPrinterProduct item) {
    return new pw.Container(
        // height: 60.0,
        margin: pw.EdgeInsets.only(bottom: 20.0),
        child: pw.Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            pw.Expanded(
              child: pw.Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <pw.Widget>[
                  pw.Container(
                    child: pw.Text(
                      item.itemAmount.toString() +
                          ' - ID: ' +
                          item.itemAmount.toString(),
                      style: pw.TextStyle(
                          fontWeight: pw.FontWeight.bold, fontSize: 60),
                    ),
                  ),
                  pw.Container(
                    child: Text(
                        'Qty: ' +
                            item.itemQty.toString() +
                            ' x Cost: ' +
                            '£' +
                            item.itemAmount.toString(),
                        style: pw.TextStyle(
                            fontWeight: pw.FontWeight.normal, fontSize: 60)),
                  ),
                ],
              ),
            ),
            pw.Expanded(
              child: pw.Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: <pw.Widget>[
                  pw.Text(
                    '£' + item.itemAmount.toString(),
                    style: pw.TextStyle(
                        fontWeight: pw.FontWeight.normal, fontSize: 60),
                  ),
                ],
              ),
            )
          ],
        ));
  }
}
