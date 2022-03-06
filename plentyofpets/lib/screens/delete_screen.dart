import 'package:flutter/material.dart';

import 'package:plentyofpets/theme.dart';
import 'package:plentyofpets/services/pet_database.dart';
import 'package:plentyofpets/screens/admin_pet_list_screen.dart';

class Delete extends StatelessWidget {
  final Map petBasics;
  final String petID;
  
  const Delete({required this.petBasics, required this.petID,Key? key }) : 
    super(key: key);


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            const Padding(padding: EdgeInsets.all(15)),
            const Icon(Icons.warning,
            size: 250,
            color: Color.fromARGB(255, 175, 14, 2),
            ),
            Text('Are you sure you would like to delete ${petBasics['name']}?',
              style:PlentyOfPetsTheme.petFormTitle,
              textAlign: TextAlign.center,),
            ElevatedButton(
              onPressed: ((){
                DatabaseService().deletePet(petID);
                Navigator.pushAndRemoveUntil(context,   
                  MaterialPageRoute(builder: (BuildContext context) => const AdminPetList()), 
                  ModalRoute.withName('/admin')
                );
              }),
              child: const Text('Yes, Delete'),
            ),
          ]),
      ),
    );
  }
}