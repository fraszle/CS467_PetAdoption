import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class PetProfile extends StatelessWidget {
  const PetProfile({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    CollectionReference pets = FirebaseFirestore.instance.collection('pets');

    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: const Text('Pet Profile'),
        ),
        body: FutureBuilder<DocumentSnapshot>(
          future: pets.doc('x23u57Kvl6byMHFb5K7P').get(),
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
              return Container(
                  padding: const EdgeInsets.all(32),
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Temp image until we figure out image storage
                        Image.asset('assets/images/persian_cat.jpg',
                            fit: BoxFit.cover),
                        Text('Name: ${data['name']}'),
                        Text('Type: ${data['type']}'),
                        Text('Breed: ${data['breed']}'),
                        Text('Availability: ${data['availability']}'),

                        // Figure out how to change timestamp type to string date
                        Text('Date Created: WIP'),
                        Text('Disposition: How to loop over? WIP')
                      ]));
            }

            return const Text("loading...");
          },
        ));
  }
}
