import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import "package:introduction_screen/introduction_screen.dart";

import "home.dart";

//This is the Intro Screen, it uses the Introduction Screen package

class IntroScreen extends StatelessWidget {
  const IntroScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
        body: IntroductionScreen(
            //Buttons
            next: const Text("Next"),
            done: const Text("Done"),
            onDone: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) {
                return const HomeScreen();
              }));
            },
        //The two pages of the intro
            pages: [
          PageViewModel(
              titleWidget: Text("Welcome to Pokéguesser!",
                  style: GoogleFonts.montserrat(
                      fontSize: 18 + screenWidth / 150, fontWeight: FontWeight.bold)),
              bodyWidget: Column(children: const [
                Text("This is a game of guessing Pokémon."),
                SizedBox(height: 10),
                Text("You will be presented with 10 Pokémon"),
                Text("and will have to guess who they are."),
                SizedBox(height: 10),
                Text("Simple, right?")
              ]),
              image: SafeArea(
                child: Center(child: Image.asset("assets/images/oak.png")),
              )),
          PageViewModel(
              titleWidget: Text("Some advices:",
                  style: GoogleFonts.montserrat(fontSize: 25, fontWeight: FontWeight.bold)),
              bodyWidget: Column(children: const [
                Text("Only Pokémon names in English are accepted."),
                SizedBox(height: 10),
                Text("You have unlimited time to guess."),
                SizedBox(height: 10),
                Text("All the 905 current Pokémon are available."),
                SizedBox(height: 10),
                Text("Have fun!"),
              ]),
              image: SafeArea(
                child: Center(child: Image.asset("assets/images/bulbasaur.png")),
              )),
        ]));
  }
}
