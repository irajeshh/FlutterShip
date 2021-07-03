import 'package:flutter/material.dart';
import 'package:fluttership/Cosntants/Constants.dart';
import 'package:fluttership/HomePage.dart';

class MyApp extends StatelessWidget {
  const MyApp({ Key key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomePage(),
      theme: theme,
    );
  }

  

  ThemeData get theme => ThemeData.light().copyWith(
    brightness: Brightness.dark,
    //if your app theme is light, set brightness to dark
    //now we need to match the blue colors, let us pick it from 
    //photoshop
    //Press PrintScreen to copy the current window 
    //Open Photoshop
    //Press Ctrl +N
    //Press Ctrl +V
    //Now click on the specific color you want
    //find the color code
    //past the code in flutter
    primaryColor: Colorz.backgroundBlue,

  );

 
}