part of './Page.dart';

class Locker extends StatefulWidget {
  @override
  State<Locker> createState() => _LockerState();
}

class _LockerState extends State<Locker> {
  bool isLocked = true;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        final double totalHeight = constraints.maxHeight;
        return Stack(
          alignment: alignment,
          children: [
            colorBar(),
            dismissable(totalHeight),
          ],
        );
      },
    );
  }

  Widget colorBar() {
    return AnimatedContainer(
      duration: Widgets.duration,
      width: 80,
      alignment: alignment,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(18),
          gradient: LinearGradient(
            colors: [
              isLocked ? TeslaColorz.lockerColors.first : TeslaColorz.lockerColors.last,
              isLocked ? TeslaColorz.lockerColors.last : TeslaColorz.lockerColors.first,
            ],
            end: Alignment.bottomCenter,
            begin: Alignment.topCenter,
          )),
    );
  }

  Widget dismissable(double totalHeight) {
    return Dismissible(
        key: Key(isLocked.toString()),
        direction: DismissDirection.vertical,
        dismissThresholds: {
          DismissDirection.vertical: 0.9,
        },
        onDismissed: (_) {
          changeLockValueFn();
        },
        child: SizedBox(
          height: totalHeight / 2.5,
          child: BlackIconButton(
            icon: isLocked ? Icons.lock : Icons.lock_open,
            onTap: changeLockValueFn,
          ),
        ));
  }

  Alignment get alignment => isLocked ? Alignment.bottomCenter : Alignment.topCenter;

  void changeLockValueFn() async {
    if (mounted) setState(() => isLocked = !isLocked);
  }
}
