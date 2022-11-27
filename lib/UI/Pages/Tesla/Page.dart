import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttership/Constants/Constants.dart';
import 'package:fluttership/Widgets/Widgets.dart';
import 'package:wave/wave.dart';
import 'package:wave/config.dart';
part './CarSegment.dart';
part './ControlCentre.dart';
part './Locker.dart';
part './ChargingIndicator.dart';
part './HeadLightButton.dart';
part './VoiceButton.dart';
part './ACButton.dart';
part './BlackIconButton.dart';

class TeslaCarAppPage extends StatefulWidget {
  const TeslaCarAppPage({super.key});

  @override
  State<TeslaCarAppPage> createState() => _TeslaCarAppPageState();
}

class _TeslaCarAppPageState extends State<TeslaCarAppPage> {
  bool isHeadLightTurnedOn = false;

  @override
  void initState() {
    ///Hiding status & navigation bars on android
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersiveSticky, overlays: []);

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        ///Showing status & navigation bars on android
        SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual, overlays: SystemUiOverlay.values);
        Widgets.pop(context);
        return true;
      },
      child: Scaffold(
        body: splitedBody(),
        backgroundColor: Colors.black,
      ),
    );
  }

  Widget splitedBody() {
    return Stack(
      alignment: Alignment.bottomCenter,
      children: [
        CarSegment(
          isHeadLightTurnedOn: isHeadLightTurnedOn,
        ),
        ControlCenter(
          isHeadLightTurnedOn: isHeadLightTurnedOn,
          onChanged: (z) {
            if (mounted) setState(() => isHeadLightTurnedOn = z);
          },
        ),
      ],
    );
  }
}
