
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:plentyofpets/services/database.dart';
import 'package:provider/provider.dart';
import 'package:plentyofpets/components/petList.dart';

class PetFavorite extends StatelessWidget {
  const PetFavorite({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {

    return StreamBuilder<QuerySnapshot>(
      stream: 
      builder:
    )
    // return StreamProvider<List<Pets>>.value(
    //   value:DatabaseService().pets,
    //   child:Scaffold(
    //     appBar: Appbar(
    //       title: Text('Favorite Pets')
    //     ),
    //     body: PetList(),
    //   )
    // )
      
    // );
  }
}