import 'package:cloud_firestore/cloud_firestore.dart';

class BuildFilterQuery {
  BuildFilterQuery({required this.filterData});

  final Map<String, dynamic> filterData;

  List distinctPetID = [];
  List petDocs = [];

  final Map petBreedMap = {
    'Cat': [
      'Persian',
      'Maine Coon',
      'Siamese',
      'Ragdoll',
      'Sphynx',
      'Domestic Shorthair',
    ],
    'Dog': [
      'Golden Retriever',
      'Lab',
      'Pit Mix',
      'Chihuahua',
      'Corgi',
      'German Shepherd',
    ],
    'Other': ['Hamster', 'Guinea Pig', 'Parakeet', 'Rabbit']
  };

  //Collection reference
  final CollectionReference petsCollection =
      FirebaseFirestore.instance.collection('pets');

  Future<List> getFilteredPets() async {
    List petID = [];

    await petsCollection
        .where('type', isEqualTo: filterData['petType'])
        .get()
        .then((QuerySnapshot querySnapshot) {
      for (var doc in querySnapshot.docs) {
        petID.add(doc.id);
      }
    });

    List breedList = await petsByBreed(filterData['petType']);
    if (breedList.isNotEmpty) {
      petID = petID.toSet().intersection(breedList.toSet()).toList();
    }

    List dispoList = await petsByDisposition();
    if (dispoList.isNotEmpty) {
      petID = petID.toSet().intersection(dispoList.toSet()).toList();
    }

    petDocs = await getDocs(petID);
    return petDocs;
  }

  Future<List> petsByBreed(String petType) async {
    List breedList = [];

    if (filterData['petBreed'].isNotEmpty) {
      if (filterData['petBreed'].contains('Other')) {
        await petsCollection
            .where('breed', whereNotIn: petBreedMap[petType])
            .get()
            .then((QuerySnapshot querySnapshot) {
          for (var doc in querySnapshot.docs) {
            breedList.add(doc.id);
          }
        });
      }
      await petsCollection
          .where('breed', whereIn: petBreedMap[petType])
          .get()
          .then((QuerySnapshot querySnapshot) {
        for (var doc in querySnapshot.docs) {
          breedList.add(doc.id);
        }
      });
    }
    return breedList;
  }

  Future<List> petsByDisposition() async {
    List dispoList = [];
    if (filterData['petDisposition'].isNotEmpty) {
      await petsCollection
          .where('disposition', whereIn: filterData['petDisposition'])
          .get()
          .then((QuerySnapshot querySnapshot) {
        for (var doc in querySnapshot.docs) {
          dispoList.add(doc.id);
        }
      });
    }
    return dispoList;
  }

  Future<List> getDocs(List petIDs) async {
    List docsList = [];

    for (var filterID in petIDs) {
      await petsCollection
          .doc(filterID)
          .get()
          .then((DocumentSnapshot documentSnapshot) {
        if (documentSnapshot.exists) {
          docsList.add(documentSnapshot);
        }
      });
    }
    return docsList;
  }
}
