import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:plentyofpets/components/pet_blurb.dart';

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
            return const Text("Loading...");
          } else {
            // Get a list of all documents in the collection
            List petDocs = snapshot.data!.docs;

            // Create a ListView with each document as a PetBlurb Widget child
            return ListView(children: petArr(petDocs));
          }
        });
  }
}

List<Widget> petArr(List petDocs) {
  List<Widget> allPets = [];

  // Loop over each document and create a PetBlurb from each one.
  for (var item in petDocs) {
    Map<String, dynamic> data = item.data()! as Map<String, dynamic>;
    String docID = item.id;
    allPets.add(PetBlurb(data, docID));
  }

  return allPets;
}
