part of './Widgets.dart';

///An Expansion style [ListTile] card which will look much better than
///traditional ExpansionTile, with some customization options
class Expandile extends StatefulWidget {
  ///Primary color of the [title], card, arrow widgets;
  final Color primaryColor;

  ///Custom text color on valid values;
  final Color? validTextColor;

  ///Title widget to be shown
  final String title;

  ///Optional description widget to be shown
  final String? description;

  ///Children to be shown when expanded
  final List<Widget> children;

  ///OPtional static widget to be shown on the footer even on closed state
  final Widget? footer;

  ///To automatically hide the expandile based on requirement
  final bool autoHide;

  ///Time to auto hide the expandile widget in [milliseconds]
  final int autoHideDuration;

  ///Function to be executed when tapping the [ListTile]
  final VoidCallback? onTap;

  ///Optional [Widget] or [IconData] to be used as [Leading]
  final dynamic leading;

  ///Card elevation value
  final double elevation;

  ///Padding to be given between [ListTile] children
  final EdgeInsetsGeometry? contentPadding;

  ///To expand the widget initially
  final bool initialyExpanded;

  ///MaxLines to control the description length
  final int? maxDescriptionLines;

  ///If the content or function is executed and the selection is valid,
  ///so we need to make the [ListTile] as currently selected/completed/done.
  final bool isValid;

  ///Outter padding of the widget
  final EdgeInsets? padding;

  const Expandile(
      {Key? key,
      required this.primaryColor,
      this.validTextColor,
      required this.title,
      this.description,
      this.children = const <Widget>[],
      this.footer,
      this.autoHide = false,
      this.autoHideDuration = 5000,

      ///5 Seconds
      this.onTap,
      this.leading,
      this.elevation = 0.0,
      this.contentPadding,
      this.initialyExpanded = false,
      this.maxDescriptionLines,
      this.isValid = false,
      this.padding})
      : super(key: key);

  @override
  State<Expandile> createState() => _ExpandileState();
}

class _ExpandileState extends State<Expandile> {
  bool expanded = false;

  Color get cardColor => widget.primaryColor.withOpacity(widget.isValid ? 1 : 0.1);
  Color get textColor =>
      widget.isValid ? (widget.validTextColor ?? Colors.white) : widget.primaryColor;

  @override
  void initState() {
    expanded = widget.initialyExpanded;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: widget.padding ?? const EdgeInsets.symmetric(vertical: 12),
      child: Card(
        color: cardColor,
        elevation: widget.isValid ? widget.elevation : 0.0,
        child: Column(
          children: <Widget>[
            infoTile(),
            childrenWidgets(),
            footerWidget(),
          ],
        ),
      ),
    );
  }

  ///Where the basic information is shown, even the widget is not expanded
  Widget infoTile() {
    return ListTile(
      contentPadding: widget.contentPadding,
      onTap: widget.onTap ?? changeExpansionFn,
      leading: _leading(),
      title: _infoTitle(),
      subtitle: _infoSubtitle(),
      trailing: _expansionButton(),
    );
  }

  Widget? _leading() {
    if (widget.leading is Widget) return widget.leading as Widget;
    if (widget.leading is IconData) {
      final Icon icon = Icon(
        widget.leading as IconData,
        color: textColor,
      );
      return widget.description == null ? icon : IconButton(icon: icon);
    }
    return null;
  }

  Widget _infoTitle() {
    return Txt(
      text: widget.title,
      fontWeight: FontWeight.bold,
      color: textColor,
      maxLines: 1,
      fontSize: 16,
    );
  }

  Widget? _infoSubtitle() {
    if (widget.description == null) return null;
    return Txt(
      text: widget.description,
      // useoverflow: true,
      color: textColor,
      maxLines: widget.maxDescriptionLines ?? 3,
    );
  }

  Widget _expansionButton() {
    return IconButton(
      icon: Widgets.arrow(
        angle: expanded? 270 : 90,
        color: textColor,
      ),
      onPressed: changeExpansionFn,
    );
  }

  Widget childrenWidgets() {
    return CrossFade(
      useCenter: false,
      show: expanded,
      child: ListView(
        shrinkWrap: true,
        children: widget.children,
      ),
    );
  }

  Widget footerWidget() {
    if (widget.footer == null) return Container();
    return widget.footer!;
  }

  ///Function to change the expansion state automatically
  Future<void> changeExpansionFn() async {
    if (widget.autoHide) {
      ///If already expanded, then don't allow to expand again!
      if (expanded) return;

      if (mounted) setState(() => expanded = true);
      await Widgets.wait(widget.autoHideDuration);
      if (mounted) setState(() => expanded = false);
    } else {
      if (mounted) setState(() => expanded = !expanded);
    }
  }
}
