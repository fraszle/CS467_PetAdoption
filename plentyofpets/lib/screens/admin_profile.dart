import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import '../services/pet_database.dart';
import '../components/line_divider.dart';

// Class to display Admin account information
class AdminProfile extends StatelessWidget {
  const AdminProfile({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    CollectionReference users = FirebaseFirestore.instance.collection('users');
    // get a reference to the 'users' collecttion
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: const Text('Account Information'),
        ),
        body: FutureBuilder(
          // get access to the snapshot of currently logged in user data
          future: users.doc(DatabaseService().getUser().toString()).get(),
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
                      adminName(
                          data['firstName'] ?? '', data['lastName'] ?? ''),
                      lineDivider(),
                      location(data['location']['city'] ?? '',
                          data['location']['state'] ?? ''),
                      lineDivider(),
                      organization(data['organization'] ?? ''),
                      lineDivider(),
                      orgUrl(data['url'] ?? ''),
                    ]),
              );
            }

            return const Text("loading profile...");
          },
        ));
  }

  // Return profile section for Admin name
  Widget adminName(String firstName, String lastName) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'First Name:',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              Text(firstName)
            ],
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text('Last Name:',
                  style: TextStyle(fontWeight: FontWeight.bold)),
              Text(lastName)
            ],
          )
        ],
      ),
    );
  }

  Widget location(String city, String state) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text('Location:',
                  style: TextStyle(fontWeight: FontWeight.bold)),
              Text(city + ', ' + state),
            ],
          )
        ],
      ),
    );
  }

  Widget organization(String organizationName) {
    return Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text('Organization Name:',
                    style: TextStyle(fontWeight: FontWeight.bold)),
                Text(organizationName),
              ],
            )
          ],
        ));
  }

  Widget orgUrl(String url) {
    return Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text('Url:',
                    style: TextStyle(fontWeight: FontWeight.bold)),
                Text(url),
              ],
            )
          ],
        ));
  }
}
