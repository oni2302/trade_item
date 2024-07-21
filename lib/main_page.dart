import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

class MainPage extends StatelessWidget {
  final Widget screen;
  const MainPage({super.key, required this.screen});

  @override
  Widget build(BuildContext context) {

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: screen,
      )
    );
  }
}
