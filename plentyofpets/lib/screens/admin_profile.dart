import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

// Class to display Admin account information
class AdminProfile extends StatelessWidget {
  const AdminProfile({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    CollectionReference users = FirebaseFirestore.instance.collection('users');

    return Container(
      margin: const EdgeInsets.all(10.0),
      child: FutureBuilder<DocumentSnapshot>(
        future: users.doc('JimXAqx3qgxONKm6J4Cg').get(),
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

            return Padding(
              padding: const EdgeInsets.fromLTRB(20, 40, 20, 0),
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Name: ${data['firstName']}' ' ' + data['lastName']),
                    Text('Location: ${data['location']['city']}' ', ' +
                        data['location']['state']),
                    Text('Organization Name: ${data['orgName']}'),
                    Text('Url: ${data['url']}')
                  ]),
            );
          }

          return const Text("loading...");
        },
      ));
  }
}
