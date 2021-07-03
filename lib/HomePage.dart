import 'package:flutter/material.dart';
import 'package:fluttership/Drawer.dart';

class HomePage extends StatefulWidget {
  const HomePage({ Key key }) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar(),
      body: body(),
      drawer: DrawerPage(),
    );
  }

  Widget appBar(){
    return AppBar(
        title: Text("FlutterShip"),
      );
  }

  Widget body(){
    return Center(
        child: FlutterLogo(
          size: 150,
        ),
      );
  }

}

//simply addicted to split the widgets to make them look cleaner

//TO overcome this stausbar icon issue, you need to change
//the bgithness parameter of the theme
//will upload a short video later