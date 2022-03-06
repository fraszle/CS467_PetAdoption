import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:plentyofpets/utils/firebase_auth_util.dart';

class DatabaseService {
  final String id = '';
  User? currentUser;

  //collection reference
  final CollectionReference petsCollection =
      FirebaseFirestore.instance.collection('pets');
  final CollectionReference usersCollection =
      FirebaseFirestore.instance.collection('users');
  static final CollectionReference newsCollection =
      FirebaseFirestore.instance.collection('news');

  //returns the current user ID to be added to pet admin field
  String? getUser() {
    currentUser = FirebaseAuth.instance.currentUser;
    return currentUser!.uid;
  }

  //returns whether user is admin or not
  Future<bool> isAdmin() {
    var isAdmins = FirebaseAuthUtil.isUserAdmin();
    return isAdmins;
  }

  //returns admin info to be added to pet details field.
  Future getAdmin(admin) async {
    Map adminInfo = {'adminId': admin};
    DocumentSnapshot adminSnapshot = await usersCollection.doc('$admin').get();
    adminInfo['url'] = adminSnapshot['url'];
    adminInfo['organization'] = adminSnapshot['organization'];
    return adminInfo;
  }

  //adds new pet and captures pet id from add pet form
  Future addPet(var type, var availability, var disposition, var breed,
      var name, admin) async {
    return await petsCollection.add({
      'type': type,
      'availability': availability,
      'disposition': disposition,
      'breed': breed,
      'name': name,
      'timestamp': FieldValue.serverTimestamp(),
      'admin': admin,
    }).then((value) {
      return value.id;
    });
  }

  //adds pet detail to pet with pet id from add pet form
  //makes additional call to add main photo to pets collection doc
  Future addPetDetails(
      var petId, var description, var name, var adminInfo, var photos) async {
    return await petsCollection.doc(petId).collection('pet_details').add({
      'description': description,
      'name': name,
      'admin': adminInfo,
      'photos': photos
    }).then((value) async {
      return await petsCollection
        .doc(petId)
        .set({'mainPhoto': photos[0]}, SetOptions(merge: true));
    });
  }

  //adds new pet and captures pet id from add pet form
  Future editPet(var type, var availability, var disposition, var breed,
      var name, admin, var petID, var adminInfo, var description) async {
    dynamic petDetailDocName;
    return await petsCollection.doc('$petID').update({
      'type': type,
      'availability': availability,
      'disposition': disposition,
      'breed': breed,
      'name': name,
      'timestamp': FieldValue.serverTimestamp(),
      'admin': admin,
    }).then((pet) async {
        await petsCollection
          .doc('$petID')
          .collection('pet_details')
          .get()
          .then((value) {
        petDetailDocName = value.docs[0].id;
        return petsCollection
          .doc('$petID')
          .collection('pet_details')
          .doc('$petDetailDocName')
          .update({
            'description': description,
            'name': name,
            'admin': adminInfo,
          });
        });
    });
  }

  //returns a list of favorite pet docs from firebase
  Future<List<dynamic>> favPetDocs(favPets) async {
    List<dynamic> listFavPetDocs = [];
    for (String pet in favPets) {
      DocumentSnapshot documentSnapshot =
          await FirebaseFirestore.instance.collection('pets').doc(pet).get();
      listFavPetDocs.add(documentSnapshot);
    }
    return listFavPetDocs;
  }

  //add a pet to a user's favorites
  Future addFav(petId) async {
    var userid = getUser();
    return await usersCollection.doc(userid).update({
      'favs': FieldValue.arrayUnion(['$petId'])
    });
  }

  //deletes a pet from a user's favorites
  Future deleteFav(petId) async {
    var userid = getUser();
    return await usersCollection.doc(userid).update({
      'favs': FieldValue.arrayRemove(['$petId'])
    });
  }

  //deletes a pet's doc and all docs from sub-collections
  Future deletePet(petId) {
    return petsCollection
        .doc(petId)
        .collection('pet_details')
        .get()
        .then((val) {
      for (var doc in val.docs) {
        petsCollection
            .doc(petId)
            .collection('pet_details')
            .doc(doc.id)
            .delete();
      }
      petsCollection.doc(petId).delete();
    });
  }

  //creates a list of pet docs from a list of pet id's
  Future<List> userPetFavs() {
    var userid = getUser();
    return FirebaseFirestore.instance
        .collection('users')
        .doc('$userid')
        .get()
        .then((DocumentSnapshot documentSnapshot) {
      return documentSnapshot.get(FieldPath(const ['favs']));
    });
  }

  static void addNews(String title, String article, String organization) async {
    await newsCollection.add({
      'title': title,
      'article': article,
      'organization': organization,
      'timestamp': FieldValue.serverTimestamp()
    });
  }
}
