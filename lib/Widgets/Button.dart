part of 'Widgets.dart';

class Button extends StatefulWidget {
  final dynamic icon;
  final dynamic onTaskCompletedIcon;
  final dynamic text;
  final String? processingText;
  final String? ontaskCompletedText;
  final Color textColor;
  final double? radius;
  final Function onPressed;
  final Color buttonColor;
  final double? fontSize;
  final int? maxLines;
  final double? width;
  final FontWeight? fontWeight;
  final bool upperCaseFirst;
  final bool isBig;
  const Button({
    Key? key,
    this.isBig = false,
    this.fontSize,
    this.icon,
    this.text,
    this.textColor = Colors.white,
    this.radius,
    this.onPressed = invalidAction,
    this.buttonColor = Colorz.primaryColor,
    this.maxLines,
    this.width,
    this.fontWeight,
    this.upperCaseFirst = false,
    this.processingText,
    this.ontaskCompletedText,
    this.onTaskCompletedIcon,
  }) : super(key: key);

  @override
  _ButtonState createState() => _ButtonState();

  static void invalidAction() async {
    print("Invalid Action");
  }
}

class _ButtonState extends State<Button> {
  bool processing = false;
  bool processed = false;

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: Duration(milliseconds: 350),
      height: widget.isBig ? 65 : 52,
      width: widget.width,
      padding: EdgeInsets.all(8),
      child: finalButton(),
    );
  }

  Widget finalButton() {
    if (isIconButton) {
      return iconButton();
    } else {
      return normalButton();
    }
  }

  Widget iconButton() {
    return TextButton.icon(
      icon: iconWidget(),
      style: normalButtonStyle,
      label: txtWidget(),
      onPressed: onPressed,
    );
  }

  Widget normalButton() {
    return TextButton(
      child: txtWidget(),
      style: normalButtonStyle,
      onPressed: onPressed,
    );
  }

  Widget txtWidget() {
    dynamic _finalText;
    if (processing) _finalText = widget.processingText;
    if (processed) _finalText = widget.ontaskCompletedText;
    if (_finalText == null) _finalText = widget.text;

    return Txt(
      text: _finalText,
      fontSize: widget.isBig ? 18 : widget.fontSize,
      fontWeight: widget.fontWeight,
      maxLines: widget.maxLines ?? 1,
      useoverflow: true,
      color: _textColor,
      upperCaseFirst: widget.upperCaseFirst,
    );
  }

  Widget iconWidget() {
    Widget? child;
    dynamic _icon = processed ? (widget.onTaskCompletedIcon ?? widget.icon) : widget.icon;
    if (_icon is IconData) child = Icon(_icon, color: _textColor, size: widget.fontSize);
    if (_icon is Widget) child = _icon;
    if (processing) child = Widgets.loadingCircle(color: _buttonColor);
    return child!;
  }

  void onPressed() async {
    if (mounted)
      setState(() {
        processing = true;
        processed = false;
      });
    await Widgets.wait(100);
    try {
      await widget.onPressed();
    } catch (e) {
      // Widgets.showToast("Error: $e");
    }
    if (mounted) {
      await Widgets.wait(100);
      if (mounted)
        setState(() {
          processing = false;
          processed = true;
        });
    }
  }

  bool get isIconButton => widget.icon != null || processing == true;

  Color get _textColor => widget.textColor;

  Color get _darkenButtonColor =>
      HSLColor.fromColor(widget.buttonColor).withLightness(0.45).toColor();

  Color get _buttonColor => processing ? _darkenButtonColor : widget.buttonColor;

  ButtonStyle get normalButtonStyle =>
      TextButton.styleFrom(backgroundColor: _buttonColor, shape: shape);

  ButtonStyle get outlinedButtonStyle => OutlinedButton.styleFrom(
      shadowColor: _buttonColor, onSurface: _buttonColor, primary: _buttonColor, shape: shape);

  RoundedRectangleBorder get shape =>
      RoundedRectangleBorder(borderRadius: BorderRadius.circular(widget.radius ?? 6));
}
