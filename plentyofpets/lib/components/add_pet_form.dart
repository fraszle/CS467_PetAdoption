
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_image_picker/form_builder_image_picker.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

import 'package:plentyofpets/theme.dart';
import 'package:plentyofpets/screens/admin_homepage.dart';
import 'package:plentyofpets/services/pet_database.dart';
import 'package:plentyofpets/services/pet_pics.dart';


class AddPetForm extends StatefulWidget {
  const AddPetForm({Key? key}) : super(key: key);
  @override
  _AddPetFormState createState() => _AddPetFormState();
}

class _AddPetFormState extends State<AddPetForm> {
  final _petFormKey = GlobalKey<FormBuilderState>();
  final List<String> availableOptions = [
    'Not Available',
    'Available',
    'Pending',
    'Adopted'
  ];
  String? petType;
  Map<String, dynamic> petFormData = {};
  dynamic adminUser;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Image.asset(
          'assets/images/plentyOfPetsPic.png',
          height: 60,
          width: 60,
        ),
        FormBuilder(
          key: _petFormKey,
          child: SingleChildScrollView(
            child: Column(
              children: <Widget>[
                Text(
                  'Pet Profile Form',
                  textAlign: TextAlign.center,
                  style: PlentyOfPetsTheme.petFormTitle,
                ),
                Text(
                  'Please complete the information to include in your pet\'s adoption profile',
                  textAlign: TextAlign.center,
                  style: PlentyOfPetsTheme.petFormSubheading,
                ),
                const Padding(
                  padding: EdgeInsets.fromLTRB(0, 5, 0, 35),
                ),
                
                FormBuilderTextField(
                    name: 'Pet Name',
                    autofocus: true,
                    decoration: const InputDecoration(
                        labelText: 'Pet Name', border: OutlineInputBorder()),
                    textInputAction: TextInputAction.next,
                    validator: FormBuilderValidators.compose([
                      FormBuilderValidators.required(context,
                          errorText: 'Required'),
                      FormBuilderValidators.maxLength(context, 13,
                          errorText: 'Name is too long'),
                    ])),
                const SizedBox(height: 10),
                
                FormBuilderChoiceChip(
                  name: 'petType',
                  decoration: const InputDecoration(
                    labelText: 'Pet Type:',
                    labelStyle: TextStyle(
                        color: Colors.black,
                        fontSize: 20,
                        fontWeight: FontWeight.bold),
                    contentPadding: EdgeInsets.symmetric(horizontal: 60),
                  ),
                  options: const [
                    FormBuilderFieldOption(value: 'Cat', child: Text('Cat🐱')),
                    FormBuilderFieldOption(value: 'Dog', child: Text('Dog🐶')),
                    FormBuilderFieldOption(
                        value: 'Other', child: Text('Other🦄')),
                  ],
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  validator: FormBuilderValidators.required(context,
                      errorText: 'required'),
                ),
                const SizedBox(height: 10),
                
                FormBuilderTextField(
                  name: 'Breed',
                  decoration: const InputDecoration(
                      labelText: 'Breed', border: OutlineInputBorder()),
                  textInputAction: TextInputAction.next,
                  validator: FormBuilderValidators.required(context,
                      errorText: 'required'),
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
                  items: availableOptions
                      .map((availability) => DropdownMenuItem(
                            value: availability,
                            child: Text(availability),
                          ))
                      .toList(),
                  validator: FormBuilderValidators.required(context,
                      errorText: 'required'),
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
                    FormBuilderFieldOption(
                        value: 'Kids', child: Text('Good with Kids')),
                    FormBuilderFieldOption(
                        value: 'other animals',
                        child: Text('Good with other animals')),
                    FormBuilderFieldOption(
                        value: 'leashed', child: Text('Must be leashed')),
                    FormBuilderFieldOption(
                        value: 'House-Trained', child: Text('House-Trained')),
                    FormBuilderFieldOption(
                        value: 'Exercise',
                        child: Text('Needs regular exercise')),
                    FormBuilderFieldOption(value: 'Calm', child: Text('Calm')),
                  ],
                ),
                const SizedBox(height: 10),
                
                FormBuilderTextField(
                    name: 'Description',
                    decoration: const InputDecoration(
                      labelText: 'Description of pet',
                    ),
                    maxLines: 3,
                    keyboardType: TextInputType.multiline,
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    validator: FormBuilderValidators.required(context,
                        errorText: 'required')),
                
                FormBuilderImagePicker(
                  name: 'photos',
                  decoration:
                      const InputDecoration(labelText: 'Pick Photos(up to 3)'),
                  maxImages: 3,
                ),
                
                ElevatedButton(
                    onPressed: () async { 
                      //create instance of database object
                      var currentPet = DatabaseService();
                      
                      //retrieve user for database calls
                      adminUser = currentPet.getUser();

                      //save form and retrieve form values
                      _petFormKey.currentState!.save();
                      petFormData = _petFormKey.currentState!.value;

                      //adds data from pet form to pets collection
                      if (_petFormKey.currentState!.validate()) {
                        EasyLoading.show(status: 'loading...');
                        
                        var id = await currentPet.addPet(
                          petFormData['petType'],
                          petFormData['Availability'],
                          petFormData['Disposition'],
                          petFormData['Breed'],
                          petFormData['Pet Name'],
                          adminUser,
                        );

                        //adds pics to firebase storage and pet detail subcollection
                        List<String> picStorage = [];
                        if (petFormData['photos'] != null) {
                          picStorage = await PetPics(petFormData['photos'])
                              .addPetPics(id);
                        }

                        //gets admin info from firebase
                        Map adminInfo = await currentPet.getAdmin(adminUser);

                        //adds pet form info to pet details sub collection
                        currentPet.addPetDetails(
                          id,
                          petFormData['Description'],
                          petFormData['Pet Name'],
                          adminInfo,
                          picStorage,
                        );

                        EasyLoading.dismiss();
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => const AdminHomepage()));
                      }
                    },
                    child: const Text('Submit Form')),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
