import 'package:flutter/material.dart';
import 'package:pr_4_2/screens/candition.dart';
import 'package:pr_4_2/screens/home.dart';
import 'package:pr_4_2/screens/info.dart';

void main() {
  runApp(
    MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: 'homepage',
      routes: {
        'homepage': (context) => const HomePage(),
        'cases': (context) => const CasesInfoPage(),
        'recent': (context) => const RecentCases(),
      },
    ),
  );
}