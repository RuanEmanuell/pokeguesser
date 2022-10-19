import 'package:flutter/material.dart';
import 'package:alarme/controller/controller.dart';
import "package:basic_utils/basic_utils.dart";

import "pokemon.dart";

var data = Controller();

class HomeScreen extends StatelessWidget {
  TextEditingController controller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    var screenHeight = MediaQuery.of(context).size.height;
    var screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
        body: ListView(children: [
      Container(
          decoration: const BoxDecoration(
              image: DecorationImage(
                  opacity: 0.15, scale: 0.75, image: AssetImage("assets/images/pokeball.webp"))),
          child: Column(
            children: [
              Container(
                  height: screenHeight / 4.5,
                  width: screenWidth,
                  margin: const EdgeInsets.only(bottom: 90),
                  decoration: const BoxDecoration(
                      color: Colors.red,
                      borderRadius: BorderRadius.only(
                        bottomRight: Radius.circular(20),
                        bottomLeft: Radius.circular(20),
                      )),
                  child: Image.asset("assets/images/logo.png")),
              Stack(children: [
                Container(
                    width: screenWidth,
                    height: screenHeight / 2.25,
                    margin: const EdgeInsets.only(left: 110),
                    child: Image.asset("assets/images/oak.png")),
                Container(
                    margin: const EdgeInsets.only(left: 10, top: 30),
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(color: Colors.black, width: 2)),
                    child: Container(
                        width: screenWidth / 2,
                        margin: const EdgeInsets.all(10),
                        child: Text(data.text))),
                Container(
                  margin: EdgeInsets.only(left: 20, right: 20, bottom: 30, top: screenWidth / 1.75),
                  child: TextField(
                    controller: controller,
                    onTap: () {
                      data.changeText1();
                    },
                    onChanged: (value) {
                      data.changeText2();
                    },
                    decoration: const InputDecoration(
                        hintText: "Type your name...",
                        filled: true,
                        fillColor: Colors.white,
                        border: OutlineInputBorder()),
                  ),
                )
              ]),
              SizedBox(
                width: screenWidth / 3,
                height: screenHeight / 10,
                child: ElevatedButton(
                    style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
                    onPressed: () {
                      if (controller.text.isNotEmpty) {
                        data.name = StringUtils.capitalize(controller.text);
                        data.requestData();
                        Navigator.push(context, MaterialPageRoute(
                          builder: (context) {
                            return PokemonScreen(name: data.name);
                          },
                        ));
                      }
                    },
                    child: const Text("Start", style: TextStyle(fontSize: 25))),
              ),
            ],
          )),
    ]));
  }
}
