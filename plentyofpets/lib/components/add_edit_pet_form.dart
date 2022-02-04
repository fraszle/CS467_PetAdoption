import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:plentyofpets/lib/services/database.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:form_builder_image_picker/form_builder_image_picker.dart';
import 'package:form_builder_validators/form_builder_validators.dart';

class AddPetForm extends StatefulWidget {
  const AddPetForm({Key? key}) : super(key: key);
  @override
  _AddPetFormState createState() => _AddPetFormState();
}

class _AddPetFormState extends State<AddPetForm> {
  final _petFormKey = GlobalKey<FormBuilderState>();
  final List<String> availableOptions=['Not Available','Available','Pending','Adopted'];
  String? petType;
  Map<String,dynamic> petFormData = {};
  
  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Image.asset('assets/images/plentyOfPetsPic.png',
          height: 60,
          width: 60,
          ),
        FormBuilder(
          key: _petFormKey,
          child:
            SingleChildScrollView(
              child: Column(
                children:<Widget>[
                  
                  const Text( 'Pet Profile Form',
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

                  FormBuilderTextField(
                    name: 'Pet Name' ,
                    autofocus: true,
                    decoration: const InputDecoration(
                      labelText: 'Pet Name',
                      border: OutlineInputBorder() 
                    ),
                    textInputAction: TextInputAction.next,
                    //autovalidateMode: AutovalidateMode.onUserInteraction,
                    validator: FormBuilderValidators.required(context, 
                      errorText: 'required')
                  ),
                  const SizedBox(height: 10),

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
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    validator: FormBuilderValidators.required(context, 
                      errorText: 'required'),
                  ),  
                  const SizedBox(height: 10),

                  FormBuilderTextField(
                    name: 'Breed' ,
                    decoration: const InputDecoration(
                      labelText: 'Breed',
                      border: OutlineInputBorder()
                    ),
                    textInputAction: TextInputAction.next,
                    validator: FormBuilderValidators.required(context, errorText: 'required'),
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                  ),
                  const SizedBox(height: 10),
                  
                  //potential stretch
                  // FormBuilderChoiceChip(
                  //   name: 'Age',
                  //   decoration: const InputDecoration(
                  //     labelText: 'Age:',
                  //     labelStyle: TextStyle(
                  //       color: Colors.black,
                  //       fontSize: 20,
                  //       fontWeight: FontWeight.bold
                  //     ),
                  //     contentPadding: EdgeInsets.symmetric(horizontal: 50),
                  //   ),    
                  //   options: const [
                  //     FormBuilderFieldOption(value:'Baby', child: Text('Baby')),
                  //     FormBuilderFieldOption(value: 'Young', child: Text('Young')),
                  //     FormBuilderFieldOption(value: 'Mature', child: Text('Mature')),
                  //     FormBuilderFieldOption(value: 'Senior', child: Text('Senior')),
                  //   ],
                  //   validator: FormBuilderValidators.required(context, errorText: 'required')
                  // ),
                  // const SizedBox(height: 10),

                  FormBuilderDropdown(
                    name: 'Availability', 
                    decoration: const InputDecoration(
                      labelText: 'Availability',
                      labelStyle: TextStyle(
                        fontSize: 15,
                      ),
                      //contentPadding: EdgeInsets.symmetric(horizontal: 110),
                    ),   
                    allowClear: true,
                    items: availableOptions.map((availability)=> DropdownMenuItem(
                      value: availability,
                      child: Text(availability),)).toList(),
                    validator: FormBuilderValidators.required(context, errorText: 'required'),
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                  ),
                  const SizedBox(height: 10),

                  FormBuilderFilterChip(
                    name: 'Disposition',
                    decoration: const InputDecoration(
                      labelText: 'Disposition',
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
                  const SizedBox(height: 10),

                  //potential stretch
                  // const Text('Location'),
                  // FormBuilderTextField(
                  //   name: 'State' ,
                  //   decoration: const InputDecoration(
                  //     labelText: 'State',
                  //     border: OutlineInputBorder()
                  //   ),
                  //   textInputAction: TextInputAction.next,
                  //   validator: FormBuilderValidators.required(context, errorText: 'required')
                  //   ),
                  // //const SizedBox(height: 20),
                  // FormBuilderTextField(
                  //   name: 'Zip' ,
                  //   decoration: const InputDecoration(
                  //     labelText: 'Zip',
                  //     border: OutlineInputBorder()
                  //   ),
                  //   textInputAction: TextInputAction.next,
                  //   validator: FormBuilderValidators.required(context, errorText: 'required')
                  // ),
                  // //const SizedBox(height: 20),

                  FormBuilderTextField(
                    name: 'Description' ,
                    decoration: const InputDecoration(
                      labelText: 'Description of pet',
                    ),
                    maxLines: 3,
                    keyboardType: TextInputType.multiline,
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    validator: FormBuilderValidators.required(context, 
                      errorText: 'required')
                  ),
                  
                  FormBuilderImagePicker(
                  name: 'photos',
                  decoration: const InputDecoration(labelText: 'Pick Photos(up to 5)'),
                  maxImages: 5,
                ),

                  ElevatedButton(
                    onPressed: () {
                      //petType = _petFormKey.currentState!.fields['petType']!.value ?? '';
                      _petFormKey.currentState!.save();
                      petFormData = _petFormKey.currentState!.value;
                      
                      final newPet = FirebaseFirestore.instance.collection('pets');
                      newPet.add({
                          'type': petFormData['PetType'],
                          'availability': petFormData['Availability'],
                          'disposition': petFormData['Disposition'],
                          'breed': petFormData['Breed'],
                          'name': petFormData['Pet Name'],
                          'description': petFormData['Description'],
                          'timestamp': FieldValue.serverTimestamp(),
                          '?':newPet.id
                      })
                      // FirebaseFirestore.instance.collection('pets').doc(newPet.id).
                      //   collection('petDetail').add({
                      //     'description': petFormData['Description'],
                      //     'name': petFormData['Pet Name'],
                      //     'admin': {'AdminID':'To', 'Org': 'be', 'web':'url'},
                      //     'pic': ['to', 'be', 'added'],
                      //     'news': 'to be added',

                      // })

                        .then((valueD)=>print(newPet.id));
                          // final newPetProfile = newPet.documentID
                          //   FirebaseFirestore.instance.collection('pets').doc('$newPetProfile') 
                    }, 
                    child: const Text('Submit Form')
                  ),
                ],
              ),
            ),
        ),
      ],
    );
  }
}
