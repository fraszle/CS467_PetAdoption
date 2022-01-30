import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';

class AddPetScreen extends StatefulWidget {
  const AddPetScreen({Key? key}) : super(key: key);
  @override
  _AddPetScreenState createState() => _AddPetScreenState();
}


class _AddPetScreenState extends State<AddPetScreen> {
  final _petFormKey = GlobalKey<FormBuilderState>();
  final List<String> availableOptions=['Not Available','Available','Pending','Adopted'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Pet Information'),
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(25.0), 
            child: FormBuilder(
              key: _petFormKey, 
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch, 
                children: <Widget>[
                  
                  const Text(
                    'Pet Profile Form',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 40,
                      fontWeight: FontWeight.bold
                    ),
                  ),

                  const Text(
                    'Please complete the information to include in your pet\'s adoption profile',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.blue,
                      fontSize: 20,
                      fontWeight: FontWeight.bold
                    ),
                  ),
                  
                  const Padding(padding: EdgeInsets.fromLTRB(0,5,0,35),),

                  FormBuilderChoiceChip(
                    name: 'petType',
                    decoration: const InputDecoration(
                      labelText: 'Pet Type:',
                      labelStyle: TextStyle(
                        color: Colors.black,
                        fontSize: 20,
                        fontWeight: FontWeight.bold
                      ),
                      contentPadding: EdgeInsets.symmetric(horizontal: 60),
                    ),  
                    options: const [
                      FormBuilderFieldOption(value:'Cat', child: Text('Cat🐱')),
                      FormBuilderFieldOption(value: 'Dog', child: Text('Dog🐶')),
                      FormBuilderFieldOption(value: 'Other', child: Text('Other🦄')),
                    ],
                  ),  
                  const SizedBox(height: 20),
                  
                  FormBuilderRadioGroup(
                    name: 'Age',
                    decoration: const InputDecoration(
                      labelText: 'Age:',
                      labelStyle: TextStyle(
                        color: Colors.black,
                        fontSize: 20,
                        fontWeight: FontWeight.bold
                      ),
                      contentPadding: EdgeInsets.symmetric(horizontal: 100),
                    ),    
                    options: const [
                      FormBuilderFieldOption(value:'Baby', child: Text('Baby')),
                      FormBuilderFieldOption(value: 'Young', child: Text('Young')),
                      FormBuilderFieldOption(value: 'Mature', child: Text('Mature')),
                      FormBuilderFieldOption(value: 'Senior', child: Text('Senior')),
                    ],
                  ),
                  const SizedBox(height: 20),

                  FormBuilderDropdown(
                    name: 'Availability', 
                    decoration: const InputDecoration(
                      labelText: 'Availability',
                      labelStyle: TextStyle(
                        fontSize: 15,
                      ),
                      contentPadding: EdgeInsets.symmetric(horizontal: 110),
                    ),   
                    allowClear: true,
                    //hint: const Text('Use the dropdown to select adoption status'),
                    items: availableOptions.map((availability)=> DropdownMenuItem(
                      value: availability,
                      child: Text(availability),)).toList(),
                  ),
                  const SizedBox(height: 20),
 
                  FormBuilderFilterChip(
                    name: 'Disposition',
                    decoration: const InputDecoration(
                      labelText: 'Disposition',
                      labelStyle: TextStyle(
                        color: Colors.black,
                        fontSize: 20,
                        fontWeight: FontWeight.bold
                      ),
                    contentPadding: EdgeInsets.symmetric(horizontal: 25),
                    ),    
                    options: const [
                      FormBuilderFieldOption(value:'Kids', child: Text('Good with Kids')),
                      FormBuilderFieldOption(value: 'other animals', child: Text('Good with other animals')),
                      FormBuilderFieldOption(value: 'leashed', child: Text('Must be leashed')),
                      FormBuilderFieldOption(value: 'House-Trained', child: Text('House-Trained')),
                      FormBuilderFieldOption(value: 'Exercise', child: Text('Needs regular exercise')),
                      FormBuilderFieldOption(value: 'Calm', child: Text('Calm')),
                    ],
                  ),
                  const SizedBox(height: 20),
                  
                  FormBuilderTextField(
                    name: 'Breed' ,
                    decoration: const InputDecoration(
                      labelText: 'Breed',
                      labelStyle: TextStyle(
                        fontSize: 15,
                      ),
                      contentPadding: EdgeInsets.symmetric(horizontal: 142),
                    ),
                  ),
                  const SizedBox(height: 20),
                  
                  FormBuilderTextField(
                    name: 'Location' ,
                    decoration: const InputDecoration(
                      labelText: 'Location',
                      labelStyle: TextStyle(
                        fontSize: 15,
                      ),
                      contentPadding: EdgeInsets.symmetric(horizontal: 135),
                    ),
                  ),
                  const SizedBox(height: 20),
                  
                  FormBuilderTextField(
                    name: 'Pet Name' ,
                    decoration: const InputDecoration(
                      labelText: 'Enter Pet Name',
                      labelStyle: TextStyle(
                        fontSize: 15,
                        //fontWeight: FontWeight.bold
                      ),
                      contentPadding: EdgeInsets.symmetric(horizontal: 115), 
                    ),
                  ),
                  const SizedBox(height: 20),
                  
                  FormBuilderTextField(
                    name: 'Description' ,
                    decoration: const InputDecoration(
                      labelText: 'Full Description',
                      labelStyle: TextStyle(
                        fontSize: 15,
                      ),
                      //contentPadding: EdgeInsets.symmetric(horizontal: 115),
                    ),
                    maxLines: 3,
                    keyboardType: TextInputType.multiline,
                  ),
                  
                  ElevatedButton(onPressed: () {}, child: const Text('Submit'),),
                ],
              ),
              // onChanged: (){
              //   const snackBar = SnackBar(
              //     content: Text('The form has been changed'),
              //   );
              //   ScaffoldMessenger.of(context).showSnackBar(snackBar);
              //},
            ),
          ),
        ),
    );
  }
}
