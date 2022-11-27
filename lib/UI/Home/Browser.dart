import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher_string.dart';

import '../../Widgets/Widgets.dart';

class BrowserPage extends StatefulWidget {
  final String url;
  const BrowserPage({super.key, required this.url});

  @override
  State<BrowserPage> createState() => _BrowserPageState();
}

class _BrowserPageState extends State<BrowserPage> with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;

  @override
  void initState() {
    loadWebsite();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Center(
      child: Loader(
        size: 150,
      ),
    );
  }

  void loadWebsite() async {
    await launchUrlString(widget.url, mode: LaunchMode.inAppWebView);
  }
}
