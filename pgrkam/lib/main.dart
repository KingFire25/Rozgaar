// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:pgrkam/job_page.dart';
import 'package:pgrkam/resume_upload.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      routes: {
          // '/': (context) => MyHomePage(),
          '/resume_upload': (context) => PdfUploadWidget(),
        },
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(useMaterial3: true, fontFamily: 'Helvetica'),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});
  @override
  State<MyHomePage> createState() => HomePage();
}

class HomePage extends State<MyHomePage> {
  
  @override
  Widget build(BuildContext context) {
    return JobPage();
  }
}
