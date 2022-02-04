import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:plentyofpets/components/pet_description.dart';
import '../components/pet_image.dart';
import '../components/pet_description.dart';

class PetProfile extends StatelessWidget {
  const PetProfile({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    CollectionReference pets = FirebaseFirestore.instance.collection('pets');
    const String petID = 'x23u57Kvl6byMHFb5K7P';

    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: const Text('Pet Profile'),
        ),
        body: FutureBuilder<DocumentSnapshot>(
          future: pets.doc(petID).get(),
          builder:
              (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {
            return snapshotResult(context, snapshot);
          },
        ));
  }
}

Widget snapshotResult(
    BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {
  if (snapshot.hasError) {
    return Text("Something went wrong: ${snapshot.error}");
  }

  if (snapshot.hasData && !snapshot.data!.exists) {
    return const Text("Document does not exist");
  }

  if (snapshot.connectionState == ConnectionState.done) {
    Map<String, dynamic> data = snapshot.data!.data() as Map<String, dynamic>;

    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Container(
          margin: const EdgeInsets.all(8.0), child: const PetProfileImage()),
      Container(margin: const EdgeInsets.all(10.0), child: PetDescription(data))
    ]);
  }
  return const Text('loading....');
}
