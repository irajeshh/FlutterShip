part of './Page.dart';

class ChargingIndicator extends StatefulWidget {
  const ChargingIndicator({super.key});

  @override
  State<ChargingIndicator> createState() => _ChargingIndicatorState();
}

class _ChargingIndicatorState extends State<ChargingIndicator> with SingleTickerProviderStateMixin {
  static const double defaultCharge = 0.575;///It was 0.32 on older method
  static const Duration chargingDuration = Duration(seconds: 5);
  // double charge = defaultCharge;

  double get charge => animation.value;

  late AnimationController animationController;
  late Animation animation;

  @override
  void initState() {
    animationController = AnimationController(vsync: this, duration: chargingDuration);
    animation = Tween(begin: 1.0, end: 0.0).animate(animationController)
      ..addListener(() {
        if (mounted) setState(() {});
      });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Stack(
        alignment: Alignment.centerLeft,
        children: [
          indicationWaves(),
          BlackIconButton(
            icon: Icons.bolt,
            onTap: animateChargeFn,
          ),
        ],
      ),
    );
  }

  Widget indicationWaves() {
    return ClipRRect(
      borderRadius: BorderRadius.circular(18),
      child: RotatedBox(
        quarterTurns: 1,
        child: SizedBox(
          height: Widgets.mwidth(context) / 1.35,
          width: 72.5,
          child: Stack(
            alignment: Alignment.center,
            children: [
              bottomWaves(),
              topGradient(),
            ],
          ),
        ),
      ),
    );
  }

  Widget bottomWaves() {
    return WaveWidget(
      backgroundColor: TeslaColorz.disabledGrey,
      config: CustomConfig(
        colors: TeslaColorz.chargingWaveColors,
        durations: [
          18000,
          8000,
          5000,
          12000,
        ],
        heightPercentages: [
          charge,
          charge + 0.01,
          charge + 0.02,
          charge + 0.03,
        ],
      ),
      size: Size(double.infinity, double.infinity),
      waveAmplitude: 5,
    );
  }

  Widget topGradient() {
    return AnimatedContainer(
      duration: Widgets.duration,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            TeslaColorz.chargingWaveColors.first.withOpacity(0.5),
            TeslaColorz.chargingBlue,
            TeslaColorz.chargingBlue.withOpacity(0.1),
            Colors.transparent,
          ],
          begin: Alignment.bottomCenter,
          end: Alignment.center,
        ),
      ),
    );
  }

  void animateChargeFn() async {
    if (animationController.isAnimating == false) {
      animationController.forward();
      await Widgets.wait(chargingDuration.inMilliseconds * 2);
      animationController.animateTo(defaultCharge);
    } else {
      //Animation is already processing....
    }
  }

  // void chargeFn() async {
  //   // final List<double> levels = <double>[0.2, 0.3, 0.3, 0.4, 0.5, 0.6, 0.7, 0.8, 0.9, 1.0];
  //   // for (var i = 0; i < levels.length; i++) {
  //   //   if (mounted) setState(() => charge = levels[i]);
  //   //   await Widgets.wait(1000);
  //   // }

  //   // await Widgets.wait(5000);

  //   // ///Reset it back as per UI design
  //   // if (mounted) setState(() => charge = defaultCharge);
  // }
}
