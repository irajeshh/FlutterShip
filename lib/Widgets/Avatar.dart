part of './Widgets.dart';
/*
This will not work, as we didn't connect this project to firebase.
Just copy paste or understand the concept and then, Implement on your firebase connected app.

*/

class Avatar extends StatefulWidget {
  final String? email;
  final bool? isBig;
  final bool? isLive;
  final bool? changePhoto;
  final bool square;
  final double? size;
  final bool isOnline;
  final double onlinePadding;
  const Avatar({
    Key? key,
    required this.email,
    this.isBig = false,
    this.isLive = false,
    this.changePhoto = false,
    this.square = false,
    this.isOnline = false,
    this.size = 45,
    this.onlinePadding = 4,
  }) : super(key: key);

  @override
  _AvatarState createState() => _AvatarState();
}

class _AvatarState extends State<Avatar> {
  final FirebaseStorage storage = FirebaseStorage.instance;
  //final ImagePicker imagePicker = ImagePicker();

  bool changing = false;
  final AsyncMemoizer memoizer = AsyncMemoizer();
  String email = 'guestEmail';
  bool isBig = false;
  bool isLive = false;
  bool changePhoto = false;
  double size = 45;
  bool isOnline = false;

  @override
  Widget build(BuildContext context) {
    size = widget.size ?? (isBig ? MediaQuery.of(context).size.width / 2 : 45);
    email = widget.email ?? 'guestEmail';
    isBig = widget.isBig ?? false;
    isLive = widget.isLive ?? false;
    changePhoto = widget.changePhoto ?? false;
    isOnline = widget.isOnline;
    if (!email.contains("@")) return backgroundContainer(null);
    return FutureBuilder(
        future: isLive ? getImgUrl() : runner(),
        builder: (c, AsyncSnapshot<String?> snap) {
          String? url = snap.data;
          return backgroundContainer(url);
        });
  }

  Widget backgroundContainer(String?  imgUrl) {
    return Container(
      alignment: Alignment.center,
      width: size,
      height: size,
      decoration: boxDecoration(),
      child: stack(imgUrl),
    );
  }

  Widget stack(imgUrl) {
    return Stack(
      clipBehavior: Clip.none,
      alignment: Alignment.topRight,
      children: [
        imgWidget(imgUrl),
        if (changing) CircularProgressIndicator(),
        if (isOnline) greenLight(),
      ],
    );
  }

  Widget greenLight() {
    return Padding(
      padding: EdgeInsets.all(widget.onlinePadding),
      child: Icon(Icons.brightness_1, color: Colors.green, size: 12),
    );
  }

  Widget imgWidget(String? imgUrl) {
    return Inkk(
      radius: widget.square ? 8 : 360,
      child: imgUrl == null ? personIcon() : cachedNetworkImage(imgUrl),
      onTap: onTap,
    );
  }

  Widget personIcon() {
    return Icon(Icons.person, size: size, color: Colors.white);
  }

  Widget cachedNetworkImage(String imgUrl) {
    return CachedNetworkImage(
      imageUrl: imgUrl,
      imageBuilder: (context, imageProvider) => Container(
        decoration: BoxDecoration(
          color: Colors.purple.shade100,
          borderRadius: BorderRadius.circular(widget.square ? 8 : 360),
          image: DecorationImage(
            image: imageProvider,
            fit: BoxFit.fitHeight,
          ),
        ),
      ),
      placeholder: (context, url) => holder(),
      errorWidget: (context, url, error) => holder(),
    );
  }

  Widget holder() {
    return Container(decoration: boxDecoration());
  }

  BoxDecoration boxDecoration() {
    return BoxDecoration(
      color: Colors.deepPurple,
      borderRadius: BorderRadius.circular(widget.square ? 8 : 360),
    );
  }

  Future<String> runner() async {
    return await this.memoizer.runOnce(getImgUrl);
  }

  Future<String?> getImgUrl() async {
    return await ImgRepo.getImgUrl('avatars/${widget.email}/avatar.jpg');
  }

  void onTap() async {
    if (changePhoto) {
      File? profileFile = await ImgRepo.pick();
      if (profileFile != null) {
        setState(() => changing = true);
        bool uploaded = await ImgRepo.uploadProfilePhoto(profileFile);
        if (uploaded) setState(() => changing = false);
      } else {
        print("Cancelled");
        //  Widgets.instance.showToast("Cancelled!", context);
      }
    }
  }
}
