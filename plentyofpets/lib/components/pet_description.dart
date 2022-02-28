import 'package:flutter/material.dart';
import 'package:plentyofpets/components/title.dart';
import 'package:plentyofpets/components/edit_pet.dart';
import 'package:plentyofpets/services/pet_database.dart';
import '../components/pet_img_carousel.dart';
import 'date_converter.dart';
import 'package:plentyofpets/screens/admin_pet_list_screen.dart';

// Class used to display and format pet's info on the pet profile page
class PetDescription extends StatelessWidget {
  const PetDescription(this.petBasics, this.petDetails, this.petID, {Key? key})
      : super(key: key);

  final Map petBasics;
  final Map petDetails;
  final String petID;

  @override
  Widget build(BuildContext context) {
    final List imgList = petDetails['photos'] ??
        [
          'https://images.unsplash.com/photo-1636654129379-e7ae6f30bfd0?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=764&q=80'
        ]; // Temp image in case a pet doesn't have an image
    return SingleChildScrollView(
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        CarouselWithIndicator(imgList),
        Padding(
            padding: const EdgeInsets.fromLTRB(40, 5, 40, 5),
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              TitleText(text: petBasics['name']),
              const SizedBox(height: 10),
              Text('Type: ${petBasics['type']}'),
              const SizedBox(height: 10),
              Text('Breed: ${petBasics['breed']}'),
              const SizedBox(height: 10),
              Text('Availability: ${petBasics['availability']}'),
              const SizedBox(height: 10),
              Text('Date Created: ${dateConverter(petBasics['timestamp'])}'),
              const SizedBox(height: 10),
              const Text('Disposition:'),
              dispositionCol(petBasics['disposition']),
              const SizedBox(height: 20),
              Text('Description: ${petDetails['description']}')
            ])),
        const SizedBox(height: 40),
        Center(
            child: FutureBuilder(
                future: DatabaseService().isAdmin(),
                builder: (BuildContext context, AsyncSnapshot snapshot) {
                  return Visibility(
                    visible: snapshot.data,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        ElevatedButton(
                          onPressed: (() {
                            DatabaseService().deletePet(petID);
                            Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) => AdminPetList()));
                          }),
                          child: const Text('Delete Pet'),
                        ),
                        ElevatedButton(
                            onPressed: (() {
                              Navigator.of(context).push(MaterialPageRoute(
                                  builder: (context) => EditPetForm(
                                      petBasics: petBasics,
                                      petDetails: petDetails,
                                      petID: petID)));
                            }),
                            child: const Text('Update Pet'))
                      ],
                    ),
                  );
                }))
      ]),
    );
  }
}

// Used to create a column of Text for each disposition item
Column dispositionCol(List disposition) {
  List<Widget> dispoList = [];

  for (var item in disposition) {
    dispoList.add(Text('- $item'));
  }

  return Column(
      crossAxisAlignment: CrossAxisAlignment.start, children: dispoList);
}
