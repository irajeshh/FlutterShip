import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:responsive_builder/responsive_builder.dart';
import '../../Widgets/Widgets.dart';


///Home page which dynamically provides different home for different devices
class HomePage extends StatefulWidget {
  ///Constructor
  const HomePage({Key? key,}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Material(
      child: ResponsiveBuilder(
        builder: (BuildContext builder, SizingInformation screen) {
          final bool isValid =
              screen.localWidgetSize.height > 400 && screen.localWidgetSize.width > 600;
          if (isValid) {
            return MediaQuery(
              data: MediaQuery.of(context).copyWith(textScaleFactor: kIsWeb ? 1.25 : 1.3),
              child:Txt(text: 'text'),
            );
          } else {
            return smallDevice();
          }
        },
      ),
    );
  }

  ///For smaller devices
  Widget smallDevice() {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: const <Widget>[
          ListTile(
            title: Txt(
              text: 'Small device',
              fontSize: 40,
              textAlign: TextAlign.center,
            ),
            subtitle: Txt(
              text: 'Please visit on laptop or PC',
              textAlign: TextAlign.center,
            ),
          ),
        ],
      ),
    );
  }
}
