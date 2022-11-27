import 'package:flutter/material.dart';
import 'package:fluttership/Constants/Constants.dart';
import 'package:fluttership/Widgets/Widgets.dart';

class InkkExample extends StatefulWidget {
  const InkkExample({Key? key}) : super(key: key);

  @override
  _InkkExampleState createState() => _InkkExampleState();
}

class _InkkExampleState extends State<InkkExample> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.only(top: 28.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            square(),
            image(),
            txt(),
            circle(),
          ],
        ),
      ),
    );
  }

  Widget square() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Inkk(
        // center: true,
        spalshColor: Colors.blue.shade300,
        child: Container(
          height: 120,
          width: 120,
          color: Colors.blue,
          alignment: Alignment.center,
          child: Txt(
            text: "Square",
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }

  Widget circle() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Inkk(
        radius: 360,
        // center: true,
        spalshColor: Colors.black,
        child: CircleAvatar(
          radius: 60,
          backgroundColor: Colors.pink,
          child: Icon(Icons.favorite, color: Colors.white),
        ),
      ),
    );
  }

  Widget txt() {
    return Inkk(
      // center: true,
      radius: 4,
      spalshColor: Colors.blue,
      child: Txt(
          text: "Hello World!",
          quoted: true,
          fontWeight: FontWeight.bold,
          textAlign: TextAlign.center),
    );
  }

  Widget image() {
    return Inkk(
        // center: true,
        spalshColor: Colors.green,
        child: Image.network(
          Urls.avatar1,
          height: 120,
          width: 120,
          fit: BoxFit.cover,
        ));
  }
}
