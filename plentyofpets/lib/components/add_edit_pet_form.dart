import 'package:flutter/material.dart';
import 'dart:io';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_image_picker/form_builder_image_picker.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:image_picker/image_picker.dart';
//import 'package:xfile/xfile.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:plentyofpets/services/pet_database.dart';
import 'package:plentyofpets/screens/admin_homepage.dart';
import 'package:plentyofpets/services/pet_pics.dart';

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

                  FormBuilderDropdown(
                    name: 'Availability', 
                    decoration: const InputDecoration(
                      labelText: 'Availability',
                      labelStyle: TextStyle(
                        fontSize: 15,
                      ),
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
                    onPressed: () async{
                      _petFormKey.currentState!.save();
                      petFormData = _petFormKey.currentState!.value;
                      if (_petFormKey.currentState!.validate()){
                        var id = await DatabaseService().addPet(
                        petFormData['petType'],
                        petFormData['Availability'],
                        petFormData['Disposition'],
                        petFormData['Breed'],
                        petFormData['Pet Name'],
                        );
                        
                        List<String> picStorage = [];
                        if (petFormData['photos'] == null){
                          picStorage[0] = 'gs:/plenty-of-pets-339013.appspot.com/Default photo/IMAGE-COMING-SOON.jpg';
                        } else{
                          picStorage = PetPics(petFormData['photos']).addPetPics(id);
                        };

                        DatabaseService().addPetDetails( 
                          id, 
                          petFormData['Description'],
                          petFormData['Pet Name'],
                          picStorage,
                        );
                        Navigator.of(context).push(
                        MaterialPageRoute(builder: (context) => const AdminHomepage()));
                      }
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
