import 'dart:convert';
import 'dart:async';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class Controller extends ChangeNotifier {
  var pokemon;

  var text = "Hello there, welcome! I'm Oak. People call me the Pokémon Professor.";

  void changeText1() async {
    text = "Now tell me, what's your name?";
    notifyListeners();
  }

  void changeText2() {
    text = "Nice, let's begin! When you are ready, press the start button.";
    notifyListeners();
  }

  Future<void> requestData() async {
    var response = await http.get(Uri.parse("https://pokeapi.co/api/v2/pokemon/132"));
    if (response.statusCode == 200) {
      print(response.body);
      pokemon = jsonDecode(response.body);
    } else {
      print("deu errado");
    }
  }
}
