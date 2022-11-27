// ignore_for_file: public_member_api_docs, avoid_dynamic_calls

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
  final double? iconSize;
  final int? maxLines;
  final double? width;
  final FontWeight? fontWeight;
  final bool upperCaseFirst;
  final bool isBig;
  final double elevation;
  const Button({
    Key? key,
    this.isBig = false,
    this.fontSize,
    this.iconSize,
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
    this.elevation = 5.0,
  }) : super(key: key);

  @override
  _ButtonState createState() => _ButtonState();

  static Future<void> invalidAction() async {
    debugPrint('Invalid Action');
  }
}

class _ButtonState extends State<Button> {
  bool processing = false;
  bool processed = false;

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 350),
      height: widget.isBig ? 65 : 52,
      width: widget.width,
      padding: const EdgeInsets.all(8),
      margin:
          widget.isBig && !kIsWeb ? const EdgeInsets.symmetric(horizontal: 12, vertical: 16) : null,
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
    return ElevatedButton.icon(
      icon: iconWidget(),
      style: buttonStyle,
      label: txtWidget(),
      onPressed: onPressed,
    );
  }

  Widget normalButton() {
    return ElevatedButton(
      style: buttonStyle,
      onPressed: onPressed,
      child: txtWidget(),
    );
  }

  Widget txtWidget() {
    dynamic _finalText;
    if (processing) _finalText = widget.processingText;
    if (processed) _finalText = widget.ontaskCompletedText;
    _finalText ??= widget.text;

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
    final dynamic _icon = processed ? (widget.onTaskCompletedIcon ?? widget.icon) : widget.icon;
    if (_icon is IconData) {
      child = Icon(_icon, color: _textColor, size: widget.iconSize ?? widget.fontSize);
    }
    if (_icon is Widget) child = _icon;
    if (processing) child = Widgets.loadingCircle(backgroundColor: widget.buttonColor);
    return child!;
  }

  Future<void> onPressed() async {
    if (processing) {
      Widgets.showToast('Already processing...');
      return;
    } else {
      if (mounted) {
        setState(() {
          processing = true;
          processed = false;
        });
      }
      await Widgets.wait(100);
      try {
        await widget.onPressed();
      } catch (e) {
        Widgets.showToast('Error: $e');
      }
      if (mounted) {
        await Widgets.wait(100);
        if (mounted) {
          setState(() {
            processing = false;
            processed = true;
          });
        }
      }
    }
  }

  bool get isIconButton => widget.icon != null || processing == true;

  Color get _textColor => widget.textColor;

  Color get _darkenButtonColor =>
      HSLColor.fromColor(widget.buttonColor).withLightness(0.45).toColor();

  Color get _buttonColor => processing ? _darkenButtonColor : widget.buttonColor;

  ButtonStyle get buttonStyle => TextButton.styleFrom(
        backgroundColor: _buttonColor,
        shape: shape,
        shadowColor: widget.buttonColor,
        elevation: widget.elevation,
      );

  ButtonStyle get outlinedButtonStyle => OutlinedButton.styleFrom(
        shadowColor: _buttonColor,
        disabledForegroundColor: _buttonColor,
        foregroundColor: _buttonColor,
        shape: shape,
      );

  RoundedRectangleBorder get shape => RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(widget.radius ?? 6),
      );
}
