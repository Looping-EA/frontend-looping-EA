import "package:flutter/material.dart";

class OwnMessageCard extends StatelessWidget {
  const OwnMessageCard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Align(
        alignment: Alignment.centerRight,
        child: ConstrainedBox(
            constraints: BoxConstraints(
                maxWidth: MediaQuery.of(context).size.width * 0.5),
            child: Card(
                elevation: 2,
                color: Colors.green[200],
                margin: EdgeInsets.symmetric(
                    horizontal: size.width * 0.03, vertical: size.width * 0.01),
                child: Stack(children: [
                  Padding(
                      padding: EdgeInsets.only(
                          left: size.width * 0.02,
                          right: size.width * 0.05,
                          top: size.width * 0.01,
                          bottom: size.width * 0.02),
                      child: Text(
                          "Hola Xape has acabado ya el chat agaggagagagagggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggg?",
                          style: TextStyle(fontSize: 16))),
                  Positioned(
                      bottom: size.width * 0.01,
                      right: size.width * 0.01,
                      child: Row(children: [
                        Text("16:18",
                            style:
                                TextStyle(fontSize: 13, color: Colors.black87))
                      ]))
                ]))));
  }
}
