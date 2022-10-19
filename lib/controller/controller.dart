import 'dart:convert';
import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class Controller extends ChangeNotifier {
  var pokemon;

  var text = "Hello there, welcome! I'm Oak. People call me the Pokémon Professor.";

  var name;

  changeText1() async {
    text = "Now tell me, what's your name?";
    notifyListeners();
  }

  changeText2() {
    text = "Nice, let's begin! When you are ready, press the start button.";
    notifyListeners();
  }

  Future requestData() async {
    var random = Random().nextInt(900);
    var response = await http.get(Uri.parse("https://pokeapi.co/api/v2/pokemon/${random}"));
    if (response.statusCode == 200) {
      pokemon = jsonDecode(response.body);
      notifyListeners();
    } else {
      print("deu errado");
    }
  }
}
