import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:plentyofpets/main.dart';
import 'package:plentyofpets/theme.dart';

class NewsFeed extends StatefulWidget {
  const NewsFeed({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _NewsFeedState();
  }
}

class _NewsFeedState extends State<NewsFeed> {
  var dateFormatter = DateFormat('MM/dd/yy');
  Stream<QuerySnapshot<Map<String, dynamic>>> stream = FirebaseFirestore
      .instance
      .collection('news')
      .orderBy('timestamp', descending: true)
      .snapshots();

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: stream,
        builder: (BuildContext context,
            AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>> snapshot) {
          if (snapshot.hasData) {
            return ListView.separated(
              itemCount: snapshot.data!.docs.length,
              itemBuilder: (context, index) => newsListTile(snapshot, index),
              separatorBuilder: (context, index) => const Divider(),
            );
          }

          return const CircularProgressIndicator();
        });
  }

  ListTile newsListTile(
      AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>> snapshot, int index) {
    var post = snapshot.data!.docs[index].data();
    String article = post['article'];
    List<Text> textPreview = getArticlePreview(article);
    return ListTile(
      title: Row(children: [
        Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
                  Text(
                    post['title'],
                    style: PlentyOfPetsTheme.paragraphText,
                  )
                ] +
                textPreview),
        Expanded(
          child: Container(),
        ),
        Text(post['timestamp'] == null
            ? ''
            : dateFormatter.format(post['timestamp'].toDate()))
      ]),
      onTap: () {
        Navigator.of(context).pushNamed(MyApp.newsPostRoute, arguments: post);
      },
    );
  }

  /// Splits the News' article into multiple lines to display as appropriate
  List<Text> getArticlePreview(String article) {
    List<String> preview = [];
    if (article.length > 40) {
      preview.add(article.substring(0, 40));
      if (article.length > 80) {
        var replacedString = article.replaceRange(77, null, '...');
        preview.add(replacedString.substring(40, 80));
      } else {
        preview.add(article.substring(40));
      }
    } else {
      preview.add(article);
    }

    List<Text> widgetList = [];
    for (String string in preview) {
      widgetList.add(Text(string));
    }
    return widgetList;
  }
}
