import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'dart:io';
import 'package:image_picker/image_picker.dart';

class PetPics{
  List pictures;
  List<String> picStorage = [];

  PetPics(this.pictures);

  List<String> addPetPics(id){ 
    for(var i=0; i < pictures.length; i++){
      var pic = pictures[i];
      File petPic = File(pic.path);
      firebase_storage.FirebaseStorage.instance
        .ref('$id/petPic$i.jpg')
        .putFile(petPic);
      picStorage.add('$id/petPic$i.jpg');
    };
    return picStorage;
  }
}