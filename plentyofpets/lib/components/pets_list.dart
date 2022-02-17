import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:plentyofpets/components/pet_card.dart';

// This class will be used to create and display a list of pets
class PetList extends StatelessWidget {
  const PetList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance.collection('pets').snapshots(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasError) {
            return Text("Something went wrong: ${snapshot.error}");
          }
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const CircularProgressIndicator(
              value: null,
              semanticsLabel: 'Progress Indicator',
            );
          } else {
            // Get a list of all documents in the collection
            List petDocs = snapshot.data!.docs;

            // Create a ListView with each document as a PetBlurb Widget child
            return ListView.builder(
                itemCount: petDocs.length,
                itemBuilder: (context, index) {
                  Map<String, dynamic> data =
                      petDocs[index].data()! as Map<String, dynamic>;
                  return PetCard(data, petDocs[index].id);
                });
          }
        });
  }
}
