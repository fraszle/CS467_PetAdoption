import 'package:flutter/material.dart';
import 'package:plentyofpets/components/add_pet_form.dart';


class AddPetScreen extends StatefulWidget {
  const AddPetScreen({Key? key}) : super(key: key);
  @override
  _AddPetScreenState createState() => _AddPetScreenState();
}

class _AddPetScreenState extends State<AddPetScreen> {
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Pet Information'),
          centerTitle: true,
        ),
        body: const SingleChildScrollView(
        padding: EdgeInsets.all(25.0),
          child: AddPetForm(),
        ),
    );
  }
}
