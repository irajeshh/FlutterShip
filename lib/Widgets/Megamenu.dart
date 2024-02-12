part of './Widgets.dart';

class Megamenu extends StatefulWidget {
  ///Primary widget to be shown permanently
  final Widget child;

  ///Widget which is to be shown inside the hovering sheet
  final Widget? menu;

  ///Height of the hovering sheet
  final double sheetHeight;

  ///Custom top padding to be used to show the sheet from the child
  final double? topPadding;

  ///Constructor
  const Megamenu({
    super.key,
    required this.menu,
    required this.child,
    this.sheetHeight = 300,
    this.topPadding,
  });

  @override
  State<Megamenu> createState() => _MegamenuState();
}

class _MegamenuState extends State<Megamenu> {
  ///Used to find the height of the [child] inorder to give some [padding]
  final GlobalKey childSizeKey = GlobalKey();
  OverlayEntry? _overlayEntry;

  ///To show the sheet below the child
  double topPadding = 0;

  @override
  Widget build(BuildContext context) {
    ///Permanent widget which is visible all the time regardless of hovering
    ///This widget has ablity to identify mouse hoverings.
    ///Once a hover entry is detected, it will use the [overlayPortalController]
    ///to show an [overlay]
    return MouseRegion(
      onEnter: showFn,
      child: Container(
        key: childSizeKey,
        child: widget.child,
      ),
    );
  }

  ///The sheet which is going to show the given cihld inside it.
  ///Even, there is no widget passed, this sheet will be shown over hovering and it will close when hovering is
  ///exited!.
  Widget hoveringArea(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(top: topPadding),
      alignment: Alignment.topCenter,
      child: Container(
        height: double.maxFinite,
        width: double.maxFinite,
        alignment: Alignment.topCenter,
        // color: shadowColor,
        child: Column(
          children: <Widget>[
            focusedArea(),
            unfocusedArea(),
          ],
        ),
      ),
    );
  }

  Widget focusedArea() {
    const Radius _r = Radius.circular(6);
    return Material(
      borderRadius: const BorderRadius.only(
        bottomLeft: _r,
        bottomRight: _r,
      ),
      child: SizedBox(
        height: widget.sheetHeight,
        width: double.maxFinite,
        child: MouseRegion(
          onExit: hideFn,
          child: widget.menu,
        ),
      ),
    );
  }

  ///Again we are wrapping with mouse detection to make sure when the mouse comes into this area,
//////we can hide the overlay even when missed by the above widget, this will save us!.
  Widget unfocusedArea() {
    return Expanded(
        child: MouseRegion(
      onEnter: hideFn,
      child: Container(
        height: double.maxFinite,
        // color: Colors.black.withOpacity(0.2),
      ),
    ));
  }

  ///Function which shows the sheet along with given child via overlay
  void showFn(_) {
    ///Making sure if an overlay is already showing, we are going to hide it first!
    hideFn(_);
    try {
      if (mounted) {
        setState(() {
          if (widget.topPadding == null) {
            final RenderBox? renderBox =
                (childSizeKey.currentContext!.findRenderObject()) as RenderBox?;
            topPadding = renderBox?.size.height ?? 100;
          } else {
            topPadding = widget.topPadding!;
          }

          _overlayEntry = OverlayEntry(builder: hoveringArea);
          Overlay.of(context).insert(_overlayEntry!);
        });
      }
    } catch (e) {
      print('Unable to show overlay!: $e');
    }
  }

  void hideFn(_) {
    if (mounted && _overlayEntry != null) {
      try {
        setState(() => _overlayEntry?.remove());
      } catch (e) {
        print('Error removing overlay: $e');
      }
    }
  }
}
