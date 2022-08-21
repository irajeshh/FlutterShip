part of './Widgets.dart';

class Scroller extends StatelessWidget {
  final ScrollController scrollController;
  final Widget? child;
  final bool useScrollIndicator;
  const Scroller(
      {Key? key,
      required this.scrollController,
      required this.child,
      this.useScrollIndicator = false})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: onWillPop,
      child: useScrollIndicator ? indicator() : childWidget(),
    );
  }

  Widget indicator() {
    return Scrollbar(
      child: childWidget(),
      thickness: 10,
    );
  }

  Widget childWidget() {
    return child ?? Center(child: Icon(Icons.sentiment_dissatisfied));
  }

  Future<bool> onWillPop() async {
    bool allowToExit = scrollController.position.pixels < 10;
    if (allowToExit) {
      return true;
    } else {
      try {
        scrollController.animateTo(0, duration: Duration(seconds: 1), curve: Curves.ease);
        //in some cases, you may face issues caused by the child widgets,
        //for better safety use try catch blocks
      } catch (e) {
        return true;
      }
      return false;
    }
  }
}
