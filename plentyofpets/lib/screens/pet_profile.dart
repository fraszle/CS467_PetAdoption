import 'package:flutter/material.dart';
import 'package:plentyofpets/components/pet_details.dart';

class PetProfile extends StatelessWidget {
  const PetProfile(this.petID, this.petBasics, {Key? key}) : super(key: key);

  final String petID;
  final Map<String, dynamic> petBasics;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Pet Profile'),
      ),
      body: PetDetails(petID, petBasics),
    );
  }
}
