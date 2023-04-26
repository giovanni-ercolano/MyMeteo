import 'package:flutter/material.dart';
import 'package:MyMeteo/pages/homepage.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';

void main() {
  runApp(const MainApp());
  FlutterNativeSplash(
    backgroundColor: Colors.white,
    image: Image.asset('assets/custom_splash.png'),
    imageBackgroundSize: BoxFit.contain,
    style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
    loadingText: Text("Loading..."),
    duration: 3000,
    useLoader: true,
    loaderColor: Colors.red,
  );
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor: Colors.deepPurpleAccent,
        resizeToAvoidBottomInset: false,
        body: HomePage(),
      ),
    );
  }
}