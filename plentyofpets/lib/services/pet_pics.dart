import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'dart:io';

class PetPics {
  List pictures;
  List<String> picStorage = [];

  PetPics(this.pictures);

  //add pet pictures submitted in the add pet form to firebase storage
  Future<List<String>> addPetPics(id) async {
    for (var i = 0; i < pictures.length; i++) {
      var pic = pictures[i];
      var petRef = '$id/petPic$i.jpg';
      File petPic = File(pic.path);

      await firebase_storage.FirebaseStorage.instance
        .ref(petRef)
        .putFile(petPic);
      String petUrl = await downloadURL(petRef);
      picStorage.add(petUrl);
    }
    return picStorage;
  }

  //retrieve the picture URL from firebase storage
  Future downloadURL(petRef) async {
    return await firebase_storage.FirebaseStorage.instance
        .ref(petRef)
        .getDownloadURL();
  }

  //list all pics for specific pet id provided
  Future<void> listPics(id) async {
    firebase_storage.ListResult result =
        await firebase_storage.FirebaseStorage.instance.ref(id).listAll();
  }
}
