import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:plentyofpets/components/pet_card.dart';
import 'package:plentyofpets/services/pet_database.dart';

// This class creates/displays the list of pets from logged in admin
class AdminPets extends StatelessWidget {
  const AdminPets({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance.collection('pets').
          where('admin', isEqualTo: '${DatabaseService().getUser()}').snapshots(),
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
            if(petDocs.isNotEmpty){
              return ListView.builder(
                itemCount: petDocs.length,
                itemBuilder: (context, index) {
                  Map<String, dynamic> data =
                      petDocs[index].data()! as Map<String, dynamic>;
                  return PetCard(data, petDocs[index].id);
                });
            }else{
              return(const Text(
                'Your organization does not currently have any pets being shown'));
            }
          }
        }
    );
  }
}