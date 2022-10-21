import 'package:alarme/controller/controller.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import "screens/intro.dart";

void main() {
  runApp(MultiProvider(
      providers: [ChangeNotifierProvider(create: (context) => Controller())], child: MyApp()));
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: ChangeNotifierProvider(
            create: (_) {
              Controller();
            },
            child: const IntroScreen()));
  }
}
