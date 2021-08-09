import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:async/async.dart';
import 'package:fluttership/Repos/Img.dart';

part './Txt.dart';
part './ColorTile.dart';
part './Scroller.dart';
part './CrossFade.dart';
part './Button.dart';
part './Inkk.dart';
part './Img.dart';
part './Avatar.dart';

class FadePageRoute extends PageRouteBuilder {
  final Widget widget;
  FadePageRoute({this.widget}): super(
    pageBuilder: (BuildContext context, Animation<double> animation,
                Animation<double> secondaryAnimation) {
              return widget;
            },
            transitionDuration: Duration(milliseconds:300),
            transitionsBuilder: ((context,
                animation,
               secondaryAnimation,
              child) {
              return SlideTransition(
                  transformHitTests: false,
                  position:
                      Tween<Offset>(begin: Offset(0.0, 1.0), end: Offset.zero)
                          .animate(animation),
                  child: new SlideTransition(
                      position: new Tween<Offset>(
                              begin: Offset.zero, end: const Offset(0.0, -1.0))
                          .animate(secondaryAnimation),
                      child: child));
            }));
}


class Widgets {
  Widgets._privateConstructor();
  static final Widgets _instance = Widgets._privateConstructor();
  static Widgets get instance => _instance;


 static Widget arrow({Color color}){
   color = color?? Colors.grey.shade200;
    return Container(
        child: Icon(Icons.chevron_right,size:18,color:color),
        decoration: BoxDecoration(
          color: color.withOpacity(0.15),
          shape: BoxShape.circle,
        ),
      );
  }

     void push(Widget child,BuildContext context) {
    if(child!=null){
      Navigator.push(context, FadePageRoute(widget: child));
    }else{
      // showToast("No destination page found", context);
    }
  }


static String toDateTime(int createdAt) {
     return '${toDate(createdAt)} @ ${toTime(createdAt)}';
}

  static  String toDate(int createdAt) {
    DateTime date = DateTime.fromMillisecondsSinceEpoch(createdAt);
    int day = date.day;
    int _month = date.month;
    String month = toMonth(_month);
    int _year = date.year;
    String year = _year == DateTime.now().year? '':'$_year'.substring(2,4);
    return '$day $month $year';
  }

  


    static String toTime(int createdAt) {
    DateTime date = DateTime.fromMillisecondsSinceEpoch(createdAt);
    int hour = date.hour > 12 ? (date.hour - 12) : date.hour;
    String minutes = date.minute < 10 ? '0${date.minute}' : '${date.minute}';
    String amPm = date.hour >= 12 ? "PM" : "AM";
    return '$hour:$minutes $amPm';
  }


  static  String toMonth(int month){
   return month>0 ? months[month-1] : '$month';
  }
      static const List<String>months = [
        'Jan',
        'Feb',
        'Mar',
        'Apr',
        'May',
        'Jun',
        'Jul',
        'Aug',
        'Sep',
        'Oct',
        'Nov',
        'Dec',
      ];
      

}