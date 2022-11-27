part of './Widgets.dart';
///A shining widget just to be used like a placeholder.
///This can be customized as much as possible to adapt the parent widget.
class Shimmer extends StatefulWidget {
  ///[width] of the shimmer, by default this is [double.maxFinite]
  final double? width;
  ///[height] of the shimmer, by default it's [100.0]
  final double? height;
  ///[radius] of the shimmer, by default it's [8.0]
  final double? radius;
  ///vertical padding value, by default it's [8.0]
  final double verticalPadding;
  ///horizontal padding value, by default it's [8.0]
  final double horizontalPadding;

  ///Constructor
  const Shimmer({Key? key, this.width, this.height = 100.0, this.radius = 8.0, this.verticalPadding = 8.0, this.horizontalPadding = 8.0}) : super(key: key);

  @override
  ShimmerState createState() => ShimmerState();

  ///A listview which renders some list of shimmers to reduce
  /// the code
  static Widget listView = ListView.builder(
    padding: const EdgeInsets.all(12),
    itemCount: 10,
    itemBuilder: (BuildContext context, int index) {
      return const Shimmer(
        height: 120,
        width: double.maxFinite,
        horizontalPadding: 12,
      );
    },
  );
   ///A listview which renders some list of shimmers to reduce
  /// the code with shrinkWrap = true
  static Widget shrinkWrapTrue = ListView.builder(
    shrinkWrap: true,
    itemCount: 10,
    padding: const EdgeInsets.all(12),
    itemBuilder: (BuildContext context, int index) {
      return const Shimmer(
        height: 120,
        width: double.maxFinite,
        horizontalPadding: 12,
      );
    },
  );
}

///Stateful widget
class ShimmerState extends State<Shimmer> with TickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _frontScale;
  ///Duration for the shining animation
  final Duration duration = const Duration(milliseconds: 600);

  @override
  void initState() {
   init();
  super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: widget.verticalPadding, horizontal: widget.horizontalPadding),
      child: AnimatedContainer(
        width: widget.width,
        height: widget.height,
        duration: Widgets.duration,
        decoration: BoxDecoration(
          color: Colors.grey.withOpacity(_frontScale.value == 0 ? 0.1 : 0.4),
          borderRadius: BorderRadius.circular(widget.radius ?? 0),
        ),
      ),
    );
  }

  ///Initiating animation
  void init(){
        _controller = AnimationController(
      vsync: this,
      duration: duration,
    )
      ..addListener(() {
        setState(() {});
      })
      ..addStatusListener((AnimationStatus status) {
        if (status == AnimationStatus.completed) {
          _controller.reverse();
        } else if (status == AnimationStatus.dismissed) {
          _controller.forward(from: 0.0);
        }
      });
    _frontScale = Tween<double>(
      begin: 1.0,
      end: 0.0,
    ).animate(CurvedAnimation(
      parent: _controller,
      curve: const Interval(0.0, 0.5, curve: Curves.easeIn),
    ),);
    animate();
  }

  ///Executing animation
  Future<void> animate() async {
    setState(() {
      if (_controller.isCompleted || _controller.velocity > 0) {
        _controller.reverse();
      } else {
        _controller.forward();
      }
    });
  }
}
