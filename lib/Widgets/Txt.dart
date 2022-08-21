part of 'Widgets.dart';

class Txt extends StatefulWidget {
  final FontStyle? style;
  final FontWeight? fontWeight;
  final int? maxLines;
  final double? fontSize;
  final Color? color;
  final TextAlign? textAlign;
  final bool useoverflow;
  final bool upperCaseFirst;
  final bool quoted;
  final bool useFiler;
  final bool underline;
  final bool fullUpperCase;
  final dynamic text;
  final String? family;
  final bool toRupees;
  final bool toTimeAgo;
  final String? prefix;
  final bool strikeThrough;

  const Txt({
    Key? key,
    this.style,
    this.fontWeight,
    this.maxLines,
    this.fontSize,
    this.color,
    this.textAlign,
    this.useoverflow = false,
    this.upperCaseFirst = false,
    this.quoted = false,
    this.useFiler = false,
    this.underline = false,
    this.fullUpperCase = false,
    required this.text,
    this.family,
    this.prefix,
    this.toRupees = false,
    this.toTimeAgo = false,
    this.strikeThrough = false,
  }) : super(key: key);

  @override
  _TxtState createState() => _TxtState();
}

class _TxtState extends State<Txt> {
  String finalText = "";

  /// finalText = strings.english;

  @override
  Widget build(BuildContext context) {
//Any
    finalText = widget.text.toString();
//String
    if (widget.text is String) finalText = widget.text ?? "Error";
//Numbers
    if ((widget.text is double || widget.text is int)) {
      if (widget.toRupees)
        finalText = "${NumberFormat.simpleCurrency().format(widget.text)}"
            .replaceAll('\$', '₹')
            .replaceAll(".00", "");
      if (widget.toTimeAgo) finalText = Widgets.timeAgo(widget.text, prefix: widget.prefix);
      if (widget.toRupees == false && widget.toTimeAgo == false) finalText = widget.text.toString();
    }

    if (widget.upperCaseFirst && finalText.length > 1)
      finalText =
          "${finalText[0].toUpperCase()}${finalText.substring(1, finalText.length).toLowerCase()}";
    if (widget.fullUpperCase) finalText = finalText.toUpperCase();
    if (widget.useFiler)
      finalText = finalText
          .replaceAll("*", "")
          .replaceAll("_", "")
          .replaceAll("-", "")
          .replaceAll("#", "")
          .replaceAll("\n", "")
          .replaceAll("!", "")
          .replaceAll('[', '')
          .replaceAll(']', '');
    if (widget.quoted) finalText = "❝$finalText❞";

    return Text((finalText).toString(),
        overflow: widget.useoverflow ? TextOverflow.ellipsis : null,
        textAlign: widget.textAlign,
        maxLines: widget.maxLines,
        textScaleFactor: 1,
        style: TextStyle(
          decoration: widget.underline
              ? TextDecoration.underline
              : (widget.strikeThrough ? TextDecoration.lineThrough : null),
          color: widget.color,
          fontSize: widget.fontSize,
          fontWeight: widget.fontWeight,
          fontStyle: widget.style,
          fontFamily: widget.family,
        ));
  }
}
