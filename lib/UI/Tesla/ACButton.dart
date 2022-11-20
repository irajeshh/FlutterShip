part of './Page.dart';

class ACButton extends StatefulWidget {
  const ACButton({super.key});

  @override
  State<ACButton> createState() => _ACButtonState();
}

class _ACButtonState extends State<ACButton> with SingleTickerProviderStateMixin {
  late AnimationController animationController;
  late Animation<double> animation;

  static const Duration spinningDuration = Duration(seconds: 2);

  @override
  void initState() {
    animationController = AnimationController(vsync: this, duration: spinningDuration);
    animation = Tween(begin: 5.0, end: 1.0).animate(animationController)
      ..addListener(() {
        if (mounted) setState(() {});
      });
    super.initState();
  }

  @override
  void dispose() {
    animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final double defaultHeight = 120;
    final double defaultWidth = 75;

    ///Static container to restrict any size expansions that may affect other button's position
    return Inkk(
      radius: 18,
      spalshColor: Colors.white70,
      onTap: animateSpinningFn,
      child: Container(
        height: defaultHeight,
        width: defaultWidth,
        decoration: BoxDecoration(
          color: TeslaColorz.disabledGrey,
          borderRadius: BorderRadius.circular(18),
        ),
        alignment: Alignment.center,
        child: bubles(),
      ),
    );
  }

  Widget bubles() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            buble(4),
            buble(3),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            buble(5),
            buble(2),
          ],
        )
      ],
    );
  }

  Widget buble(int value) {
    return Padding(
        padding: const EdgeInsets.all(5.0),
        child: AnimatedBuilder(
            animation: animation,
            builder: ((context, child) {
              final bool current = animation.value.toInt() == value;
              final double size = current ? 5 :6;
              return AnimatedContainer(
                duration: Widgets.duration,
                height: size,
                width: size,
                decoration: BoxDecoration(
                  color: current ? Colors.grey : Colors.white,
                  shape: BoxShape.circle,
                ),
              );
            })));
  }

  void animateSpinningFn() async {
    if (animationController.isAnimating == false) {
      animationController.forward();
      await Widgets.wait(spinningDuration.inMilliseconds + 750);
      animationController.reverse();
    } else {
      //Animation is already processing....
    }
  }
}
