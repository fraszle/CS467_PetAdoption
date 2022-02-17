import 'package:flutter/material.dart';
import 'package:plentyofpets/components/pet_profile_args.dart';
import '../screens/pet_profile.dart';

// A Widget that extracts the necessary arguments from
// the ModalRoute.

class ExtractPetBasics extends StatelessWidget {
  const ExtractPetBasics({Key? key}) : super(key: key);

  static const routeName = '/extractPetBasics';

  @override
  Widget build(BuildContext context) {
    // Extract the arguments from the current ModalRoute
    // settings and cast them as PetProfileArgs.
    final args = ModalRoute.of(context)!.settings.arguments as PetProfileArgs;

    // Create a pet profile based on petID argument
    return PetProfile(args.petID, args.petBasicInfo);
  }
}
