part of './Widgets.dart';

///A simple card widget with dual layers,
///that can be customized as per your wish;
///
///The card supports both [Light] & [Dark] modes beautifully, but
///you need to choose the colors wisely!

class DoubleCard extends StatelessWidget {
  ///Custom primary color of the widget
  final Color color;

  ///Constructor
  const DoubleCard({Key? key, this.color = Colorz.doubleCardBlue}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: EdgeInsets.symmetric(
          vertical: 12,
          horizontal: 0,
        ),
        child: Card(
          elevation: 8,
          shadowColor: color,
          child: Inkk(
              spalshColor: color,
              onTap: () {
                debugPrint("Card is pressed");
              },
              child: Column(
                children: <Widget>[
                  ///Here we split the card into two segments:
                  top(context),
                  bottom(),
                ],
              )),
        ));
  }

  ///Top layer of the card
  Widget top(BuildContext context) {
    final Color backgroundColor = color;
    return DecoratedBox(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(8),
          topRight: Radius.circular(8),
        ),
        color: backgroundColor.withOpacity(0.1),
      ),
      child: ListTile(
        // leading: null,///You can use if you want;
        title: Txt(
          text: Widgets.toDateTime(DateTime.now().microsecondsSinceEpoch),
          fontWeight: FontWeight.bold,
        ),
        subtitle: Txt(text: "Reminded by John (Brother)"),
        trailing: CircleAvatar(
          child: Icon(
            Icons.alarm,
            color: Colors.white,
          ),
          backgroundColor: color,
        ),
      ),
    );
  }

  ///Bottom layer of the card
  Widget bottom() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 2.5),
      decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(8),
            bottomRight: Radius.circular(8),
          )),
      child: ListTile(
        title: Txt(
          text: 'Movie booking',
          color: Colors.white,
          fontWeight: FontWeight.bold,
        ),
        subtitle: Txt(
          text: 'We need to go to the movie. Try not to forget it.',
          color: Colors.white,
        ),
      ),
    );
  }
}
