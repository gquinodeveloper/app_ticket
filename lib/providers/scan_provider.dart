import 'package:flutter/material.dart';
import 'package:qr_app/models/scan_model.dart';
import 'package:qr_app/providers/db_provider.dart';

class ScanProvider with ChangeNotifier {
  List<ScanModel> scanners = [];

  getAllScan() async {
    final reponse = await DBProvider.db.getAllScan();
    this.scanners = reponse;
    notifyListeners();
  }

  //ScanModel
  insertScan(ScanModel oScan) async {
    final response = await DBProvider.db.insertScan(oScan);
    oScan.id = response;
    this.scanners.add(oScan);
    notifyListeners();
  }

  deleteScan(int id) async {
    await DBProvider.db.deleteScan(id);
    getAllScan();
  }
}
