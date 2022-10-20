import 'package:flutter/material.dart';
import 'package:alarme/controller/controller.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import "pokemon.dart";

class HomeScreen extends StatefulWidget {
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  var visible1 = false;
  var visible2 = false;

  var buttonVisible = false;

  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 1), () {
      setState(() {
        visible1 = true;
      });
    });
    Future.delayed(const Duration(seconds: 3), () {
      setState(() {
        visible2 = true;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    var data = Provider.of<Controller>(context, listen: false);

    var screenHeight = MediaQuery.of(context).size.height;
    var screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
        body: Container(
      child: ListView(children: [
        Center(
          child: AnimatedOpacity(
              duration: const Duration(seconds: 2),
              opacity: visible1 ? 1 : 0,
              child: Container(
                  margin: EdgeInsets.only(top: screenHeight / 7.5, bottom: screenHeight / 20),
                  child: Text("Before we start,",
                      style: GoogleFonts.montserrat(
                          fontWeight: FontWeight.bold, fontSize: 30 + screenWidth / 100)))),
        ),
        Center(
          child: AnimatedOpacity(
              duration: const Duration(seconds: 2),
              opacity: visible2 ? 1 : 0,
              child: Container(
                  margin: EdgeInsets.only(top: screenHeight / 20, bottom: screenHeight / 20),
                  child: Text("What's your name?",
                      style: GoogleFonts.montserrat(
                          fontWeight: FontWeight.bold, fontSize: 16 + screenWidth / 100)))),
        ),
        Center(
            child: AnimatedOpacity(
          duration: const Duration(seconds: 2),
          opacity: visible2 ? 1 : 0,
          child: Container(
            margin: const EdgeInsets.all(50),
            child: TextField(
                onSubmitted: (value) {
                  data.name = value;
                  setState(() {
                    buttonVisible = true;
                  });
                },
                decoration: const InputDecoration(
                  enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                    width: 2,
                  )),
                  border: OutlineInputBorder(),
                ),
                style: GoogleFonts.montserrat(fontWeight: FontWeight.bold, color: Colors.black)),
          ),
        )),
        Center(
          child: AnimatedOpacity(
              duration: const Duration(seconds: 2),
              opacity: buttonVisible ? 1 : 0,
              child: Container(
                  margin: EdgeInsets.only(top: screenHeight / 20, bottom: screenHeight / 30),
                  child: Text("Nice, are you ready?",
                      style: GoogleFonts.montserrat(
                          fontWeight: FontWeight.bold, fontSize: 16 + screenWidth / 100)))),
        ),
        Container(
          margin: EdgeInsets.only(left: 50, right: 50, top: screenHeight / 20),
          height: screenHeight / 10,
          child: AnimatedOpacity(
            duration: const Duration(seconds: 2),
            opacity: buttonVisible ? 1 : 0,
            child: ElevatedButton(
                onPressed: () {
                  if (data.name == "") {
                    data.name = "Red";
                  }
                  Navigator.push(context, MaterialPageRoute(builder: (context) {
                    return PokemonScreen();
                  }));
                },
                style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
                child: Text("Start",
                    style: GoogleFonts.montserrat(fontWeight: FontWeight.bold, fontSize: 30))),
          ),
        )
      ]),
    ));
  }
}
