part of './Widgets.dart';


class Button extends StatelessWidget {
  final Widget iconChild;
  final IconData icon;
  final dynamic text;
  final Color color;
  final double radius;
  final onPressed;
  final Color buttonColor;
  final double size;
  final int maxLines;
  final double height;
  final double width;
  final FontWeight weight;
  final bool upperCaseFirst;
  final bool showLoading;
  const Button({
    Key key,
    this.size,
    this.iconChild,
    this.icon,
    this.text,
    this.color,
    this.radius,
    this.onPressed,
    this.buttonColor = Colors.deepPurple,
    this.maxLines,
    this.height,
    this.width, this.weight, this.upperCaseFirst=false, this.showLoading=false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final RoundedRectangleBorder _shape = RoundedRectangleBorder(borderRadius: BorderRadius.circular(radius ?? 6));
    Color _buttonColor =  buttonColor ?? Colors.blue;
    Color _textColor =  color ?? Colors.white;

    Widget button;

    Widget txtWidget() {
      return Txt(
        text: text,
        fontSize: size,
        fontWeight: weight,
        maxlines: maxLines ?? 1,
        useoverflow: true,
        color: _textColor,
        upperCaseFirst:upperCaseFirst,
      );
    }

    Widget iconWidget(){
      Widget finalIconWIdget;
      if (icon != null) finalIconWIdget = Icon(icon,color: color ?? _textColor,size: size);
      if(finalIconWIdget == null) finalIconWIdget = iconChild;
      if(showLoading) finalIconWIdget = loadingCircle();
      return finalIconWIdget;
    }

//iconButton





    if (iconWidget() != null) {
      button = TextButton.icon(
              icon: iconWidget(),
              style: TextButton.styleFrom(
                backgroundColor: buttonColor ?? _buttonColor,
                shape: _shape,
              ),
              label: Flexible(child: txtWidget()),
              onPressed: onPressed,
            );
    } else {
      button = TextButton(
              style: TextButton.styleFrom(
                backgroundColor: buttonColor ?? _buttonColor,
                shape: _shape,
              ),
              child: txtWidget(),
              onPressed: onPressed,
            );
    }

    return Container(
      height: height ?? 52,
      width: width,
      padding: EdgeInsets.all(8),
      child: button,
    );
  }


   Widget loadingCircle(){
    return Material(
     type: MaterialType.circle,
     color: buttonColor,
     child: SizedBox(
        height: 26,
        width: 26,
        child: FittedBox(
          fit: BoxFit.scaleDown,
          child: CircularProgressIndicator(
            valueColor: AlwaysStoppedAnimation(Colors.white),
          ),
       ),
      ),
    );
  }
}