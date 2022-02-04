import 'package:flutter/material.dart';

// Class to display the pet's image in the pet profile page
class PetProfileImage extends StatelessWidget {
  const PetProfileImage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
        borderRadius: BorderRadius.circular(15.0),
        child: Image.asset('assets/images/persian_cat.jpg', fit: BoxFit.cover));
  }
}
