import 'package:flutter/material.dart';
import 'package:fluttershipp/Constants/Constants.dart';
import 'package:fluttershipp/Models/Clone.dart';
import 'package:fluttershipp/UI/Home/MobilePhone.dart';
import '../../Widgets/Widgets.dart';
import 'Browser.dart';

class WebHomePage extends StatefulWidget {
  final List<Clone> clones;
  final double width;
  const WebHomePage({Key? key, required this.clones, required this.width}) : super(key: key);

  @override
  _WebHomePageState createState() => _WebHomePageState();
}

class _WebHomePageState extends State<WebHomePage> {
  final TextEditingController searchController = TextEditingController();
  String query = '';
  int selectedIndex = 0;
  late Widget selectedClonePage;

  @override
  void initState() {
    selectedClonePage = widget.clones.first.page;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Row(
        children: [
          drawer(),
          primaryContent(),
          MobilePhone(
            page: selectedClonePage,
          ),
        ],
      ),
    );
  }

  Widget drawer() {
    final bool extended = widget.width > (256 + 512 + 24 + 480 + 24);

    return Theme(
      data: ThemeData.dark().copyWith(
        colorScheme: ThemeData.dark().colorScheme.copyWith(
              surface: Colorz.complexDrawerBlack,
            ),
      ),
      child: NavigationRail(
        extended: extended,
        onDestinationSelected: (int i) {
          if (mounted) setState(() => selectedIndex = i);
        },
        trailing: Txt(text: '${extended?"Version":"v"} 1.0.0',color: Colors.white54,),
        destinations: [
          NavigationRailDestination(
            icon: Icon(Icons.phone_android_rounded),
            label: Txt(text: 'Screens'),
          ),
          NavigationRailDestination(icon: Icon(Icons.tv), label: Txt(text: 'Youtube')),
          NavigationRailDestination(icon: Icon(Icons.code), label: Txt(text: 'Github')),
        ],
        selectedIndex: selectedIndex,
      ),
    );
  }

  Widget clonseListView() {
    return Expanded(
      child: LayoutBuilder(
        builder: (c, s) {
          final bool insufficient = s.maxWidth < 100;
          return Container(
            alignment: Alignment.center,
            width: 512,
            padding: insufficient ? null : EdgeInsets.symmetric(horizontal: 12),
            child: insufficient
                ? null
                : Column(
                    children: [
                      searchField(),
                      clonesResult(width: s.maxWidth),
                    ],
                  ),
          );
        },
      ),
    );
  }

  Widget primaryContent() {
    String youtubeChannel = 'https://www.youtube.com/fluttershipp';
    String gitHubPage = 'https://github.com/irajeshh/FlutterShip';
    return [
      clonseListView(),
      BrowserPage(
        key: UniqueKey(),
        url: youtubeChannel,
      ),
      BrowserPage(
        key: UniqueKey(),
        url: gitHubPage,
      ),
    ][selectedIndex];
  }

  Widget searchField() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12),
      child: Card(
        elevation: 6,
        child: TextField(
          controller: searchController,
          decoration: InputDecoration(
            prefixIcon: IconButton(
                icon: Icon(
              Icons.search,
              color: Colors.grey,
            )),
            suffixIcon: IconButton(
              icon: Icon(
                Icons.clear,
                color: Colors.grey,
              ),
              onPressed: () {
                if (mounted)
                  setState(() {
                    query = '';
                    searchController.clear();
                  });
                FocusScope.of(context).unfocus();
              },
            ),
            border: InputBorder.none,
            hintText: 'Search...',
            contentPadding: EdgeInsets.only(
              top: 16,
            ),
          ),
          onChanged: (z) => setState(() => query = z.toLowerCase()),
        ),
      ),
    );
  }

  Widget clonesResult({required double width}) {
    List<Clone> _clones = widget.clones.where((clone) {
      return clone.title.toString().toLowerCase().contains(query) ||
          clone.title.toString().toLowerCase().contains(query);
    }).toList();
    final bool shrink = width < 350;
    final bool shrinkMore = width < 200;

    return Flexible(
      child: ListView.builder(
        padding: EdgeInsets.all(0),
        shrinkWrap: false,
        itemCount: _clones.length,
        itemBuilder: (BuildContext context, int index) {
          final Clone clone = _clones[index];
          return shrink
              ? cloneCard(clone, shrinkMore: shrinkMore)
              : cloneTile(
                  clone,
                );
        },
      ),
    );
  }

  Widget cloneTile(
    Clone clone,
  ) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        vertical: 12,
      ),
      child: Card(
        elevation: 6,
        child: ListTile(
          leading: IconButton(
              icon: Icon(
            clone.icon,
            color: clone.color,
          )),
          title: Txt(
            text: clone.title,
            fontWeight: FontWeight.bold,
          ),
          subtitle: Txt(
            text: clone.description,
          ),
          onTap: () {
            if (mounted) setState(() => selectedClonePage = clone.page);
          },
        ),
      ),
    );
  }

  Widget cloneCard(Clone clone, {bool shrinkMore = false}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 18),
      child: Card(
        elevation: 8,
        shadowColor: clone.color.withAlpha(100),
        child: Inkk(
          onTap: () {
            if (mounted) setState(() => selectedClonePage = clone.page);
          },
          spalshColor: clone.color,
          child: Container(
            height: 200,
            alignment: Alignment.center,
            width: double.maxFinite,
            color: clone.color.withOpacity(0.1),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Icon(
                  clone.icon,
                  color: clone.color,
                  size: shrinkMore ? 50 : 30,
                ),
                if (shrinkMore == false)
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Txt(
                      textAlign: TextAlign.center,
                      text: clone.title,
                      maxLines: 1,
                      fontSize: 18,
                      color: clone.color,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void clearSearch() {
    searchController.clear();
    query = '';
    FocusScope.of(context).unfocus();
  }
}
