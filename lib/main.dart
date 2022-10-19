import 'package:alarme/controller/controller.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import "screens/home.dart";

void main() {
  runApp(ChangeNotifierProvider(create: (context) => Controller(), child: MaterialApp(
        home:MyApp()
      )));
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return HomeScreen();
  }
}
