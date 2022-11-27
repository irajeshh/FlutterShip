part of './Page.dart';

class VoiceButton extends StatefulWidget {
  const VoiceButton({super.key});

  @override
  State<VoiceButton> createState() => _VoiceButtonState();
}

class _VoiceButtonState extends State<VoiceButton> with SingleTickerProviderStateMixin {
  late AnimationController animationController;
  late Animation<double> animation;

  static const Duration speakingDuration = Duration(seconds: 10);

  @override
  void initState() {
    animationController = AnimationController(vsync: this, duration: speakingDuration);
    animation = Tween(begin: 20.0, end: 0.0).animate(animationController)
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
    final double shrinkedSize = 40;
    final bool expand = (animation.value).toInt().isEven;
    final double height = expand ? defaultHeight : shrinkedSize;
    final double width = expand ? defaultWidth : shrinkedSize;
    final Color color = expand ? TeslaColorz.disabledGrey : TeslaColorz.microphoneRed;

    ///Static container to restrict any size expansions that may affect other button's position
    return Container(
      height: defaultHeight,
      width: defaultWidth,
      // color: Colors.green,
      alignment: Alignment.center,
      child: Inkk(
        radius: 18,
        spalshColor: Colors.white70,
        onTap: animateRecordingFn,
        child: AnimatedContainer(
          duration: Widgets.duration,
          height: height,
          width: width,
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(18),
          ),
          alignment: Alignment.center,
          child: Icon(
            Icons.mic_rounded,
            color: Colors.white,
            size: expand? 32: 36,
          ),
        ),
      ),
    );
  }

  void animateRecordingFn() async {
    if (animationController.isAnimating == false) {
      animationController.forward();
      await Widgets.wait(speakingDuration.inMilliseconds * 2);
      animationController.animateTo(0);
    } else {
      //Animation is already processing....
    }
  }
}
