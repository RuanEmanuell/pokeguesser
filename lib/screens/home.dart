import 'package:flutter/material.dart';
import 'package:alarme/controller/controller.dart';
import "package:basic_utils/basic_utils.dart";
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

  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 1), () {
      setState(() {
        visible1 = true;
      });
    });
    Future.delayed(Duration(seconds: 3), () {
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
                  margin: const EdgeInsets.only(top: 50, bottom: 50),
                  child: Text("Welcome!",
                      style: GoogleFonts.montserrat(
                          fontWeight: FontWeight.bold, fontSize: 50)))),
        ),
        Center(
          child: AnimatedOpacity(
              duration: const Duration(seconds: 2),
              opacity: visible2 ? 1 : 0,
              child: Container(
                  margin: const EdgeInsets.only(top: 50),
                  child: Text("What's your name?",
                      style: GoogleFonts.montserrat(
                          fontWeight: FontWeight.bold, fontSize: 20)))),
        ),
        Center(
            child: AnimatedOpacity(
          duration: Duration(seconds: 2),
          opacity: visible2 ? 1 : 0,
          child: Container(
            margin: EdgeInsets.all(50),
            child: TextField(
                onSubmitted: (value) {
                  data.name = value;
                  setState(() {
                    buttonVisible = true;
                  });
                },
                decoration: InputDecoration(
                  enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                    width: 2,
                  )),
                  border: OutlineInputBorder(),
                ),
                style: GoogleFonts.montserrat(
                    fontWeight: FontWeight.bold, color: Colors.black)),
          ),
        )),
        Container(
          margin: EdgeInsets.all(50),
          height: screenHeight / 10,
          child: AnimatedOpacity(
            duration: Duration(seconds: 1),
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
                    style: GoogleFonts.montserrat(
                        fontWeight: FontWeight.bold, fontSize: 30))),
          ),
        )
      ]),
    ));
  }
}
