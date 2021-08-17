import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:fluttership/Constants/Constants.dart';
import 'package:fluttership/Widgets/Widgets.dart';

class LoadersPage extends StatefulWidget {
  const LoadersPage({Key key}) : super(key: key);

  @override
  _LoadersPageState createState() => _LoadersPageState();
}

class _LoadersPageState extends State<LoadersPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(appBar: appBar(), body: body());
  }

  AppBar appBar() {
    return AppBar();
  }

  Widget body() {
    return ListView(
      children: [
        Loader(
          size: 150,
          type: LoaderType.dribbbleBal,
        ),
        Loader(
          size: 150,
          type: LoaderType.carTire,
        ),
      ],
    );
  }
}