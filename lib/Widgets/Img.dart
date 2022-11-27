// ignore_for_file: public_member_api_docs, avoid_dynamic_calls

part of 'Widgets.dart';

class Img extends StatefulWidget {
  final String? imgUrl;
  final double? height;
  final double? width;
  final Widget? placeHolder;
  final Widget? errorWidget;
  final BoxFit? fit;
  final Alignment? alignment;
  final Function? onTap;
  final Widget? child;
  final double? outterPadding;
  final double? radius;
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
    this.radius,
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
    final BorderRadius borderRadius = BorderRadius.circular(widget.radius ?? 8);
    return Inkk(
      onTap: onTap,
      radius: widget.radius,
      child: Container(
        height: widget.height,
        width: widget.width,
        padding: EdgeInsets.all(widget.outterPadding ?? 0),
        child: Material(
          elevation: widget.elevation ?? 1.5,
          borderRadius: borderRadius,
          clipBehavior: Clip.antiAlias,
          color: widget.imgColor,
          child: widget.imgUrl == null ? null : imgWidget(),
        ),
      ),
    );
  }

  Widget imgWidget() {
    final Widget _imgWidget = CachedNetworkImage(
      imageUrl: widget.imgUrl!,
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
        if (widget.enableRippleEffect) Inkk(
                onTap: onTap,
                radius: widget.radius,
                child: _imgWidget,
              ) else _imgWidget,
        if (widget.child != null) widget.child!,
      ],
    );
  }

  Widget placeholder(BuildContext c, String s, DownloadProgress d) {
    return widget.placeHolder ?? background(error: false);
  }

  Widget errorWidget(BuildContext c, String s, dynamic e) {
    return widget.errorWidget ?? background(error: true);
  }

  Widget background({required bool error}) {
    return SizedBox(
      height: widget.height,
      width: widget.width,
      child: error
          ? const Icon(Icons.photo, size: 100)
          : Shimmer(
              height: widget.height,
              width: widget.width,
              verticalPadding: 0,
              horizontalPadding: 0,
              radius: widget.radius??8.0,),
    );
  }

  void onTap() {
    debugPrint(widget.imgUrl);
    if (widget.onTap != null) {
      widget.onTap!();
    } else {
      Widgets.push(ViewImgPage(url: widget.imgUrl!), context,);
    }
  }
}
