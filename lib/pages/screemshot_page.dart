import 'dart:io';

import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:screenshot/screenshot.dart';
import 'dart:typed_data';
import 'package:share/share.dart';

import 'widgets/ticketview.dart';

class ScreemShotPage extends StatefulWidget {
  const ScreemShotPage({Key? key}) : super(key: key);

  @override
  _ScreemShotPageState createState() => _ScreemShotPageState();
}

class _ScreemShotPageState extends State<ScreemShotPage> {
  ScreenshotController screenshotController = ScreenshotController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.kBodyColor,
      appBar: AppBar(
        actions: [
          ElevatedButton(
            child: Icon(Icons.share_rounded),
            onPressed: () {
              screenshotController
                  .captureFromWidget(
                      InheritedTheme.captureAll(
                        context,
                        Material(
                          child: _getTicketReceiptView(), //voucher()
                        ),
                      ),
                      delay: Duration(milliseconds: 100))
                  .then((image) async {
                if (image.isNotEmpty) {
                  final directory = await getApplicationDocumentsDirectory();
                  final imagePath =
                      await File('${directory.path}/image.png').create();
                  await imagePath.writeAsBytes(image);

                  print("INICIA SHARE");
                  // Share Plugin
                  await Share.shareFiles([imagePath.path]);
                  print("FIN SHARE");

                  //imagePath.delete();
                }
                //showCapturedWidget(context, capturedImage);
              });
            },
          ),
        ],
      ),
      body: SafeArea(
        child: _getTicketReceiptView(),
      ),
      /* body: Column(
        //mainAxisAlignment: MainAxisAlignment.center,
        children: [
          //_getTicketReceiptView(),
          /* TicketCard(
            decoration: TicketDecoration(
                shadow: [TicketShadow(color: Colors.black, elevation: 6)],
                border: TicketBorder(
                    color: Colors.green,
                    width: 0.1,
                    style: TicketBorderStyle.dotted)),
            lineFromTop: 100,
            child: Container(
              height: 200,
              width: 200,
              color: Colors.white,
              child: Text(
                "sdfsf",
                style: TextStyle(color: Colors.black),
              ),
            ),
          ), */
          /* Builder(
            builder: (BuildContext context) {
              return ElevatedButton(
                child: const Text('Share'),
                onPressed: () {
                  _onShare(context);
                },
              );
            },
          ), */
          Screenshot(
            controller: screenshotController,
            child: voucher(),
            /* child: Container(
              padding: const EdgeInsets.all(30.0),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.blueAccent, width: 5.0),
                color: Colors.amberAccent,
              ),
              child: Text("This widget will be captured as an image"),
            ), */
          ),
          SizedBox(
            height: 25,
          ),
          ElevatedButton(
            child: Text(
              'Capture Above Widget',
            ),
            onPressed: () {
              screenshotController
                  .capture(delay: Duration(milliseconds: 10))
                  .then((capturedImage) async {
                showCapturedWidget(context, capturedImage!);
              }).catchError((onError) {
                print(onError);
              });
            },
          ),
          ElevatedButton(
            child: Text(
              'Capture An Invisible Widget',
            ),
            onPressed: () {
              /* var container = Container(
                padding: const EdgeInsets.all(30.0),
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.blueAccent, width: 5.0),
                  color: Colors.redAccent,
                ),
                child: Text(
                  "This is an invisible widget",
                  style: Theme.of(context).textTheme.headline6,
                ),
              ); */
              screenshotController
                  .captureFromWidget(
                      InheritedTheme.captureAll(
                        context,
                        Material(
                          child: voucher(),
                        ),
                      ),
                      delay: Duration(seconds: 1))
                  .then((image) async {
                if (image.isNotEmpty) {
                  final directory = await getApplicationDocumentsDirectory();
                  final imagePath =
                      await File('${directory.path}/image.png').create();
                  await imagePath.writeAsBytes(image);

                  print("INICIA SHARE");
                  // Share Plugin
                  await Share.shareFiles([imagePath.path]);
                  print("FIN SHARE");

                  //imagePath.delete();
                }
                //showCapturedWidget(context, capturedImage);
              });
            },
          ),
        ],
      ), */
    );
  }

  _onShare(BuildContext context) async {
    final RenderBox box = context.findRenderObject() as RenderBox;

    await Share.shareFiles([
      "asset/fc-logo.png",
    ],
        //text: text,
        //subject: subject,
        sharePositionOrigin: box.localToGlobal(Offset.zero) & box.size);
  }

  Future<dynamic> showCapturedWidget(
      BuildContext context, Uint8List capturedImage) {
    return showDialog(
      useSafeArea: false,
      context: context,
      builder: (context) => Scaffold(
        appBar: AppBar(
          title: Text("View screenshot"),
        ),
        body: Center(
          child: capturedImage.isNotEmpty
              ? Image.memory(capturedImage)
              : Container(),
        ),
      ),
    );
  }

  Widget voucher() {
    return Container(
      width: 350.0,
      height: 400.0,
      color: Colors.white,
      padding: EdgeInsets.all(10.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Image.asset(
                "assets/fc-logo.png",
                width: 120.0,
              ),
              Spacer(),
              Text(
                "26 de Setiembre 2021",
                textAlign: TextAlign.center,
                style: Theme.of(context)
                    .textTheme
                    .bodyText2
                    ?.copyWith(color: Colors.blue[900]),
              ),
            ],
          ),
          SizedBox(height: 100.0),
          Center(
            child: Text(
              "S/600.00",
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.headline3?.copyWith(
                    color: Colors.blue[900],
                    fontWeight: FontWeight.w700,
                  ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _getTicketReceiptView() {
    return TicketView(
      backgroundPadding: EdgeInsets.symmetric(vertical: 0.0, horizontal: 15),
      backgroundColor: Color.fromRGBO(229, 240, 246, 1.0),
      contentPadding: EdgeInsets.only(
        top: 10,
        left: 15.0,
        right: 15.0,
        bottom: 25.0,
      ),
      drawArc: false,
      triangleAxis: Axis.vertical,
      borderRadius: 6,
      drawDivider: true,
      trianglePos: .5,
      child: Container(
        width: double.infinity,
        height: 550.0,
        padding: EdgeInsets.all(10.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Center(
              child: Image.asset(
                'assets/fc-logo.png',
                width: 150.0,
              ),
            ),
            Expanded(
              flex: 2,
              child: Container(
                alignment: Alignment.center,
                margin: EdgeInsets.symmetric(vertical: 20),
                child: Column(
                  children: [
                    Text(
                      "CORRESPONSAL",
                      textAlign: TextAlign.center,
                      style: Theme.of(context)
                          .textTheme
                          .bodyText2
                          ?.copyWith(color: AppTheme.kDarkBlue),
                    ),
                    Text(
                      "000000061",
                      textAlign: TextAlign.center,
                      style: Theme.of(context)
                          .textTheme
                          .caption
                          ?.copyWith(color: AppTheme.kDarkBlue),
                    ),
                    Text(
                      "BOTICA NANCYS",
                      textAlign: TextAlign.center,
                      style: Theme.of(context).textTheme.subtitle1?.copyWith(
                            color: AppTheme.kDarkBlue,
                            fontWeight: FontWeight.bold,
                          ),
                    ),
                  ],
                ),
              ),
            ),
            /*  Text(
              "----------------------------------------------------------",
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.caption?.copyWith(
                    color: AppTheme.kligth,
                    fontWeight: FontWeight.bold,
                  ),
            ), */
            Expanded(
              flex: 1,
              child: Text(
                "------------------------------------------------------",
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.caption?.copyWith(
                      color: AppTheme.kligth,
                      fontWeight: FontWeight.bold,
                    ),
              ),
            ),
            Expanded(
              flex: 3,
              child: Container(
                alignment: Alignment.center,
                margin: EdgeInsets.symmetric(vertical: 10.0),
                child: Column(
                  children: [
                    Text(
                      "GEKUK QOPPUMAIQU UMU",
                      textAlign: TextAlign.center,
                      style: Theme.of(context).textTheme.subtitle1?.copyWith(
                            color: AppTheme.kPrimaryColor,
                            fontWeight: FontWeight.bold,
                          ),
                    ),
                    SizedBox(height: 5.0),
                    Text(
                      "Retiró",
                      textAlign: TextAlign.center,
                      style: Theme.of(context)
                          .textTheme
                          .bodyText1
                          ?.copyWith(color: AppTheme.kDarkBlue),
                    ),
                    SizedBox(height: 25.0),
                    Text(
                      "S/100.00",
                      textAlign: TextAlign.center,
                      style: Theme.of(context).textTheme.headline4?.copyWith(
                            color: AppTheme.kPrimaryColor,
                            fontWeight: FontWeight.bold,
                          ),
                    ),
                  ],
                ),
              ),
            ),
            /* Expanded(
              flex: 1,
              child: Container(
                margin: EdgeInsets.symmetric(vertical: 0),
                child: Column(
                  children: [
                    Divider(),
                    ListTile(
                      title: Text(
                        "Cuenta Ahorro",
                        style: Theme.of(context)
                            .textTheme
                            .bodyText1
                            ?.copyWith(color: AppTheme.kDarkBlue),
                      ),
                      subtitle: Text(
                        "Cuenta Origen",
                        style: Theme.of(context)
                            .textTheme
                            .caption
                            ?.copyWith(color: AppTheme.kDarkBlue),
                      ),
                      trailing: Text(
                        "************565444",
                        style: Theme.of(context)
                            .textTheme
                            .bodyText1
                            ?.copyWith(color: AppTheme.kPrimaryColor),
                      ),
                    ),
                    Divider(),
                    ListTile(
                      title: Text(
                        "Número de operación",
                        style: Theme.of(context)
                            .textTheme
                            .caption
                            ?.copyWith(color: AppTheme.kDarkBlue),
                      ),
                      trailing: Text(
                        "123-2332-1122-1223",
                        style: Theme.of(context)
                            .textTheme
                            .bodyText1
                            ?.copyWith(color: AppTheme.kPrimaryColor),
                      ),
                    ),
                  ],
                ),
              ),
            ), */
            Expanded(
              flex: 4,
              child: Container(
                margin: EdgeInsets.symmetric(vertical: 10, horizontal: 25.0),
                child: Column(
                  children: [
                    Text(
                      "Verifique que los datos impresos en este recibo sean correctos. Cualquier consulta puede acercarse a la agencia más cercana de \nFinanciera Confianza.",
                      textAlign: TextAlign.center,
                      style: Theme.of(context)
                          .textTheme
                          .caption
                          ?.copyWith(color: AppTheme.kDarkBlue),
                    ),
                    SizedBox(height: 30.0),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "27/09/2021",
                          textAlign: TextAlign.center,
                          style: Theme.of(context)
                              .textTheme
                              .bodyText1
                              ?.copyWith(color: AppTheme.kDarkBlue),
                        ),
                        Text(
                          "10:22:37",
                          textAlign: TextAlign.center,
                          style: Theme.of(context)
                              .textTheme
                              .bodyText1
                              ?.copyWith(color: AppTheme.kDarkBlue),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class AppTheme {
  static final Color kBackground =
      Color.fromRGBO(246, 247, 253, 1.0); //Color.fromRGBO(240, 241, 248, 1.0);
  static final Color kPrimaryColor =
      Color.fromRGBO(0, 86, 153, 1.0); //Color.fromRGBO(0, 68, 129, 1.0);
  static final Color kSecondColor = Color.fromRGBO(240, 241, 248, 1.0);
  static final Color kBodyColor = Color.fromRGBO(229, 240, 246, 1.0);
  static final Color kInactiveColor = Color.fromRGBO(134, 166, 195, 1.0);
  //static final Color kInactiveColor = Color.fromRGBO(139, 151, 203, 1.0);
  static final Color kligth = Color.fromRGBO(240, 241, 248, 1.0);
  static final Color kDarkBlue = Color.fromRGBO(146, 157, 190, 1.0);
}
