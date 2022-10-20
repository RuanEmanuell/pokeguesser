import 'package:flutter/material.dart';
import 'package:alarme/controller/controller.dart';
import 'package:provider/provider.dart';
import 'package:google_fonts/google_fonts.dart';

import "pokemon.dart";

class EndScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var statusHeight = MediaQuery.of(context).viewPadding.top;
    var screenHeight = MediaQuery.of(context).size.height;
    var screenWidth = MediaQuery.of(context).size.width;

    var data = Provider.of<Controller>(context, listen: false);
    return Scaffold(
        body: Container(
            margin: EdgeInsets.only(top: statusHeight * 2),
            child: Center(
              child: Column(
                children: [
                  Text(data.rightCounter <= 5 ? "Too bad, ${data.name}..." : "Congrats ${data.name}!",
                      style: GoogleFonts.montserrat(
                          fontWeight: FontWeight.bold,
                          fontSize: 19 + screenWidth / 100,
                          color: data.rightCounter <= 5 ? Colors.red : Colors.green)),
                  Text("you got ${data.rightCounter} Pokémon right!",
                      style: GoogleFonts.montserrat(
                          fontWeight: FontWeight.bold,
                          fontSize: 19 + screenWidth / 120,
                          color: data.rightCounter <= 5 ? Colors.red : Colors.green)),
                  Container(
                      margin: const EdgeInsets.all(10),
                      height: screenHeight / 2.5,
                      child: Image.asset("assets/images/oak.png")),
                  Container(
                    margin: const EdgeInsets.only(top: 20),
                    child: Text("Wanna try again?",
                        style: GoogleFonts.montserrat(
                            fontSize: 25 + screenWidth / 100, fontWeight: FontWeight.bold)),
                  ),
                  Container(
                    margin: EdgeInsets.only(top: screenHeight / 15),
                    height: screenHeight / 7,
                    width: screenWidth / 4,
                    decoration: BoxDecoration(
                        color: data.rightCounter <= 5 ? Colors.red : Colors.green,
                        borderRadius: BorderRadius.circular(50)),
                    child: IconButton(
                        icon: const Icon(Icons.refresh, color: Colors.white, size: 40),
                        onPressed: () {
                          data.resetCounters();
                          Navigator.push(context, MaterialPageRoute(
                            builder: (context) {
                              return PokemonScreen();
                            },
                          ));
                        }),
                  )
                ],
              ),
            )));
  }
}
