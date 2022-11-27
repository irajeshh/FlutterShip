// ignore_for_file: public_member_api_docs

part of 'Widgets.dart';

class ViewImgPage extends StatelessWidget {
  final String url;
  const ViewImgPage({ Key? key, required this.url}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar(),
      body: body(), 
      backgroundColor: Colors.black,
    );
  }

  AppBar appBar(){
    return AppBar(
      title: const Txt(
        text: 'View image',
        color: Colors.white,
      ),
      backgroundColor: Colors.black,
    );
  }

  Widget body(){
    return Center(
      child: Stack(
        alignment: Alignment.center,
        children: <Widget>[
          const Loader(),
          imgContainer(),
        ],
      ),
    );
  }

  Widget imgContainer(){
    return Container(
      width: double.maxFinite,
        decoration: BoxDecoration(
          image: DecorationImage(
           image: NetworkImage(url),
           fit: BoxFit.fitWidth,
          ),
        ),
      );
  }
}
