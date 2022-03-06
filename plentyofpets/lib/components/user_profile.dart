import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:plentyofpets/services/pet_database.dart';
import '../components/line_divider.dart';

class UserProfile extends StatelessWidget {
  const UserProfile({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // get a reference to the 'users' collecttion
    CollectionReference users = FirebaseFirestore.instance.collection('users');
    return Scaffold(
        body: SingleChildScrollView(
          child: FutureBuilder(
              // get access to the snapshot of currently logged in user data
              future: users.doc(DatabaseService().getUser().toString()).get(),
              builder:
            (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {
          if (snapshot.hasError) {
            return const Text("Something went wrong");
          }
        
          if (snapshot.hasData && !snapshot.data!.exists) {
            return const Text("Document does not exist");
          }
        
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
        
          if (snapshot.connectionState == ConnectionState.done) {
            Map<String, dynamic> data =
                snapshot.data!.data() as Map<String, dynamic>;
            return Padding(
              padding: const EdgeInsets.fromLTRB(20, 40, 20, 0),
              child:
                  Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                userFirstName(data['firstName']),
                lineDivider(),
                userLastName(data['lastName']),
                lineDivider(),
                userLocation(data['location']['city'], data['location']['state']),
                lineDivider(),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'Email:',
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          Text(data['email']),
                        ],
                      )
                    ],
                  ),
                )
              ]),
            );
          }
        
          return const Center(child: Text('loading profile...'));
              },
            ),
        ));
  }

  // Return profile section for Admin name
  Widget userFirstName(String firstName) {
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
        ],
      ),
    );
  }

  Widget userLastName(String lastName) {
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
                'Last Name:',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              Text(lastName)
            ],
          ),
        ],
      ),
    );
  }

  Widget userLocation(String city, String state) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text('Location (City, State):',
                  style: TextStyle(fontWeight: FontWeight.bold)),
              Text(city + ', ' + state),
            ],
          )
        ],
      ),
    );
  }
}
