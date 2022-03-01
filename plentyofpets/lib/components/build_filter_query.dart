import 'package:cloud_firestore/cloud_firestore.dart';

class BuildFilterQuery {
  BuildFilterQuery({required this.filterData});

  final Map<String, dynamic> filterData;

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

    // If a date range was chosen, get those ids
    if (filterData['petDate'] != null) {
      List dateList = await petsByDates();
      // Only keep ids that intersect across type, breed, disposition, and dates
      petID = petID.toSet().intersection(dateList.toSet()).toList();
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
    List tempList = [];
    for (var i = 0; i < filterData['petDisposition'].length; i++) {
      await petsCollection
          .where('disposition', arrayContains: filterData['petDisposition'][i])
          .get()
          .then((QuerySnapshot querySnapshot) {
        for (var doc in querySnapshot.docs) {
          if (i == 0) {
            dispoList.add(doc.id);
          } else {
            tempList.add(doc.id);
          }
        }
        // Only keep pet ids that, at minimum, have all of the selected
        // dispositions
        if (tempList.isNotEmpty) {
          dispoList = dispoList.toSet().intersection(tempList.toSet()).toList();
          tempList = [];
        }
      });
    }
    return dispoList;
  }

  // Get a list of pet ids based on date range filter
  Future<List> petsByDates() async {
    DateTime start = filterData['petDate'].start;
    DateTime end = filterData['petDate'].end;

    // End needs to be adjusted to be the end of the day, when extracted from
    // filter data it's defaulted to 12AM of that date
    DateTime endAdjusted = end.add(
        const Duration(hours: 23, minutes: 59, seconds: 59, milliseconds: 999));

    // Convert to Timestamp because dates are stored as Timestamp in db
    Timestamp tsStart = Timestamp.fromDate(start);
    Timestamp tsEnd = Timestamp.fromDate(endAdjusted);

    // Have to do two separate queries for start and end
    List dateGreaterThanStart = await petDateGreaterThan(tsStart);
    List dateLessThanEnd = await petDateLessThan(tsEnd);

    // Combine the queries to get ids that fall within the date range
    List dateList = dateGreaterThanStart
        .toSet()
        .intersection(dateLessThanEnd.toSet())
        .toList();

    return dateList;
  }

  // Helper function that queries db for pets added to the db after the start
  // date filter
  Future<List> petDateGreaterThan(Timestamp start) async {
    List dateList = [];

    await petsCollection
        .where('timestamp', isGreaterThanOrEqualTo: start)
        .get()
        .then((QuerySnapshot querySnapshot) {
      for (var doc in querySnapshot.docs) {
        dateList.add(doc.id);
      }
    });

    return dateList;
  }

  // Helper function that queries db for pets added to the db before the end
  // date filter
  Future<List> petDateLessThan(Timestamp end) async {
    List dateList = [];

    await petsCollection
        .where('timestamp', isLessThanOrEqualTo: end)
        .get()
        .then((QuerySnapshot querySnapshot) {
      for (var doc in querySnapshot.docs) {
        dateList.add(doc.id);
      }
    });

    return dateList;
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
