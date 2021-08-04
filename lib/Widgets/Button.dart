part of './Widgets.dart';


class Button extends StatefulWidget {
  final dynamic icon;
  final dynamic onTaskCompletedIcon;
  final dynamic text;
  final String processingText;
  final String ontaskCompletedText; 
  final Color textColor;
  final double radius;
  final Function onPressed;
  final Color buttonColor;
  final double fontSize;
  final int maxLines;
  final double height;
  final double width;
  final FontWeight fontWeight;
  final bool upperCaseFirst;
  final bool processing;
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
    this.processing=false,
    this.outlined = false,
    this.processingText,
    this.ontaskCompletedText,
    this.onTaskCompletedIcon,
  }) : super(key: key);

  @override
  _ButtonState createState() => _ButtonState();

  static void invalidAction()async{
    print("Invalid Action");
  }
}

class _ButtonState extends State<Button> {
  bool taskCompleted = false;

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: Duration(milliseconds:350),
      height: widget.height ?? 52,
      width: widget.width,
      padding: EdgeInsets.all(8),
      child: finalButton(),
    );
  }

 Widget finalButton(){
   if(isIconButton){
     return widget.outlined? outlinedIconButton() : iconButton();
   }else{
     return widget.outlined? outlinedNormalButton():normalButton();
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
    dynamic _finalText;
    if(widget.processing) _finalText = widget.processingText;
    if(taskCompleted) _finalText = widget.ontaskCompletedText;
    if(_finalText==null) _finalText = widget.text;
    
      return Txt(
        text: _finalText,
        fontSize: widget.fontSize,
        fontWeight: widget.fontWeight,
        maxlines: widget.maxLines ?? 1,
        useoverflow: true,
        color: _textColor,
        upperCaseFirst:widget.upperCaseFirst,
      );
   }

   Widget iconWidget(){
    Widget child;
    dynamic _icon = taskCompleted? (widget.onTaskCompletedIcon ?? widget.icon) : widget.icon;
    if(_icon is IconData) child = Icon(_icon, color: _textColor, size: widget.fontSize);
    if(_icon is Widget) child = _icon;
    if(widget.processing) child = loadingCircle();
    return child;
   }

   Widget loadingCircle(){
    return Material(
     type: MaterialType.circle,
     color: widget.outlined? Colors.transparent : _buttonColor,
     elevation: 0,
     child: SizedBox(
        height: widget.outlined?22:26,
        width: widget.outlined?22:26,
        child: FittedBox(
          fit: BoxFit.scaleDown,
          child: CircularProgressIndicator(
            strokeWidth: 5,
            valueColor: AlwaysStoppedAnimation(_textColor),
          ),
       ),
      ),
    );
  }




  void onPressed()async{  
    setState(()=>taskCompleted=false);
    await widget.onPressed();
    setState(()=>taskCompleted=true);
    await Future.delayed(Duration(seconds:3));
    setState(()=>taskCompleted=false);
  }



  bool get isIconButton => widget.icon!=null;

  Color get _textColor => widget.outlined? widget.buttonColor : widget.textColor;

  Color get _darkenButtonColor => HSLColor.fromColor(widget.buttonColor).withLightness(0.45).toColor();

  Color get _buttonColor => widget.processing? _darkenButtonColor : widget.buttonColor;

  ButtonStyle get normalButtonStyle => TextButton.styleFrom(backgroundColor: _buttonColor, shape: shape);

  ButtonStyle get outlinedButtonStyle => OutlinedButton.styleFrom(shadowColor: _buttonColor, onSurface: _buttonColor, primary: _buttonColor, shape: shape);

  RoundedRectangleBorder get shape => RoundedRectangleBorder(borderRadius: BorderRadius.circular(widget.radius ??6));
}