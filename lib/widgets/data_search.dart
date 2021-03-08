import 'package:flutter/material.dart';
import 'search_webview.dart';
import 'package:hive/hive.dart';

class DataSearch extends SearchDelegate<String> {
  final List mostCommon = [];
  List recentQuestions;

  dynamic getRecentQuestions() async {
    var box = await Hive.openBox('jac');
    recentQuestions = box.get('recentQuestions');
  }

  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
        icon: Icon(Icons.clear),
        onPressed: () {
          query = "";
        },
      ),
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      icon: AnimatedIcon(
        icon: AnimatedIcons.menu_arrow,
        progress: transitionAnimation,
      ),
      onPressed: () {
        close(context, null);
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    if (query != "") {
      recentQuestions.add(query);
      var box = Hive.box('jac');
      box.put("recentQuestions", recentQuestions);
    }
    return SearchWebView(query);
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    var box = Hive.box('jac');
    if (box.get("recentQuestions") == null) {
      box.put("recentQuestions", []);
    }
    recentQuestions = box.get("recentQuestions");

    final suggestionList = query.isEmpty
        ? recentQuestions
        : mostCommon.where((element) => element.startsWith(query)).toList();

    return ListView.builder(
      itemBuilder: (context, index) => ListTile(
        onTap: () {
          showResults(context);
        },
        leading: Icon(Icons.question_answer),
        title: RichText(
          text: TextSpan(
            text: suggestionList[index].substring(0, query.length),
            style: TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.bold,
              fontSize: 20.0,
            ),
            children: [
              TextSpan(
                text: suggestionList[index].substring(query.length),
                style: TextStyle(color: Colors.grey, fontSize: 20.0),
              ),
            ],
          ),
        ),
      ),
      itemCount: suggestionList.length,
    );
  }
}
