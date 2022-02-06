import 'package:flutter/material.dart';
import 'package:plentyofpets/components/extract_petID.dart';
import 'package:plentyofpets/components/pet_profile_args.dart';
import 'package:plentyofpets/main.dart';

class PetBlurb extends StatelessWidget {
  PetBlurb(this.doc, this.petID, {Key? key}) : super(key: key);

  Map<String, dynamic> doc = {};
  String petID;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        // When a Card is tapped, we navigate to that pet's profile
        onTap: () {
          Navigator.pushNamed(context, ExtractPetID.routeName,
              arguments: PetProfileArgs(petID));
        },
        // Create a card with a ListTile that has pet info
        child: Card(
          child: ListTile(
            title:
                Text(doc['name'], style: Theme.of(context).textTheme.headline5),
            subtitle: Text(
                'Type: ${doc['type']}, Breed: ${doc['breed']}          Availability: ${doc['availability']}'),
            leading: CircleAvatar(
              backgroundImage: AssetImage('assets/images/persian_cat.jpg'),
            ),
          ),
        ));
  }
}
