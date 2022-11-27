import 'package:flutter/material.dart';
import 'package:fluttership/Constants/Constants.dart';
import 'package:fluttership/Models/GResult.dart';
import 'package:fluttership/Widgets/Widgets.dart';

class GoogleSearchPage extends StatefulWidget {
  const GoogleSearchPage({Key? key}) : super(key: key);

  @override
  _GoogleSearchPageState createState() => _GoogleSearchPageState();
}

class _GoogleSearchPageState extends State<GoogleSearchPage> {
  final TextEditingController searchController = TextEditingController(
    text: "flutter google search clone with source code in github",
  );

  GResultType selectedGResultType = GResultType.All;
  String selectedLanguage = languages[0];

  String query = ''; //use it when you need real search

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: appBar(),
      body: body(),
    );
  }

  AppBar appBar() {
    return AppBar(
      backgroundColor: Colors.white,
      elevation: 0,
      centerTitle: true,
//leading
      leading: IconButton(
        icon: Icon(Icons.menu, color: Colors.grey),
        onPressed: () {},
      ),

//title
      title: Image.asset(Assets.google, height: 30),

//tailing action
      actions: [
        IconButton(
          icon: Icon(Icons.account_circle_outlined, color: Colors.blue.shade800),
          onPressed: () {},
        )
      ],
    );
  }

  Widget body() {
    return ListView(shrinkWrap: true, children: [
      searchField(),
      filterResultTypes(),
      resultsList(),
      relatedSearchesTile(),
      relatedSearchQueriesListView(),
      footerGreyWidgets(),
    ]);
  }

  Widget searchField() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Material(
        color: Colors.white,
        elevation: 1.75,
        borderRadius: BorderRadius.circular(20),
        child: TextField(
          controller: searchController,
          onChanged: (z) {
            setState(() {
              query = z.toLowerCase();
            });
          },
          decoration: InputDecoration(
            border: InputBorder.none,
            hintText: "Search",
            prefixIcon: IconButton(
              icon: Icon(Icons.search, color: Colors.grey),
              onPressed: () {},
            ),
          ),
        ),
      ),
    );
  }

  Widget filterResultTypes() {
    List list = GResultType.values.toList();
    return Container(
      height: 45,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: list.length,
        itemBuilder: (BuildContext context, int index) {
          GResultType type = list[index];
          bool selected = type == selectedGResultType;
          return Padding(
            padding: const EdgeInsets.all(5),
            child: ActionChip(
              label: Txt(
                text: type.string,
                underline: selected,
                fontWeight: FontWeight.bold,
                color: selected ? Colors.black : Colors.grey.shade600,
              ),
              backgroundColor: Colors.white,
              elevation: 0,
              onPressed: () {
                setState(() {
                  selectedGResultType = type;
                });
              },
            ),
          );
        },
      ),
    );
  }

  Widget resultsList() {
    return ListView.separated(
      shrinkWrap: true,
      itemCount: total.length,
      itemBuilder: (context, index) {
        GResult gResult = total[index];
        return resultCard(gResult);
      },
      separatorBuilder: (BuildContext context, int index) {
        return Container(
          height: 10,
          color: Colors.grey.shade300,
        );
      },
    );
  }

  Widget resultCard(GResult gResult) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          faviconUrl(gResult.url),
          resultTitle(gResult.title),
          resultDescription(gResult.description),
        ],
      ),
    );
  }

  Widget faviconUrl(String url) {
    return Row(children: [
      Padding(
        padding: const EdgeInsets.symmetric(horizontal: 6),
        child: Icon(Icons.pets, size: 18, color: Colors.black),
      ),
      Txt(
        text: url,
        fontSize: 12,
      ),
    ]);
  }

  Widget resultTitle(String title) {
    return Txt(
      text: title,
      fontSize: 20,
      color: Colors.blue.shade800, //use deepPurple if a link is clicked,
      maxLines: 2,
    );
  }

  Widget resultDescription(String? description) {
    if (description == null) return Container();
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Txt(
        text: description,
        fontSize: 12.75,
        maxLines: 3,
        color: Colors.grey.shade800,
      ),
    );
  }

  Widget relatedSearchesTile() {
    return ListTile(
      title: Txt(
        text: "Related searches",
        fontSize: 20,
        fontWeight: FontWeight.bold,
      ),
    );
  }

  Widget relatedSearchQueriesListView() {
    return ListView.builder(
      shrinkWrap: true,
      itemCount: relatedSearchQueries.length,
      itemBuilder: (context, int index) {
        String rs = relatedSearchQueries[index];
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4),
          child: Column(
            children: [
              //Not satisfied
              // ListTile(
              //   contentPadding: EdgeInsets.all(0),
              //   leading: Icon(Icons.search,color: Colors.grey,size:20),
              //   title: Txt(
              //     text: rs,
              //     fontSize: 13,
              //   ),
              // ),
              Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: Icon(Icons.search, color: Colors.grey, size: 20),
                  ),
                  Txt(
                    text: rs,
                    fontSize: 13,
                  ),
                ],
              ),
              Divider(
                thickness: 1.25,
              ),
            ],
          ),
        );
      },
    );
  }

  Widget footerGreyWidgets() {
    return Container(
      color: Colorz.googlResultsGrey,
      child: ListView(
        shrinkWrap: true,
        children: [
          moreResultsTile(),
          countryName(),
          Divider(),
          offeredLanguages(),
          Divider(),
          locationInfo(),
          signInLable(),
          settingsHelpFeedback(),
          privacyTerms(),
        ],
      ),
    );
  }

  Widget moreResultsTile() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        padding: EdgeInsets.all(8),
        child: Row(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: Icon(Icons.keyboard_arrow_down),
            ),
            // Spacer(),
            Expanded(
              child: Container(
                alignment: Alignment.center,
                child: Txt(
                  text: "More results",
                  textAlign: TextAlign.center,
                ),
              ),
            ),
            // Spacer(),
          ],
        ),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(30),
        ),
      ),
    );
  }

  Widget countryName() {
    return Container(
      height: 55,
      alignment: Alignment.bottomCenter,
      padding: EdgeInsets.all(4),
      child: Txt(
        text: "India",
        fontSize: 16,
        color: Colors.grey,
      ),
    );
  }

  Widget offeredLanguages() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Container(
          height: 50,
          alignment: Alignment.center,
          // color: Colors.green,
          padding: EdgeInsets.symmetric(horizontal: 16),
          child: Txt(
            text: "Google\noffered in:",
            color: Colors.grey.shade600,
            fontSize: 12.5,
          ),
        ),
        Flexible(
          child: Container(
            // color: Colors.pink,
            alignment: Alignment.center,
            height: 50,
            child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: languages.length,
                itemBuilder: (c, index) {
                  String language = languages[index];
                  bool selected = selectedLanguage == language;
                  return Container(
                    alignment: Alignment.center,
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: InkWell(
                        child: Txt(
                          text: language,
                          color: selected ? Colors.black : Colors.blue.shade600,
                        ),
                        onTap: () {
                          setState(() {
                            selectedLanguage = language;
                          });
                        }),
                  );
                }),
          ),
        ),
      ],
    );
  }

  Widget locationInfo() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
      child: RichText(
        text: TextSpan(
          children: [
            WidgetSpan(
              child: Icon(Icons.brightness_1, color: Colors.grey.shade800, size: 12),
            ),
            TextSpan(
                text: "Tiruchirappalli, Tamil Nadu",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                  fontSize: 12.5,
                )),
            TextSpan(
                text: "-",
                style: TextStyle(
                  fontWeight: FontWeight.normal,
                  color: Colors.grey,
                  fontSize: 12.5,
                )),
            TextSpan(
                text: "From your internet address - Use precise location - Learn more",
                style: TextStyle(
                  fontWeight: FontWeight.normal,
                  color: Colors.grey,
                  fontSize: 12.5,
                )),
          ],
        ),
      ),
    );
  }

  Widget signInLable() {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Txt(
          text: "Sign in",
          color: Colors.grey.shade700,
          fontSize: 12,
        ),
      ),
    );
  }

  Widget settingsHelpFeedback() {
    List<String> labels = ["Settings", "Help", "Feedback"];
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: labels.map((label) {
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
          child: Txt(
            text: label,
            color: Colors.grey.shade700,
            fontSize: 12,
          ),
        );
      }).toList(),
    );
  }

  Widget privacyTerms() {
    List<String> labels = ["Privacy", "Terms"];
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: labels.map((label) {
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
          child: Txt(
            text: label,
            color: Colors.grey.shade700,
            fontSize: 12,
          ),
        );
      }).toList(),
    );
  }

  static List<GResult> total = [
    GResult("https://gihub.com>om-chauhan", "om-chauhan/google-search-clone...-Github",
        "25-Mar-2021 - A Google Search Clone using flutter (Mobile, Tablet, Desktop version), getting started. 1.copy or download code in your project"),
    GResult("https://gihub.com>flutter>flutter",
        "flutter/flutter: Flutter makes it easy and fast to build beautiful ...- Github", null),
    GResult("https://gihub.com>tortuvshin>op...", "Github - tortuvshin/open-source-flutter-apps",
        "The amin goal of this repository is to find free open source apps and start contributing to it. Feel free to contribute to the list, any suggestions are welcome."),
    GResult("https://gihub.com>tortuvshin>op...", "Github - tortuvshin/open-source-flutter-apps",
        "The amin goal of this repository is to find free open source apps and start contributing to it. Feel free to contribute to the list, any suggestions are welcome."),
    GResult("https://gihub.com>tortuvshin>op...", "Github - tortuvshin/open-source-flutter-apps",
        "The amin goal of this repository is to find free open source apps and start contributing to it. Feel free to contribute to the list, any suggestions are welcome."),
    GResult("https://gihub.com>om-chauhan", "om-chauhan/google-search-clone...-Github",
        "25-Mar-2021 - A Google Search Clone using flutter (Mobile, Tablet, Desktop version), getting started. 1.copy or download code in your project"),
    GResult("https://gihub.com>om-chauhan", "om-chauhan/google-search-clone...-Github",
        "25-Mar-2021 - A Google Search Clone using flutter (Mobile, Tablet, Desktop version), getting started. 1.copy or download code in your project"),
    GResult("https://gihub.com>flutter>flutter",
        "flutter/flutter: Flutter makes it easy and fast to build beautiful ...- Github", null),
    GResult("https://gihub.com>tortuvshin>op...", "Github - tortuvshin/open-source-flutter-apps",
        "The amin goal of this repository is to find free open source apps and start contributing to it. Feel free to contribute to the list, any suggestions are welcome."),
    GResult("https://gihub.com>tortuvshin>op...", "Github - tortuvshin/open-source-flutter-apps",
        "The amin goal of this repository is to find free open source apps and start contributing to it. Feel free to contribute to the list, any suggestions are welcome."),
    GResult("https://gihub.com>tortuvshin>op...", "Github - tortuvshin/open-source-flutter-apps",
        "The amin goal of this repository is to find free open source apps and start contributing to it. Feel free to contribute to the list, any suggestions are welcome."),
    GResult("https://gihub.com>om-chauhan", "om-chauhan/google-search-clone...-Github",
        "25-Mar-2021 - A Google Search Clone using flutter (Mobile, Tablet, Desktop version), getting started. 1.copy or download code in your project"),
  ];

  static List<String> relatedSearchQueries = [
    "Flutter github",
    "Flutter sample projects",
    "Flutter tutorial",
    "Flutter base project github",
    "Flutter version",
    "React native Github",
    "Flutter apps",
    "Flutter SDK",
  ];

  static List<String> languages = [
    "English",
    "हिन्दी",
    "தமிழ்",
    "বাংলা",
    "తెలుగు",
    "मराठी",
    "ગુજરાતી",
    "ಕನ್ನಡ",
    "മലയാളം",
    "ਪੰਜਾਬੀ",
  ];
}
