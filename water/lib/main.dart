import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:water/decision_tree.dart';
import 'package:water/kayit_ol.dart';
import 'package:water/uye_giris.dart';

  Future<void> main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(  MaterialApp(home: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({Key key}) : super(key: key);
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: DecisionTree()
    );
  }
}
