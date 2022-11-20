part of './Page.dart';

class CarSegment extends StatefulWidget {
  final bool isHeadLightTurnedOn;
  const CarSegment({super.key, required this.isHeadLightTurnedOn});

  @override
  State<CarSegment> createState() => _CarSegmentState();
}

class _CarSegmentState extends State<CarSegment> {


  bool get _isOn => widget.isHeadLightTurnedOn;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Container(
          height: Widgets.mheight(context) / 1.25,
          width: Widgets.mwidth(context),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: TeslaColorz.backdropColors,
              end: Alignment.bottomCenter,
              begin: Alignment.topCenter,
            ),
          ),
          padding: EdgeInsets.only(
            top: 65,
          ),
          child: Column(
            children: [
              title(),
              modelChip(),
              carStack(),
            ],
          ),
        ),
      ],
    );
  }

  Widget title() {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 28,
      ),
      child: Txt(
        text: 'Your car\nis ready to go',
        textAlign: TextAlign.center,
        color: Colors.white,
        fontSize: 40,
        fontWeight: FontWeight.w600,
      ),
    );
  }

  Widget modelChip() {
    return Container(
      height: 32.5,
      width: 125,
      margin: EdgeInsets.only(top: 14),
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: Colors.black26,
        borderRadius: BorderRadius.circular(90),
      ),
      child: Txt(
        text: 'Tesla modal S',
        color: Colors.white,
      ),
    );
  }

  Widget carStack() {
    return Padding(
      padding: const EdgeInsets.only(
        top: 50,
        left: 25,
        right: 25,
      ),
      child: Stack(
        alignment: Alignment.center,
        children: [
          darkenCar(),
          glowingCarBody(),
          glowingLight(),
        ],
      ),
    );
  }

  Widget darkenCar() {
    return ColorFiltered(
        colorFilter: ColorFilter.mode(
          Colors.black.withOpacity(_isOn? 0: 0.25),
          BlendMode.srcATop,
        ),
        child: Image.asset(TeslaAssets.car));
  }

  Widget glowingCarBody() {
    return AnimatedOpacity(
      opacity: _isOn? 1: 0,
      duration: Widgets.duration1Sec,
      child: ColorFiltered(
          colorFilter: ColorFilter.mode(
            Colors.white,
            BlendMode.srcATop,
          ),
          child: Image.asset(TeslaAssets.body)),
    );
  }

  Widget glowingLight() {
    final double val = _isOn? 2.75 : 0;
    return AnimatedOpacity(
      opacity: _isOn?1:0,
      duration: Widgets.duration3Sec,
      child: ImageFiltered(
        imageFilter: ImageFilter.blur(sigmaX: val, sigmaY: val),
        child: ColorFiltered(
            colorFilter: ColorFilter.mode(
               Colors.white,
              BlendMode.srcIn,
            ),
            child: Image.asset(TeslaAssets.lights)),
      ),
    );
  }
}
