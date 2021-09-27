import 'package:flutter/material.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:provider/provider.dart';
import 'package:qr_app/models/scan_model.dart';
import 'package:qr_app/providers/scan_provider.dart';

class ButtonScan extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    print("Dibujando ButtonScan");
    return FloatingActionButton(
      onPressed: () async {
        String barcodeScanRes = "Hola";
        /*  String barcodeScanRes = await FlutterBarcodeScanner.scanBarcode(
          '#ff6666',
          'Cancel',
          true,
          ScanMode.QR,
        ); */
        //print("VALUE QR" + barcodeScanRes);

        final _scanProvider = Provider.of<ScanProvider>(context, listen: false);
        ScanModel oScan = ScanModel(value: barcodeScanRes);
        _scanProvider.insertScan(oScan);
      },
      child: Icon(Icons.qr_code_rounded),
    );
  }
}
