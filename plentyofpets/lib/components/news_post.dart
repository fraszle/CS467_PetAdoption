import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'title.dart';

class NewsPost extends StatelessWidget {
  static var formatter = DateFormat('MM/dd/yyyy, hh:mm a');
  static CollectionReference users =
      FirebaseFirestore.instance.collection('users');

  final Map<String, dynamic> post;

  const NewsPost({Key? key, required this.post}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: users.doc(post['organization']).get(),
        builder: (
          BuildContext context,
          AsyncSnapshot<DocumentSnapshot<Object?>> snapshot,
        ) {
          if (snapshot.connectionState != ConnectionState.done) {
            return const CircularProgressIndicator();
          } else {
            if (snapshot.hasError) {
              return const Text('Error');
            } else if (snapshot.hasData) {
              return ListView(
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Align(
                          alignment: Alignment.center,
                          child: TitleText(text: post['title'])),
                      Text(
                        'Posted By: ${(snapshot.data!.data() as Map)["organization"]}',
                        style: Theme.of(context).textTheme.caption,
                      ),
                      Text(
                        formatter.format(post['timestamp'].toDate()),
                        style: Theme.of(context).textTheme.caption,
                      ),
                      Container(
                        height: 50,
                      ),
                      Text(
                        post['article'],
                        style: Theme.of(context).textTheme.caption,
                      )
                    ],
                  )
                ],
              );
            } else {
              return const Text('Empty data');
            }
          }
        });
  }
}
