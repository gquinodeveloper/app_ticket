import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:provider/provider.dart';
import 'package:qr_app/models/scan_model.dart';
import 'package:qr_app/pages/widgets/button_scan.dart';
import 'package:qr_app/pages/widgets/scanners.dart';
import 'package:qr_app/providers/db_provider.dart';
import 'package:qr_app/providers/scan_provider.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    print("Dibujando HomePage");
    return Scaffold(
      appBar: AppBar(
        title: Text("QR Scanner"),
      ),
      body: HomeBody(),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: ButtonScan(),
    );
  }
}

class HomeBody extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    print("Dibujando HomeBody");
    final _scanProvider = Provider.of<ScanProvider>(context, listen: false);
    _scanProvider.getAllScan();
    return Scanners();
  }
}
