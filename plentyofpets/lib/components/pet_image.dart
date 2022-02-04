import 'package:flutter/material.dart';

class PetProfileImage extends StatelessWidget {
  const PetProfileImage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
        borderRadius: BorderRadius.circular(15.0),
        child: Image.asset('assets/images/persian_cat.jpg', fit: BoxFit.cover));
  }
}
