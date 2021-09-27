import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class ScreemPage extends StatefulWidget {
  ScreemPage({Key? key}) : super(key: key);

  @override
  _ScreemPageState createState() => _ScreemPageState();
}

class _ScreemPageState extends State<ScreemPage> {
  takescrshot() async {
    var scr = new GlobalKey();
    RepaintBoundary(
      key: scr,
      child: new FlutterLogo(
        size: 50.0,
      ),
    );

    RenderRepaintBoundary boundary =
        scr.currentContext!.findRenderObject() as RenderRepaintBoundary;

    var image = await boundary.toImage();
    var byteData = await image.toByteData(format: ImageByteFormat.png);
    var pngBytes = byteData!.buffer.asUint8List();
    print(pngBytes);
  }

  @override
  void initState() {
    super.initState();
    //takescrshot();
  }

  takeScreenShot() async {
    /*  takescrshot() async {
      RenderRepaintBoundary boundary = scr.currentContext.findRenderObject();
      var image = await boundary.toImage();
      var byteData = await image.toByteData(format: ImageByteFormat.png);
      var pngBytes = byteData.buffer.asUint8List();
      print(pngBytes);
    } */

    /* RenderRepaintBoundary boundary = ScreemPage..findRenderObject();
    ui.Image image = await boundary.toImage();
    final directory = (await getApplicationDocumentsDirectory()).path;
    ByteData byteData = await image.toByteData(format: ui.ImageByteFormat.png);
    Uint8List pngBytes = byteData.buffer.asUint8List();
    print(pngBytes);
    File imgFile = new File('$directory/screenshot.png');
    imgFile.writeAsBytes(pngBytes); */
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          takescrshot();
        },
      ),
    );
  }
}
