import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:qr_app/models/scan_model.dart';
import 'package:qr_app/providers/scan_provider.dart';

class Scanners extends StatelessWidget {
  const Scanners({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    print("Dibujando Scanners");
    final _scanProvider = Provider.of<ScanProvider>(context);
    return ListView.builder(
      itemCount: _scanProvider.scanners.length,
      itemBuilder: (context, index) => Dismissible(
        key: UniqueKey(),
        direction: DismissDirection.endToStart,
        background: Container(
          color: Colors.red,
          alignment: Alignment.centerRight,
          padding: EdgeInsets.only(right: 20.0),
          child: Icon(
            Icons.delete_outline,
            color: Colors.white,
          ),
        ),
        child: ItemScan(scan: _scanProvider.scanners[index]),
        onDismissed: (direction) {
          _scanProvider.deleteScan(_scanProvider.scanners[index].id ?? 0);
        },
      ),
    );
  }
}

class ItemScan extends StatelessWidget {
  ItemScan({
    required this.scan,
  });
  final ScanModel scan;
  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text("${scan.value}"),
      subtitle: Text("Código: ${scan.id}"),
    );
  }
}
