import 'package:cloud_firestore/cloud_firestore.dart';

class BuildFilterQuery {
  BuildFilterQuery({required this.filterData});

  final Map<String, dynamic> filterData;

  List distinctPetID = [];
  List petDocs = [];

  // Map of pet types to breeds
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

  // Collection reference
  final CollectionReference petsCollection =
      FirebaseFirestore.instance.collection('pets');

  // Function to get a list of filtered pet ids and pet docs
  Future<List> getFilteredPets() async {
    List petID = [];

    // Get pet ids based on type
    await petsCollection
        .where('type', isEqualTo: filterData['petType'])
        .get()
        .then((QuerySnapshot querySnapshot) {
      for (var doc in querySnapshot.docs) {
        petID.add(doc.id);
      }
    });

    // If pet breeds were chosen, then get those ids
    if (filterData['petBreed'].isNotEmpty) {
      List breedList = await petsByBreed(filterData['petType']);
      // Only keep ids that intersect across type and breed
      petID = petID.toSet().intersection(breedList.toSet()).toList();
    }

    // If dispositions were chosen, get those ids
    if (filterData['petDisposition'].isNotEmpty) {
      List dispoList = await petsByDisposition();
      // Only keep ids that intersect across type, breed, and disposition
      petID = petID.toSet().intersection(dispoList.toSet()).toList();
    }

    // Get the pet documents that correspond to filtered ids
    petDocs = await getDocs(petID);
    return petDocs;
  }

  // Get a list of pet ids based on breed filters
  Future<List> petsByBreed(String petType) async {
    List breedList = [];

    // Get any pets that aren't in the common breeds list
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
    // Get any pets that are in the common breeds list
    await petsCollection
        .where('breed', whereIn: filterData['petBreed'])
        .get()
        .then((QuerySnapshot querySnapshot) {
      for (var doc in querySnapshot.docs) {
        breedList.add(doc.id);
      }
    });
    return breedList;
  }

  // Get a list of pet ids based on disposition filters
  Future<List> petsByDisposition() async {
    List dispoList = [];
    await petsCollection
        .where('disposition', isEqualTo: filterData['petDisposition'])
        .get()
        .then((QuerySnapshot querySnapshot) {
      for (var doc in querySnapshot.docs) {
        dispoList.add(doc.id);
      }
    });
    return dispoList;
  }

  // Get pet documents that correspond to the inputted list of pet ids
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
