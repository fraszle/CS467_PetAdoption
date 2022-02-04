import 'package:flutter/material.dart';

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
      Text('Date Created: ${dateConverter(data)}'),
      const Text('Disposition:'),
      dispositionCol(data['disposition']),
    ]);
  }
}

String dateConverter(Map<String, dynamic> data) {
  DateTime tsDate = data['timestamp'].toDate();
  String dateTime = tsDate.month.toString() +
      "/" +
      tsDate.day.toString() +
      "/" +
      tsDate.year.toString();

  return dateTime;
}

Column dispositionCol(List disposition) {
  List<Widget> dispoList = [];

  for (var item in disposition) {
    dispoList.add(Text('- $item'));
  }

  return Column(
      crossAxisAlignment: CrossAxisAlignment.start, children: dispoList);
}
