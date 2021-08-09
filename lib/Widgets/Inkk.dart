part of './Widgets.dart';

class Inkk extends StatelessWidget {
  final Widget child;
  final Color spalshColor;
  final double radius;
  final VoidCallback onTap;
  final String tooltip;
  final bool center;

  const Inkk({
    Key key,
    @required this.child,
    this.onTap,
    this.radius,
    this.spalshColor,
    this.tooltip = "Button",
    this.center = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
  //Semantics are useful when uploading to playstore, [Helps to reduce accessibility issues]     
    return Semantics(
      child: center ? centered() : stack(),
      label: tooltip,
    );
  }

  Widget centered() {
    return Center(
      child: stack(),
    );
  }

  Widget stack() {
    return Stack(
      alignment: Alignment.center,
      children: [
        primaryChild(),
        inkEffect(),
      ],
    );
  }

  Widget primaryChild() {
    return ClipRRect(
      child: child,
      borderRadius: borderRadius,
    );
  }

  Widget inkEffect() {
    return Positioned.fill(
        child: Material(
      elevation: 0,
      color: Colors.transparent,
      child: InkWell(
        borderRadius: borderRadius,
        highlightColor: highlightColor,
        splashColor: splashColor,
        onTap: onTap ?? printFn,
      ),
    ));
  }

  BorderRadius get borderRadius => BorderRadius.circular(radius ?? 8);
  Color get highlightColor => (spalshColor ?? Colors.white).withOpacity(0.35);
  Color get splashColor => (spalshColor ?? Colors.white).withOpacity(0.25);
  static void printFn() => print("Inkwell pressed");
}
