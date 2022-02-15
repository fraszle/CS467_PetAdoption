import 'package:flutter/material.dart';
import '../components/pet_img_carousel.dart';
import 'date_converter.dart';

// Class used to display and format pet's info on the pet profile page
class PetDescription extends StatelessWidget {
  const PetDescription(this.petBasics, this.petDetails, {Key? key})
      : super(key: key);

  final Map petBasics;
  final Map petDetails;

  @override
  Widget build(BuildContext context) {
    // To do: create nicer profile page
    final List imgList = petDetails['photos'];
    return Column(children: [
      CarouselWithIndicator(imgList),
      Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Text(petBasics['name'], style: Theme.of(context).textTheme.headline5),
        Text('Type: ${petBasics['type']}'),
        Text('Breed: ${petBasics['breed']}'),
        Text('Availability: ${petBasics['availability']}'),
        Text('Date Created: ${dateConverter(petBasics['timestamp'])}'),
        const Text('Disposition:'),
        dispositionCol(petBasics['disposition']),
        Text(petDetails['description'])
      ])
    ]);
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
