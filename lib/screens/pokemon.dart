import 'package:flutter/material.dart';
import 'package:alarme/controller/controller.dart';
import 'package:provider/provider.dart';
import 'package:google_fonts/google_fonts.dart';

import "end.dart";

class PokemonScreen extends StatefulWidget {
  @override
  State<PokemonScreen> createState() => _PokemonScreenState();
}

class _PokemonScreenState extends State<PokemonScreen> {
  var loading = true;

  var wrong = true;

  void initState() {
    super.initState();
    Provider.of<Controller>(context, listen: false).requestData();
    Future.delayed(Duration(seconds: 3), () {
      setState(() {
        loading = false;
      });
    });
  }

  TextEditingController controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    var data = Provider.of<Controller>(context, listen: false);

    var wrongText =
        "You got it wrong, ${Provider.of<Controller>(context, listen: false).name}! This is";
    var rightText =
        "You are right, ${Provider.of<Controller>(context, listen: false).name}! This is";

    var statusHeight = MediaQuery.of(context).viewPadding.top;
    var screenHeight = MediaQuery.of(context).size.height;
    var screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
        body: loading ? Center(
                child: SizedBox(
                    height: screenHeight / 6.5,
                    width: screenWidth / 4,
                    child: const CircularProgressIndicator(
                      color: Colors.red,
                      strokeWidth: 8,
                    ))
                ): SingleChildScrollView(
                child: Consumer<Controller>(builder: (context, value, child) {
                  return Column(children: [
                    Container(
                        margin: EdgeInsets.only(
                            right: screenWidth / 6,
                            left: screenWidth / 6,
                            top: statusHeight + 25,
                            bottom: 25),
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.black, width: 3),
                          borderRadius: BorderRadius.circular(200),
                        ),
                        child: Container(
                            margin: EdgeInsets.all(30),
                            child: FadeInImage(
                                image: NetworkImage(
                                    "${data.pokemon["sprites"]["other"]["official-artwork"]["front_default"]}"),
                                placeholder: AssetImage("assets/images/pokeball.webp")))),
                    Container(
                      margin: EdgeInsets.only(left: 20, right: 20, bottom: 25, top: 25),
                      child: Text("Who is that Pokémon?",
                          style: GoogleFonts.pressStart2p(fontSize: 18)),
                    ),
                    Container(
                      margin: EdgeInsets.only(left: 20, right: 20, top: 30, bottom: 50),
                      child: TextField(
                          controller: controller,
                          decoration: InputDecoration(
                            hintText: "Who is that Pokémon?",
                            enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                              width: 2,
                            )),
                            border: OutlineInputBorder(),
                          ),
                          style: GoogleFonts.montserrat(
                              fontWeight: FontWeight.bold, color: Colors.black)),
                    ),
                    SizedBox(
                        width: screenWidth / 3,
                        height: screenHeight / 10,
                        child: ElevatedButton(
                            style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
                            onPressed: () {
                              if (controller.text != "") {
                                data.addCount();
                                showModalBottomSheet(
                                  isDismissible: false,
                                  context: context,
                                  builder: (context) {
                                    return Container(
                                      child: Column(
                                        children: [
                                          Container(
                                              height: screenHeight / 3,
                                              margin: EdgeInsets.only(
                                                  right: screenWidth / 6,
                                                  left: screenWidth / 6,
                                                  top: 25,
                                                  bottom: 25),
                                              decoration: BoxDecoration(
                                                color: wrong ? Colors.red : Colors.green,
                                                border: Border.all(
                                                    color: Colors.black, width: 3),
                                                borderRadius: BorderRadius.circular(200),
                                              ),
                                              child: Container(
                                                margin: EdgeInsets.all(20),
                                                child: Image.network(
                                                    "${data.pokemon["sprites"]["other"]["official-artwork"]["front_default"]}"),
                                              )),
                                          Container(
                                            child: Column(
                                              children: [
                                                Text(wrong ? wrongText : rightText,
                                                    style: GoogleFonts.montserrat(
                                                        fontWeight: FontWeight.bold)),
                                                Text(
                                                    "${data.pokemon["name"].toUpperCase()}!",
                                                    style: GoogleFonts.montserrat(
                                                        color: wrong
                                                            ? Colors.red
                                                            : Colors.green,
                                                        fontSize: 25)),
                                                ElevatedButton(
                                                    style: ElevatedButton.styleFrom(
                                                        backgroundColor: wrong
                                                            ? Colors.red
                                                            : Colors.green),
                                                    onPressed: () {
                                                      if (data.counter < 10) {
                                                        Navigator.push(context,
                                                            MaterialPageRoute(
                                                          builder: (context) {
                                                            return PokemonScreen();
                                                          },
                                                        ));
                                                      } else {
                                                        Navigator.push(context,
                                                            MaterialPageRoute(
                                                          builder: (context) {
                                                            return EndScreen();
                                                          },
                                                        ));
                                                      }
                                                    },
                                                    child: Text("Next",
                                                        style: GoogleFonts.montserrat(
                                                            fontWeight: FontWeight.bold)))
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                    );
                                  },
                                );
                              }

                              if (controller.text.toLowerCase() == data.pokemon["name"]) {
                                wrong = false;
                                data.addRight();
                              } else {
                                wrong = true;
                              }
                            },
                            child: Text("Guess",
                                style: GoogleFonts.montserrat(
                                    fontWeight: FontWeight.bold, fontSize: 25))))
                  ]);
                }),
              ));
  }
}
