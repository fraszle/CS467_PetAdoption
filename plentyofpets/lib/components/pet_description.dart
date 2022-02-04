import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

// Class used to display and format pet's info on the pet profile page
class PetDescription extends StatelessWidget {
  Map<String, dynamic> data = {};

  PetDescription(this.data, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Text('${data['name']}', style: Theme.of(context).textTheme.headline5),
      Text('Type: ${data['type']}'),
      Text('Breed: ${data['breed']}'),
      Text('Availability: ${data['availability']}'),
      Text('Date Created: ${dateConverter(data['timestamp'])}'),
      const Text('Disposition:'),
      dispositionCol(data['disposition']),
    ]);
  }
}

// This data converter function takes a timestamp and coverts it to a
// MM/DD/YY string
String dateConverter(Timestamp tStamp) {
  DateTime tsDate = tStamp.toDate();
  String dateTime = tsDate.month.toString() +
      "/" +
      tsDate.day.toString() +
      "/" +
      tsDate.year.toString();

  return dateTime;
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