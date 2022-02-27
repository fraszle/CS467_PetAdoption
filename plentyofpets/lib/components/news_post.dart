import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

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
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(formatter.format(post['timestamp'].toDate())),
                  Text(
                      'Posted By: ${(snapshot.data!.data() as Map)["organization"]}'),
                  Text(post['article'])
                ],
              );
            } else {
              return const Text('Empty data');
            }
          }
        });
  }
}
