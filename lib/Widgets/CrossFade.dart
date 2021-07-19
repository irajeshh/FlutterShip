part of './Widgets.dart';

class CrossFade extends StatelessWidget {
  final Widget firstChild;
  final Widget secondChild;
  final bool showSecond;
  final bool hide;
  final EdgeInsets padding;
  final bool useCenter;

  const CrossFade({
    Key key,
    @required this.firstChild,
    @required this.secondChild,
    this.showSecond = false,
    this.hide = false,
    this.padding,
    this.useCenter = true,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
        padding: padding,
        child: AnimatedCrossFade(
          firstChild: animatedCrossFade(),
          secondChild: Container(),
          duration: Duration(milliseconds: 500),
          crossFadeState:
              hide ? CrossFadeState.showSecond : CrossFadeState.showFirst,
        ));
  }

  Widget animatedCrossFade() {
    Widget child = AnimatedCrossFade(
      firstChild: firstChild,
      secondChild: secondChild,
      duration: Duration(milliseconds: 500),
      crossFadeState:
          showSecond ? CrossFadeState.showSecond : CrossFadeState.showFirst,
    );
    if (useCenter) {
      return Center(
        child: child,
      );
    } else {
      return child;
    }
  }
}
