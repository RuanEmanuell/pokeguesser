import 'package:flutter/material.dart';
import 'package:alarme/controller/controller.dart';
import 'package:provider/provider.dart';
import 'package:google_fonts/google_fonts.dart';
import "package:basic_utils/basic_utils.dart";

var data = Controller();

class PokemonScreen extends StatefulWidget {
  var name;

  PokemonScreen({required this.name});

  @override
  State<PokemonScreen> createState() => _PokemonScreenState();
}

class _PokemonScreenState extends State<PokemonScreen> {
  var loading = true;

  var wrong = true;

  void initState() {
    super.initState();
    data.requestData();
    Future.delayed(Duration(seconds: 3), () {
      setState(() {
        loading = false;
      });
    });
  }

  TextEditingController controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    var wrongText = "You got it wrong, ${widget.name}! This is";
    var rightText = "You are right, ${widget.name}! This is";

    var statusHeight = MediaQuery.of(context).viewPadding.top;
    var screenHeight = MediaQuery.of(context).size.height;
    var screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
        body: loading
            ? Center(
                child: SizedBox(
                    height: screenHeight / 6.5,
                    width: screenWidth / 4,
                    child: CircularProgressIndicator(color: wrong ? Colors.red : Colors.green)))
            : SingleChildScrollView(
                child: Column(children: [
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
                        style: GoogleFonts.pressStart2p(textStyle: TextStyle(fontSize: 18))),
                  ),
                  Container(
                    margin: EdgeInsets.only(left: 20, right: 20, top: 30, bottom: 50),
                    child: TextField(
                      controller: controller,
                      decoration: const InputDecoration(
                          hintText: "Who is that Pokémon?", border: OutlineInputBorder()),
                    ),
                  ),
                  SizedBox(
                      width: screenWidth / 3,
                      height: screenHeight / 10,
                      child: ElevatedButton(
                          style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
                          onPressed: () {
                            if (controller.text != "") {
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
                                              border: Border.all(color: Colors.black, width: 3),
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
                                              Text(wrong ? wrongText : rightText),
                                              Text(
                                                  "${StringUtils.capitalize(data.pokemon["name"])}!",
                                                  style: TextStyle(
                                                      color: wrong ? Colors.red : Colors.green,
                                                      fontSize: 25)),
                                              ElevatedButton(
                                                  style: ElevatedButton.styleFrom(
                                                      backgroundColor:
                                                          wrong ? Colors.red : Colors.green),
                                                  onPressed: () {
                                                    Navigator.push(context, MaterialPageRoute(
                                                      builder: (context) {
                                                        return PokemonScreen(name: widget.name);
                                                      },
                                                    ));
                                                  },
                                                  child: Text("Next"))
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
                            } else {
                              wrong = true;
                            }
                          },
                          child: Text("Guess", style: TextStyle(fontSize: 25))))
                ]),
              ));
  }
}
