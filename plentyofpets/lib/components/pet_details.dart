import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:plentyofpets/components/pet_description.dart';

class PetDetails extends StatelessWidget {
  const PetDetails(this.petID, this.petBasics, {Key? key}) : super(key: key);

  final String petID;
  final Map petBasics;

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance
            .collection('pets')
            .doc(petID)
            .collection('pet_details')
            .snapshots(),
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
            // Get a list of all documents in the collection (there should only be one doc)
            List petDocs = snapshot.data!.docs;

            Map<String, dynamic> petDetails =
                petDocs[0].data()! as Map<String, dynamic>;

            // Create the PetDescription widget with the data
            return PetDescription(petBasics, petDetails, petID);
          }
        });
  }
}
