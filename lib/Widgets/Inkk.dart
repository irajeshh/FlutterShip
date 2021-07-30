part of './Widgets.dart';

class Inkk extends StatelessWidget {
  final Widget child;
  final Color spalshColor;
  final double radius;
  final VoidCallback onTap;
  final String tooltip;

  const Inkk(
      {Key key,
      @required this.child,
      this.onTap,
      this.radius,
      this.spalshColor,
      this.tooltip,
      })
      : super(key: key);

 
  @override
  Widget build(BuildContext context) {
    BorderRadius borderRadius = BorderRadius.circular(radius ?? 8);
    return Semantics(
       label: tooltip??"Button",
        child: ClipRRect(
        borderRadius: borderRadius,
         clipBehavior: Clip.antiAlias,
          child: stack(borderRadius),
       ),
     );
  }  

  Widget stack(BorderRadius borderRadius){
    return Stack(
              children: [
                if(child!=null) child,
                 Positioned.fill(
                 child: Material(
                  elevation: 0,
                  color: Colors.transparent,
                  child: InkWell(
                    highlightColor: (spalshColor?? Colors.deepPurple).withOpacity(0.35),
                    splashColor: (spalshColor?? Colors.deepPurple).withOpacity(0.25),
                    onTap: onTap??(){},
                  ),
                  borderRadius: borderRadius,
                )),
              ],
            );
  }
}