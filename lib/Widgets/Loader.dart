part of './Widgets.dart';

class Loader extends StatefulWidget {
  final Color backgroundColor;
  final Color iconColor;
  final bool center;
  final double size;
  final double padding;
  final LoaderType type;
  const Loader(
      {Key key,
      this.size = 50,
      this.backgroundColor,
      this.iconColor,
      this.center = true,
      this.padding,
      this.type = LoaderType.dribbbleBal,
  })
      : super(key: key);
  _LoaderState createState() => new _LoaderState();
}

class _LoaderState extends State<Loader> with TickerProviderStateMixin {
  AnimationController animationController;
  Animation ballBounce;
  Animation shadowFade;
  AnimationController bounceAnimationController;
  bool short = false;

  @override
  void initState() {
    super.initState();
    animationController = AnimationController(vsync: this, duration: Duration(milliseconds: 150));
    animationController.forward();
    animationController.addListener((){
     if(animationController.status == AnimationStatus.completed) setState(()=>animationController.repeat());      
    });



    bounceAnimationController = AnimationController(vsync:this,duration: Duration(milliseconds: 1000));
    bounceAnimationController.addListener(()=>setState((){}));

    bounceAnimationController.addStatusListener((status) {
            if (status == AnimationStatus.completed) {
              bounceAnimationController.reverse();
              short = !short;
            } else if (status == AnimationStatus.dismissed) {
              short = !short;
              bounceAnimationController.forward(from: 0.0);
            }
          });
    ballBounce = Tween(begin: Offset(0, 0), end: Offset(0, -10.0)).animate(bounceAnimationController);
    shadowFade = Tween(begin: 1.0, end: 0.0).animate(CurvedAnimation(curve: Interval(0.4, 1.0), parent: bounceAnimationController));
    bounceAnimationController.forward();
  }


  @override
  void dispose() { 
    animationController.dispose();
    bounceAnimationController.dispose();
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          bouncingWidget(),
          shadowWidget(),
        ],
      ),
    );
  }

  Widget bouncingWidget(){
    return Transform.translate(
             offset: ballBounce.value,
             child: rotatingWidget(),
            );
  }


  Widget rotatingWidget(){
    return AnimatedBuilder(
      animation: animationController,
      child: loadingWidget(),
      builder: (BuildContext context, Widget _widget) {
        return new Transform.rotate(
          angle: animationController.value,
          child: _widget,
        );
      },
    );
  }

  Widget loadingWidget(){
    switch (widget.type) {
      
      case LoaderType.dribbbleBal:
        return Image.asset(Assets.dribbbleBal,height: widget.size);
        break;
      case LoaderType.carTire:
        return Image.asset(Assets.carTire,height: widget.size);
        break;
      default: return Icon(Icons.sync, size: widget.size);
    }
  }

  Widget shadowWidget(){
    Color color =  widget.iconColor ?? Colors.black.withOpacity(short?0.3:0.1);
    return Opacity(
              opacity: shadowFade.value,
              child: AnimatedContainer(
                height: short? 0.005 : 0.25,
                width: widget.size/(short? 5 : 2.5),
                duration: Duration(
                 milliseconds: 1000,
                ),
                decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(360),
                color: color,
                boxShadow: [
                  BoxShadow(
                    color: color,
                    blurRadius: 5,
                    spreadRadius: 5,
                  )
                ],
                ),
              ),
            );
  }

}
