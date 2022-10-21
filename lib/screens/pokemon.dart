import 'package:flutter/material.dart';
import 'package:alarme/controller/controller.dart';
import 'package:provider/provider.dart';
import 'package:google_fonts/google_fonts.dart';

import "end.dart";

//Guess Pokémon Screen

class PokemonScreen extends StatefulWidget {
  const PokemonScreen({super.key});

  @override
  State<PokemonScreen> createState() => _PokemonScreenState();
}

class _PokemonScreenState extends State<PokemonScreen> {
  var loading = true;

  var wrong = true;

  @override
  void initState() {
    super.initState();
    //Fetching data from the API and displaying loading screen for 3 seconds
    Provider.of<Controller>(context, listen: false).requestData();
    Future.delayed(const Duration(seconds: 3), () {
      setState(() {
        loading = false;
      });
    });
  }

  TextEditingController controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    var data = Provider.of<Controller>(context, listen: false);

    //Defining what text will appear if the player gets the Pokémon right
    var wrongText = "You got it wrong, ${Provider.of<Controller>(context, listen: false).name}! This is";
    var rightText = "You are right, ${Provider.of<Controller>(context, listen: false).name}! This is";

    var screenHeight = MediaQuery.of(context).size.height;
    var screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
        //Displaying the loading and then the guess screen
        body: loading
            ? const Center(
                child: CircularProgressIndicator(
                color: Colors.red,
                strokeWidth: 5,
              ))
            : SingleChildScrollView(
                child:  Column(children: [
                    //Pokémon circle image container
                    Container(
                        margin: EdgeInsets.only(
                            right: screenWidth / 6,
                            left: screenWidth / 6,
                            top: screenHeight / 10,
                            bottom: 25),
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.black, width: 3),
                          borderRadius: BorderRadius.circular(200),
                        ),
                        child: Container(
                            margin: const EdgeInsets.all(30),
                            child: FadeInImage(
                                image: NetworkImage(
                                    "${data.pokemon["sprites"]["other"]["official-artwork"]["front_default"]}"),
                                placeholder: const AssetImage("assets/images/pokeball.webp")))),
                    //Who is that Pokémon and TextField, respectively
                    Container(
                      margin: EdgeInsets.only(
                          left: 20, right: 20, bottom: screenHeight / 30, top: screenHeight / 30),
                      child: Text("Who is that Pokémon?",
                          style: GoogleFonts.pressStart2p(fontSize: 10.5 + screenWidth / 100)),
                    ),
                    Container(
                      margin: EdgeInsets.only(
                          left: 20, right: 20, top: screenHeight / 30, bottom: screenHeight / 30),
                      child: TextField(
                          controller: controller,
                          decoration: const InputDecoration(
                            hintText: "Who is that Pokémon?",
                            enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                              width: 2,
                            )),
                            border: OutlineInputBorder(),
                          ),
                          style:
                              GoogleFonts.montserrat(fontWeight: FontWeight.bold, color: Colors.black)),
                    ),
                    //Guess button
                    Container(
                        width: screenWidth / 3,
                        height: screenHeight / 10,
                        margin: EdgeInsets.only(top: screenHeight / 30),
                        child: ElevatedButton(
                            style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
                            onPressed: () {
                              //Adding count of guesses made and opening modal
                              if (controller.text != "") {
                                data.addCount();
                                showModalBottomSheet(
                                  isDismissible: false,
                                  context: context,
                                  builder: (context) {
                                    return Column(
                                      children: [
                                        Container(
                                            height: screenHeight / 3,
                                            margin: EdgeInsets.only(
                                                right: screenWidth / 6,
                                                left: screenWidth / 6,
                                                top: screenHeight/50,
                                                bottom: screenHeight/50),
                                            decoration: BoxDecoration(
                                              color: wrong ? Colors.red : Colors.green,
                                              border: Border.all(color: Colors.black, width: 3),
                                              borderRadius: BorderRadius.circular(200),
                                            ),
                                            child: Container(
                                              margin: const EdgeInsets.all(20),
                                              child: Image.network(
                                                  "${data.pokemon["sprites"]["other"]["official-artwork"]["front_default"]}"),
                                            )),
                                        Column(
                                            children: [
                                              Text(wrong ? wrongText : rightText,
                                                  style: GoogleFonts.montserrat(
                                                      fontWeight: FontWeight.bold)),
                                              Text("${data.pokemon["name"].toUpperCase()}!",
                                                  style: GoogleFonts.montserrat(
                                                      color: wrong ? Colors.red : Colors.green,
                                                      fontSize: 25)),
                                              ElevatedButton(
                                                  style: ElevatedButton.styleFrom(
                                                      backgroundColor:
                                                          wrong ? Colors.red : Colors.green),
                                                  onPressed: () {
                                                    //Checking if the game is over
                                                    if (data.counter < 10) {
                                                      Navigator.push(context, MaterialPageRoute(
                                                        builder: (context) {
                                                          return const PokemonScreen();
                                                        },
                                                      ));
                                                    } else {
                                                      Navigator.push(context, MaterialPageRoute(
                                                        builder: (context) {
                                                          return const EndScreen();
                                                        },
                                                      ));
                                                    }
                                                  },
                                                  child: Text("Next",
                                                      style: GoogleFonts.montserrat(
                                                          fontWeight: FontWeight.bold)))
                                            ]
                                          )
                                      ]
                                    );
                                  },
                                );
                              }

                              //Checking if it's right
                              if (controller.text.toLowerCase() == data.pokemon["name"]) {
                                wrong = false;
                                data.addRight();
                              } else {
                                wrong = true;
                              }

                            },
                            child: Text("Guess",
                                style: GoogleFonts.montserrat(
                                    fontWeight: FontWeight.bold, fontSize: 19 + screenWidth / 100))))
                  ]
                  )
    
              ));
  }
}
