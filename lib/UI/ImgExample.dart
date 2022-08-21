import 'package:flutter/material.dart';
import 'package:fluttership/Constants/Constants.dart';
import 'package:fluttership/Widgets/Widgets.dart';

class ImgExample extends StatefulWidget {
  const ImgExample({Key? key}) : super(key: key);

  @override
  _ImgExampleState createState() => _ImgExampleState();
}

class _ImgExampleState extends State<ImgExample> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Txt(text: "Img Example"),
      ),
      body: ListView(
        children: [
          Img(
            height: 250,
            imgUrl: Urls.avatar4,
            outterPadding: 12,
          ),
          Img(
              imgUrl: Urls.avatar4,
              height: 150,
              width: 200,
              radius: 30,
              fit: BoxFit.fill,
              outterPadding: 12,
              enableRippleEffect: false,
              onTap: () {
                print("Hello");
              }),
          Img(
              imgUrl: Urls.avatar4,
              onTap: () {
                print("Hello");
              }),
        ],
      ),
    );
  }
}
