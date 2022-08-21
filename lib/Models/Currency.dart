import 'package:flutter/cupertino.dart';

class Currency {
  //I usually extend it to equatable class

  final String title;
  final String subTitle;
  final double percentage;
  final bool negative;
  final IconData icon;
  final Color borderColor;

  Currency(this.title, this.subTitle, this.percentage, this.negative, this.icon, this.borderColor); //optionally you can use an image as icon

}
