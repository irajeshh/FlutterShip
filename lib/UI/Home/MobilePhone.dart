import 'package:flutter/material.dart';
import '../../Widgets/Widgets.dart';

///A page to display the currently selected clone design
class MobilePhone extends StatelessWidget {
  final Widget page;
  const MobilePhone({super.key, required this.page});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(24.0),
        child: AnimatedContainer(
          child: Column(
            children: [
              topSpares(),
              display(),
              bottomNavigationBar(),
            ],
          ),
          alignment: Alignment.center,
          duration: Widgets.duration,
          height: 950,
          width: 480,
          padding: EdgeInsets.only(
            top: 2.5,
            left: 2,
            right: 2,
          ),
          decoration: BoxDecoration(
              color: Colors.black,
              borderRadius: BorderRadius.circular(18),
              border: Border.all(
                color: Colors.black,
                width: 5,
              )),
        ),
      ),
    );
  }

  Widget topSpares() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        speakerPiece(),
        camera(),
      ],
    );
  }

  Widget speakerPiece() {
    return Container(
      height: 15,
      width: 50,
      margin: const EdgeInsets.only(right: 12, bottom: 4),
      padding: EdgeInsets.all(2),
      decoration: BoxDecoration(
        color: Colors.grey.shade800,
        borderRadius: BorderRadius.circular(8),
      ),
    );
  }

  Widget camera() {
    return Container(
      margin: const EdgeInsets.only(bottom: 4),
      padding: EdgeInsets.all(2),
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: Colors.grey.shade800,
      ),
      child: Icon(
        Icons.brightness_1,
        color: Colors.blueGrey.shade900,
        size: 16,
      ),
    );
  }

  Widget display() {
    return Expanded(
      child: ClipRRect(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(8),
          topRight: Radius.circular(8),
          bottomLeft: Radius.circular(4),
          bottomRight: Radius.circular(4),
        ),
        child: page,
      ),
    );
  }

  Widget bottomNavigationBar() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          menu(Icons.menu),
          menu(Icons.home_rounded),
          menu(Icons.u_turn_left, turns: 1),
        ],
      ),
    );
  }

  Widget menu(IconData icon, {int turns = 0}) {
    return RotatedBox(
      quarterTurns: turns,
      child: Icon(
        icon,
        color: Colors.white60,
        size: 30,
      ),
    );
  }
}
