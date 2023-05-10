import 'package:flutter/material.dart';

import 'Homepage.dart';
//import 'package:firebase_core/firebase_core.dart';
 void main()  {
  /*WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: FirebaseOptions(
        apiKey: "AIzaSyDeelhbrmZB2u1xK2h-cEKSI2fUWwmXsbw",
        authDomain: "snaky-32c1c.firebaseapp.com",
        projectId: "snaky-32c1c",
        storageBucket: "snaky-32c1c.appspot.com",
        messagingSenderId: "56170547285",
        appId: "1:56170547285:web:d1f58813e8fa317dcf2cdc",
        measurementId: "G-3VWVL2JH37"),
  );*/
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(brightness: Brightness.dark),
      home: HomePage(),
    );
  }
}
