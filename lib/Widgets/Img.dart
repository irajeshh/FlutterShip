part of './Widgets.dart';

class Img extends StatefulWidget {
  final String imgUrl;
  final double? height;
  final double? width;
  final Widget? placeHolder;
  final Widget? errorWidget;
  final BoxFit? fit;
  final Alignment? alignment;
  final VoidCallback? onTap;
  final Widget? child;
  final double? outterPadding;
  final double radius;
  final Color? imgColor;
  final double? elevation;
  final bool enableRippleEffect;
  const Img({
    Key? key,
    required this.imgUrl,
    this.height,
    this.width,
    this.placeHolder,
    this.errorWidget,
    this.fit,
    this.alignment,
    this.onTap,
    this.child,
    this.outterPadding,
    this.radius = 8,
    this.imgColor,
    this.elevation,
    this.enableRippleEffect = true,
  }) : super(key: key);
  @override
  _ImgState createState() => _ImgState();
}

class _ImgState extends State<Img> with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context);
    BorderRadius borderRadius = BorderRadius.circular(widget.radius,);
    return Inkk(
      onTap: widget.onTap ?? viewImageFn,
      child: Container(
        height: widget.height,
        width: widget.width,
        padding: EdgeInsets.all(widget.outterPadding ?? 0),
        child: Material(
            elevation: widget.elevation ?? 1.5,
            borderRadius: borderRadius,
            clipBehavior: Clip.antiAlias,
            color: widget.imgColor,
            child: imgWidget()),
      ),
    );
  }

  Widget imgWidget() {
    Widget _imgWidget = CachedNetworkImage(
      imageUrl: widget.imgUrl,
      fit: widget.fit ?? BoxFit.fill,
      height: widget.height,
      width: widget.width,
      progressIndicatorBuilder: placeholder,
      errorWidget: errorWidget,
    );
    return Stack(
      clipBehavior: Clip.antiAlias,
      alignment: widget.alignment ?? Alignment.center,
      children: <Widget>[
        widget.enableRippleEffect
            ? Inkk(
                onTap: widget.onTap ?? () {},
                radius: widget.radius,
                child: _imgWidget,
              )
            : _imgWidget,
        if (widget.child != null) widget.child!,
      ],
    );
  }

  Widget placeholder(c, s, e) {
    return widget.placeHolder ?? background(false);
  }

  Widget errorWidget(c, s, e) {
    return widget.errorWidget ?? background(true);
  }

  Widget background(bool error) {
    return Container(
      height: widget.height,
      width: widget.width,
      child: error ? Icon(Icons.error, size: 100) : CircularProgressIndicator(),
    );
  }

  void viewImageFn() {
    Widgets.push(
        Scaffold(
          backgroundColor: Colors.black,
          body: Center(
            child: CachedNetworkImage(
              imageUrl: widget.imgUrl,
              width: double.maxFinite,
              placeholder: (
                c,
                s,
              ) =>
                  placeholder(c, s, s),
              errorWidget: errorWidget,
            ),
          ),
        ),
        context);
  }
}
