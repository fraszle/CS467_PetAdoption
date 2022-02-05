import 'package:flutter/material.dart';
import 'package:plentyofpets/models/pet_model.dart';
import 'package:provider/provider.dart';


class PetList extends StatefulWidget {
  const PetList({ Key? key }) : super(key: key);

  @override
  _PetListState createState() => _PetListState();
}

class _PetListState extends State<PetList> {
  @override
  Widget build(BuildContext context) {
    final pets = Provider.of<List<Pets>>(context);
    pets.forEach((pets){
      print(pets.name);
    });

    return Container(
    );
  }
}