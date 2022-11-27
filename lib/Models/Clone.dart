import 'package:flutter/cupertino.dart';

///A simple model which represents details about a clone/designn
class Clone {
  ///Name of the clonned page
  final String title;

  ///Extra details about the design
  final String description;

  ///Page to be opened
  final Widget page;

  ///Color to show the icon
  final Color color;

  ///Icon of the clone to represent the design
  final IconData icon;

  ///Constructor
  const Clone(
      {required this.page,
      required this.color,
      required this.icon,
      required this.title,
      required this.description});
}
