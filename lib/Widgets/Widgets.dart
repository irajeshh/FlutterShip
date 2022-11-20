import 'dart:math' as math;
import 'package:cached_network_image/cached_network_image.dart';
// import 'package:firebase_storage/firebase_storage.dart';
// import 'package:fluttership/Models/IconLabel.dart';
// import 'package:fluttership/Models/Logg.dart';
// import 'package:fluttership/Models/RichString.dart';
// import 'package:fluttership/Models/SelectionStep.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
// import 'package:fluttership/Repos/Img.dart';
import 'package:fluttership/Constants/Constants.dart';
import 'package:intl/intl.dart';

part './Loader.dart';
part './Txt.dart';
part './Scroller.dart';
part './Img.dart';
part './Inkk.dart';
part './Avatar.dart';
part './CrossFade.dart';
part './ColorTile.dart';
part './Button.dart';
part './Expandile.dart';
part './DoubleCard.dart';

@Deprecated('Use Widgets.instance')
class Common {
  Common._privateConstructor();
  static final Common _instance = Common._privateConstructor();
  static Common get instance => _instance;
}

class FadePageRoute extends PageRouteBuilder {
  final Widget widget;
  FadePageRoute({required this.widget})
      : super(
            pageBuilder: (BuildContext context, Animation<double> animation,
                Animation<double> secondaryAnimation) {
              return widget;
            },
            transitionDuration: Duration(milliseconds: 300),
            transitionsBuilder: ((context, animation, secondaryAnimation, child) {
              return SlideTransition(
                  transformHitTests: false,
                  position:
                      Tween<Offset>(begin: Offset(0.0, 1.0), end: Offset.zero).animate(animation),
                  child: new SlideTransition(
                      position: new Tween<Offset>(begin: Offset.zero, end: const Offset(0.0, -1.0))
                          .animate(secondaryAnimation),
                      child: child));
            }));
}

class Widgets {
  Widgets._privateConstructor();
  static final Widgets _instance = Widgets._privateConstructor();
  static Widgets get instance => _instance;

  static String avatar(String phoneNumberOrRemoteKey) {
    String fileName = phoneNumberOrRemoteKey.replaceAll("+", "%2B");
    return "https://firebasestorage.googleapis.com/v0/b/service-ad14a.appspot.com/o/avatars%2F$fileName.jpg?alt=media";
  }

  static Widget loadingCircle({Color? color, double size = 26}) {
    return Material(
      type: MaterialType.circle,
      color: color,
      elevation: 0,
      child: SizedBox(
        height: size,
        width: size,
        child: FittedBox(
          fit: BoxFit.scaleDown,
          child: CircularProgressIndicator(
            strokeWidth: 5,
            valueColor: AlwaysStoppedAnimation(Colors.white),
          ),
        ),
      ),
    );
  }

  ///This will return the darken color of the given value
  static Color darkenColor(Color color, double value) =>
      HSLColor.fromColor(color).withLightness(value).toColor();

  static Txt subtitle(BuildContext context, String text,
      {TextAlign? textAlign, double? fontSize = 12}) {
    return Txt(text: text, textAlign: textAlign, fontSize: fontSize, color: subtitleColor(context));
  }

  static Color subtitleColor(BuildContext context) {
    return Theme.of(context).textTheme.caption!.color!;
  }

  static const Duration duration = Duration(milliseconds: 350);
  static const Duration duration1Sec = Duration(seconds: 1);
  static const Duration duration2Sec = Duration(seconds:2);
  static const Duration duration3Sec = Duration(seconds:3);

  static const Curve curve = Curves.easeIn;

  static bool debugging = kDebugMode;
  static bool debugMode = kDebugMode;

  static List<String> generateTags(List sentences) {
    List<String> _tags = [];
    sentences.forEach((sentence) {
      if (sentence != null) {
        List words = '$sentence'.toLowerCase().split(' ');
        words.forEach((word) {
          if (_tags.contains(word) == false) _tags.add(word);
        });
      }
    });
    return _tags
      ..sort((b, a) => a.length.compareTo(b.length))
      ..removeWhere((element) => element.length < 3);
  }

  static Widget boldHeading(String string, {double? left}) {
    return Container(
      padding: EdgeInsets.only(top: 18, bottom: 3, left: left ?? 8),
      alignment: Alignment.centerLeft,
      child: Txt(
        text: string,
        fontWeight: FontWeight.bold,
        textAlign: TextAlign.start,
        fontSize: 16,
      ),
    );
  }

  ///An [Ios] style tiny arrow widget, which can be used on [ListTile] widgets with customizations
  static Widget arrow({Color? color, bool back = false, double angle = 90}) {
    final Color _color = color ?? Colors.grey.shade200;

    return DecoratedBox(
      decoration: BoxDecoration(
        color: _color.withOpacity(0.15),
        shape: BoxShape.circle,
      ),
      child: Transform.rotate(
        angle: angle * math.pi / 180,
        child: Icon(
          back ? Icons.chevron_left : Icons.chevron_right,
          size: 18,
          color: _color,
        ),
      ),
    );
  }

  static List<String> generateListString(List? list) {
    if (list == null) return [];
    return List<String>.generate((list).length, (index) => "${list[index]}");
  }

  // static List<Logg> generateLogs(List? list) {
  //   if (list == null) return [];
  //   return List<Logg>.generate((list).length, (index) => Logg.fromJson(list[index]));
  // }

  static String get today => "${DateTime.now().year}-${DateTime.now().month}-${DateTime.now().day}";

  // static Future<bool?> call(String number) async {
  // return await FlutterPhoneDirectCaller.callNumber(number);
  // }

  // static Future<void> sendSMS(String phoneNumber, {required String text}) async {
  //   String url = 'sms:$phoneNumber?body=$text';
  //   await launchurl(url);
  // }

  static Widget deleted() {
    return Center(
      child: Txt(
        fontSize: 16,
        text: "Deleted",
        color: Colors.grey,
        fontWeight: FontWeight.bold,
        textAlign: TextAlign.center,
      ),
    );
  }

  // static RichTxt staffLabel(StaffType type, {String? prefix, int? time}) {
  //   return RichTxt(maxLines: 1, richStrings: [
  //     RichString(_staffTypeLabel(type)),
  //     if (prefix != null) RichString(prefix, color: Colors.grey),
  //     if (time != null) RichString(ago(time), color: Colors.grey),
  //   ]);
  // }

  // static Widget _staffTypeLabel(StaffType type) {
  //   return Container(
  //       child: Txt(
  //         text: type.viewer,
  //         fontSize: 8,
  //         color: Colors.white,
  //       ),
  //       padding: EdgeInsets.all(2),
  //       decoration: BoxDecoration(
  //         color: type.color,
  //         borderRadius: BorderRadius.circular(4),
  //       ));
  // }

  static String ago(int millisecondsSinceEpoch, {bool numericDates = true}) {
    DateTime dateTime = DateTime.fromMillisecondsSinceEpoch(millisecondsSinceEpoch);
    final difference = DateTime.now().difference(dateTime);

    if (difference.inDays > 8) {
      return dateTime.toString().substring(0, 10);
    } else if ((difference.inDays / 7).floor() >= 1) {
      return (numericDates) ? '1 week ago' : 'Last week';
    } else if (difference.inDays >= 2) {
      return '${difference.inDays} days ago';
    } else if (difference.inDays >= 1) {
      return (numericDates) ? '1 day ago' : 'Yesterday';
    } else if (difference.inHours >= 2) {
      return '${difference.inHours} hours ago';
    } else if (difference.inHours >= 1) {
      return (numericDates) ? '1 hour ago' : 'An hour ago';
    } else if (difference.inMinutes >= 2) {
      return '${difference.inMinutes} minutes ago';
    } else if (difference.inMinutes >= 1) {
      return (numericDates) ? '1 minute ago' : 'A minute ago';
    } else if (difference.inSeconds >= 3) {
      return '${difference.inSeconds} seconds ago';
    } else {
      return 'Just now';
    }
  }

  static Widget notFoundWidget() {
    return Material(
      child: Center(
        child: ListTile(
          title: Txt(
            text: "Not found!",
            fontWeight: FontWeight.bold,
            fontSize: 50,
            textAlign: TextAlign.center,
          ),
          subtitle: Txt(
            text: "The requested content is not found at this moment.",
            fontSize: 20,
            textAlign: TextAlign.center,
          ),
        ),
      ),
    );
  }

  static Widget noAccess() {
    return Material(
      child: Center(
        child: Txt(
          text: "You have no permission to see this content",
          fontSize: 20,
          textAlign: TextAlign.center,
        ),
      ),
    );
  }

  static bool isLight(BuildContext context) => Theme.of(context).brightness == Brightness.light;

  // static Future<bool> sendEmail(String email) async {
  //   bool success = false;
  //   email = email.toLowerCase();
  //   if (email.contains('@')) {
  //     success = true;
  //     await launch("mailto:$email", forceSafariVC: false, forceWebView: false);
  //   } else {
  //     showToast("Email address not found");
  //   }
  //   return success;
  // }

  static Future<void> copy(dynamic text) async {
    await Clipboard.setData(ClipboardData(text: "$text"));
    // showToast("Text copied!");
  }

  // static void debugToast(dynamic message) {
  //   if (debugging) showToast(message);
  // }

  // static void showToast(dynamic message) {
  //   if (debugging) print("$message");
  //   try {
  //     Fluttertoast.showToast(
  //       msg: '$message',
  //       toastLength: Toast.LENGTH_SHORT,
  //       gravity: ToastGravity.CENTER,
  //       backgroundColor: Colorz.primaryColor,
  //       textColor: Colors.white,
  //       fontSize: 16,
  //     );
  //   } catch (e) {
  //     print("Error showing Toast: $e");
  //   }
  // }

  ///[filter] Removes all the special characters and spaces
  static String filter(String text) {
    return (text.replaceAll(new RegExp(r'[^\w\s]+'), '').replaceAll(' ', '').replaceAll('_', ''));
  }

  ///Returns the [DateTime] values in a human readable format
  static String timeAgo(
    dynamic input, {
    String? prefix,
  }) {
    DateTime? finalDateTime;

    if (input is DateTime) finalDateTime = input;
    if (input is int) finalDateTime = DateTime.fromMillisecondsSinceEpoch(input);

    ///If the input is not valid, then just return ''
    if (finalDateTime == null) return '';

    final Duration difference = DateTime.now().difference(finalDateTime);
    bool isPast = finalDateTime.millisecondsSinceEpoch <= DateTime.now().millisecondsSinceEpoch;
    String ago;

    if (difference.inDays > 8) {
      ago = finalDateTime.toString().substring(0, 10);
    } else if ((difference.inDays / 7).floor() >= 1) {
      ago = isPast ? '1 week ago' : '1 week';
    } else if (difference.inDays >= 2) {
      ago = isPast ? '${difference.inDays} days ago' : '${difference.inDays} days';
    } else if (difference.inDays >= 1) {
      ago = isPast ? 'Yesterday' : 'Tomorrow';
    } else if (difference.inHours >= 2) {
      ago = '${difference.inHours} hours ${isPast ? 'ago' : ''}';
    } else if (difference.inHours >= 1) {
      ago = '1 hour ${isPast ? 'ago' : ''}';
    } else if (difference.inMinutes >= 2) {
      ago = '${difference.inMinutes} minutes ${isPast ? 'ago' : ''}';
    } else if (difference.inMinutes >= 1) {
      ago = '1 minute ${isPast ? 'ago' : ''}';
    } else if (difference.inSeconds >= 3) {
      ago = '${difference.inSeconds} seconds ${isPast ? 'ago' : ''}';
    } else {
      ago = '${isPast ? 'Just now' : 'now'}';
    }
    return prefix == null ? ago : '$prefix $ago';
  }

  static String toDateTime(int createdAt) {
    return '${toDate(createdAt)} @ ${toTime(createdAt)}';
  }

  static String toDate(int createdAt, {bool showFullYear = true, bool showYear = true}) {
    DateTime date = DateTime.fromMillisecondsSinceEpoch(createdAt);
    int day = date.day;
    int _month = date.month;
    String month = toMonth(_month);
    String year = showYear ? toYear(createdAt, showFullYear: showFullYear) : "";
    return '$day $month $year';
  }

  static String toTime(int createdAt) {
    DateTime date = DateTime.fromMillisecondsSinceEpoch(createdAt);
    int hour = date.hour > 12 ? (date.hour - 12) : date.hour;
    String minutes = date.minute < 10 ? '0${date.minute}' : '${date.minute}';
    String amPm = date.hour >= 12 ? "PM" : "AM";
    return '$hour:$minutes $amPm';
  }

  static String toYear(int createdAt, {bool showFullYear = true}) {
    int _yr = DateTime.fromMillisecondsSinceEpoch(createdAt).year;
    return showFullYear ? "$_yr" : "$_yr".substring(0, 2);
  }

  static String toMonth(int month) {
    return month > 0 ? months[month - 1] : '$month';
  }

  static const List<String> months = [
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

  // static Future<void> launchurl(String? url, {bool inApp = false}) async {
  //   try {
  //     if (url != null) {
  //       print("URL: $url");
  //       await launch(url, forceSafariVC: inApp, forceWebView: inApp);
  //     } else {
  //       showToast("No url!");
  //     }
  //   } catch (exception) {
  //     showToast("Error $exception");
  //   }
  // }

  static Future wait(int milliseconds) async {
    await Future.delayed(Duration(milliseconds: milliseconds));
  }

  static void push(Widget? child, BuildContext context) {
    if (child != null) {
      Navigator.push(context, FadePageRoute(widget: child));
    } else {
      // String _log = "No destination page found";
      // debugMode ? showToast(_log) : print(_log);
    }
  }

  @Deprecated('Use pop')
  static void close(BuildContext context) => pop(context);
  static void pop(BuildContext context) {
    try {
      Navigator.pop(context);
    } catch (e) {}
  }

  static double mheight(BuildContext context) {
    return MediaQuery.of(context).size.height;
  }

  static double mwidth(BuildContext context) {
    return MediaQuery.of(context).size.width;
  }

  static Widget empty() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Center(
        child: Padding(
          padding: const EdgeInsets.all(18),
          child: Icon(
            Icons.delete,
            size: 100,
            color: Colors.grey.shade300,
          ),
        ),
      ),
    );
  }

  static Widget divider({Color? color}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5.0),
      child: Divider(
        height: 4.5,
        color: color,
      ),
    );
  }

  static Widget heading({dynamic text}) {
    return Padding(
      padding: const EdgeInsets.only(top: 8.0, left: 8.0),
      child: Txt(
        text: text,
        color: Colors.grey,
        fontWeight: FontWeight.bold,
      ),
    );
  }

  static Widget offHeader(bool hide, dynamic text) {
    return Offstage(
      offstage: hide,
      child: Container(
        alignment: Alignment.bottomLeft,
        padding: EdgeInsets.only(top: 20, left: 6),
        child: Txt(
          text: text,
          color: Colors.grey,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}
