import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:qr_app/pages/home_page.dart';
import 'package:qr_app/pages/screem_page.dart';
import 'package:qr_app/pages/screemshot_page.dart';
import 'package:qr_app/providers/scan_provider.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => ScanProvider()),

        /*  
        Provider<ScanProvider>(create: (_) => ScanProvider()),
        Provider<Something>(create: (_) => Something()),
        Provider<SomethingElse>(create: (_) => SomethingElse()),
        Provider<AnotherThing>(create: (_) => AnotherThing()), */
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch: Colors.deepOrange,
        ),
        //home: HomePage(),
        //home: ScreemPage(),
        home: ScreemShotPage(),
      ),
    );
  }
}
