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
              backgroundImage: NetworkImage(doc['mainPhoto'] ??
                  'https://images.unsplash.com/photo-1636654129379-e7ae6f30bfd0?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=764&q=80'), // Temp image in case pet doesn't have mainPhoto
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
