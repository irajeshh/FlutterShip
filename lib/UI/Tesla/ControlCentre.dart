part of './Page.dart';

class ControlCenter extends StatelessWidget {
  ///Used to indicate the current status of the selection
  final bool isHeadLightTurnedOn;

  ///Going to be executed when the button is pressed
  final Function(bool) onChanged;

  const ControlCenter({super.key, required this.isHeadLightTurnedOn, required this.onChanged});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: Widgets.mheight(context) / 3.5,
      padding: EdgeInsets.only(
        bottom: 50,
      ),
      width: double.maxFinite,
      child: Row(
        children: [
          leftSegment(),
          Locker(),
        ],
      ),
    );
  }

  Widget leftSegment() {
    return Expanded(
      child: Column(
        children: [
          buttonsRow(),
          ChargingIndicator(),
        ],
      ),
    );
  }

  Widget buttonsRow() {
    return Expanded(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          HeadLightButton(
            isHeadLightTurnedOn: isHeadLightTurnedOn,
            onChanged: onChanged,
          ),
          VoiceButton(),
          ACButton(),
        ],
      ),
    );
  }
}
