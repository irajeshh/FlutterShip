import 'package:flutter/material.dart';
import 'package:fluttership/Constants/Constants.dart';
import 'package:fluttership/Widgets/Widgets.dart';

///Example page to use [DoubleCard] widget
class DoubleCardExample extends StatelessWidget {
  const DoubleCardExample({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar(),
      body: body(),
    );
  }

  AppBar appBar() {
    return AppBar(
      title: Txt(text: 'Double card example'),
      backgroundColor: Colorz.complexDrawerBlack,
    );
  }

  Widget body() {
    return ListView.builder(
      itemCount: colors.length,
      itemBuilder: (BuildContext context, int index) {
        final Color color = colors[index];
        return DoubleCard(
          color: color,
        );
      },
    );
  }

  static final List<Color> colors = [
      Colorz.doubleCardBlue,
      Colors.teal,
      Colorz.complexDrawerBlueGrey,
      Colors.pink,
      Colors.amber,
    ];
}
