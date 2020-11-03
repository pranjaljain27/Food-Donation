import 'package:flutter/material.dart';
import './screens/opening_screen.dart';
import './services/service_locator.dart';



void main() {
  setupLocator();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.purple,
        fontFamily: 'Lato'
      ),
      home: 
      OpeningScreen(),
      
    );
  }
}

