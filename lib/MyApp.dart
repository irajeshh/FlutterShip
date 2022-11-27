import 'package:flutter/material.dart';
import 'package:fluttership/Constants/Constants.dart';
import 'package:fluttership/Scroll.dart';
import 'package:oktoast/oktoast.dart';
import 'UI/Home/Home.dart';

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return OKToast(
      child: MaterialApp(
        scrollBehavior: WeBScrollBehavior(),
        debugShowCheckedModeBanner: false,
        home: HomePage(),
        theme: theme,
      ),
    );
  }

  ThemeData get theme => ThemeData.light().copyWith(
        brightness: Brightness.light,
        primaryColor: Colorz.primaryColor,
      );
}
