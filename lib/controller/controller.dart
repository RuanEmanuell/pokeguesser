import 'dart:convert';
import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class Controller extends ChangeNotifier {
  var pokemon;

  var name;

  var counter = 0;

  var rightCounter = 0;

  addCount() {
    counter++;
    notifyListeners();
  }

  addRight() {
    rightCounter++;
    notifyListeners();
  }

  resetCounters() {
    counter = 0;
    rightCounter = 0;
  }

  Future requestData() async {
    var random = Random().nextInt(905);
    var response = await http.get(Uri.parse("https://pokeapi.co/api/v2/pokemon/$random"));
    if (response.statusCode == 200) {
      pokemon = jsonDecode(response.body);
      notifyListeners();
    } else {
      print("deu errado");
    }
  }
}
