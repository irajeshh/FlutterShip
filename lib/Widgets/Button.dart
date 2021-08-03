part of './Widgets.dart';


class Button extends StatelessWidget {
  final dynamic icon;
  final dynamic text;
  final Color textColor;
  final double radius;
  final onPressed;
  final Color buttonColor;
  final double fontSize;
  final int maxLines;
  final double height;
  final double width;
  final FontWeight fontWeight;
  final bool upperCaseFirst;
  final bool showLoading;
  final bool outlined;
  const Button({
    Key key,
    this.fontSize,
    this.icon,
    this.text,
    this.textColor = Colors.white,
    this.radius,
    this.onPressed = invalidAction,
    this.buttonColor = Colors.deepPurple,
    this.maxLines,
    this.height,
    this.width,
    this.fontWeight,
    this.upperCaseFirst=false,
    this.showLoading=false,
    this.outlined = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height ?? 52,
      width: width,
      padding: EdgeInsets.all(8),
      child: finalButton(),
    );
  }

 
 Widget finalButton(){
   if(isIconButton){
     return outlined? outlinedIconButton() : iconButton();
   }else{
     return outlined? outlinedNormalButton():normalButton();
   }
 }


 Widget iconButton(){
   return TextButton.icon(
        icon: iconWidget(),
        style: normalButtonStyle,
        label: label(),
        onPressed: onPressed,
     );
 }

 Widget normalButton(){
   return TextButton(
      child: txtWidget(),
      style: normalButtonStyle,
      onPressed: onPressed,
   );
 }


 Widget outlinedIconButton(){
   return OutlinedButton.icon(
     icon: iconWidget(),
     label: label(),
     onPressed: onPressed,
     style: outlinedButtonStyle,
   );
 }
 
 Widget outlinedNormalButton(){
   return OutlinedButton(
     child: label(),
     onPressed: onPressed,
     style: outlinedButtonStyle,
   );
 }

  Widget label(){
    return Flexible(child: txtWidget());
  }

  Widget txtWidget() {
      return Txt(
        text: text,
        fontSize: fontSize,
        fontWeight: fontWeight,
        maxlines: maxLines ?? 1,
        useoverflow: true,
        color: _textColor,
        upperCaseFirst:upperCaseFirst,
      );
   }

   Widget iconWidget(){
    Widget child;
    if(icon is IconData) child = Icon(icon, color: _textColor, size: fontSize);
    if(icon is Widget) child = icon;
    if(showLoading) child = loadingCircle();
    return child;
   }



   Widget loadingCircle(){
    return Material(
     type: MaterialType.circle,
     color: outlined? Colors.transparent : buttonColor,
     elevation: 0,
     child: SizedBox(
        height: outlined?22:26,
        width: outlined?22:26,
        child: FittedBox(
          fit: BoxFit.scaleDown,
          child: CircularProgressIndicator(
            valueColor: AlwaysStoppedAnimation(_textColor),
          ),
       ),
      ),
    );
  }


  static void invalidAction(){
    print("Invalid Action");
  }

  

 


  bool get isIconButton => icon!=null;
  Color get _textColor => outlined? buttonColor : textColor;
  ButtonStyle get normalButtonStyle => TextButton.styleFrom(backgroundColor: buttonColor, shape: shape);
  ButtonStyle get outlinedButtonStyle => OutlinedButton.styleFrom(shadowColor: buttonColor, onSurface: buttonColor, primary: buttonColor, shape: shape);
  RoundedRectangleBorder get shape => RoundedRectangleBorder(borderRadius: BorderRadius.circular(radius ??6));
 
}