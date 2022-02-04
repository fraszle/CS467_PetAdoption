import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class UserProfile extends StatelessWidget {
  const UserProfile({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    CollectionReference users = FirebaseFirestore.instance.collection('users');

    return Container(
        margin: const EdgeInsets.all(10.0),
        child: FutureBuilder<DocumentSnapshot>(
          future: users.doc('GP11dBKUW7C1Xj5OeyHV').get(),
          builder:
              (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {
            if (snapshot.hasError) {
              return Text("Something went wrong: ${snapshot.error}");
            }

            if (snapshot.hasData && !snapshot.data!.exists) {
              return const Text("Document does not exist");
            }

            if (snapshot.connectionState == ConnectionState.done) {
              Map<String, dynamic> data =
                  snapshot.data!.data() as Map<String, dynamic>;

              return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Name: ${data['firstName']}' +
                        ' ' +
                        '${data['lastName']}'),
                    Text('Location: ${data['location']['city']}' +
                        ', ' +
                        '${data['location']['state']}')
                  ]);
            }

            return const Text("loading...");
          },
        ));
  }
}
