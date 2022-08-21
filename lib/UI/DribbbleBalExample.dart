import 'package:flutter/material.dart';
import 'package:fluttership/Widgets/Widgets.dart';

class DribbbleBallExamplePage extends StatefulWidget {
  const DribbbleBallExamplePage({Key? key}) : super(key: key);

  @override
  _DribbbleBallExamplePageState createState() => _DribbbleBallExamplePageState();
}

class _DribbbleBallExamplePageState extends State<DribbbleBallExamplePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(appBar: appBar(), body: body());
  }

  AppBar appBar() {
    return AppBar(
      title: Txt(text: "Dribbble"),
      centerTitle: true,
      automaticallyImplyLeading: false,
      backgroundColor: Colors.pink,
    );
  }

  Widget body() {
    return Center(
      child: Loader(
        size: 150,
      ),
    );
  }
}
