import 'package:flutter/material.dart';
import 'package:plentyofpets/components/extract_pet_basics.dart';
import 'package:plentyofpets/components/pet_profile_args.dart';

class PetCard extends StatelessWidget {
  const PetCard(this.doc, this.petID, {Key? key}) : super(key: key);

  final Map<String, dynamic> doc;
  final String petID;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        // When a Card is tapped, we navigate to that pet's profile
        onTap: () {
          Navigator.pushNamed(context, ExtractPetBasics.routeName,
              arguments: PetProfileArgs(petID, doc));
        },
        // Create a card with a ListTile that has pet info
        child: Card(
          child: ListTile(
            title:
                Text(doc['name'], style: Theme.of(context).textTheme.headline5),
            subtitle: Text(doc['availability']),
            leading: CircleAvatar(
              backgroundImage: NetworkImage(doc['mainPhoto']),
            ),
            trailing: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text('Type: ${doc['type']}'),
                Text('Breed: ${doc['breed']}')
              ],
            ),
          ),
        ));
  }
}
