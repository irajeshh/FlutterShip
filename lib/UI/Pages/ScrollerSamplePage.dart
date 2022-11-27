import 'package:flutter/material.dart';
import 'package:fluttership/Widgets/Widgets.dart';

class ScrollerSamplePage extends StatefulWidget {
  const ScrollerSamplePage({Key? key}) : super(key: key);

  @override
  _ScrollerSamplePageState createState() => _ScrollerSamplePageState();
}

class _ScrollerSamplePageState extends State<ScrollerSamplePage> {
  final ScrollController _scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar(),
      body: body(),
    );
  }

  AppBar appBar() {
    return AppBar(
      title: Txt(text: "Scroller Sample"),
    );
  }

  Widget body() {
    return Scroller(
      scrollController: _scrollController,
      child: ListView.builder(
        physics: BouncingScrollPhysics(),
        controller: _scrollController,
        itemCount: 100,
        itemBuilder: (BuildContext context, int index) {
          return ListTile(
            leading:
                Txt(text: index), //Txt will automatically apply all the int/double values to string
            trailing: FlutterLogo(),
          );
        },
      ),
    );
  }
}
