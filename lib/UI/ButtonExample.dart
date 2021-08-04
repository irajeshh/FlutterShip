import 'package:flutter/material.dart';
import 'package:fluttership/Constants/Constants.dart';
import 'package:fluttership/Widgets/Widgets.dart';
import 'package:flutter/services.dart';

class ButtonExample extends StatefulWidget {
  const ButtonExample({Key key}) : super(key: key);

  @override
  _ButtonExampleState createState() => _ButtonExampleState();
}

class _ButtonExampleState extends State<ButtonExample> {
  bool uploading = false;

  @override
  void initState() {
    SystemChrome.setEnabledSystemUIOverlays([SystemUiOverlay.bottom]);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: appBar(),
      body: body(),
      backgroundColor: Colorz.buttonExampleCanvas,
    );
  }

  AppBar appBar() {
    return AppBar(
      title: Txt(text: "Button Example"),
      backgroundColor: Colorz.complexDrawerBlack,
    );
  }

  Widget body() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        row1(),
        row2(),
        row3(),
      ],
    );
  }

  Widget row1() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        children: [
           Button(
            text: "Downloading...",
            processing: true,
            icon: Icons.cloud_download,
            buttonColor: Colors.deepPurple,
          ),
           
          Button(
          text: "Uploading File...",
          icon: Icons.cloud_upload,
          buttonColor: Colors.pink,
          outlined: true,
        ),
         
         

        ],
      ),
    );
  }

  Widget row2() {
    return Row(
      children: [
         Button(
            text: "Upload File",
            icon: Icons.cloud_upload,
            buttonColor: Colors.blue,
          ),
        Button(
          text: "Download File",
          icon: Icons.cloud_download,
          buttonColor: Colors.deepOrange,
          outlined: true,
        ),
      ],
    );
  }

  Widget row3() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        children: [
          Expanded(
            child: Button(
              height: 60,
              text: "Sharing...",
              icon: Icons.share,
              processing: true,
              outlined: true,
              buttonColor: Colors.green,
            ),
          ),
          Button(
            height: 60,
            text: "Subscribed",
            icon: Icons.notifications_active,
            buttonColor: Colors.red.shade900,
          ),
        ],
      ),
    );
  }
}
