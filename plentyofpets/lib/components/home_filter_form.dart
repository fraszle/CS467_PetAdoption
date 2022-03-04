import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:plentyofpets/components/build_filter_query.dart';
import 'package:plentyofpets/screens/home_screen.dart';

class HomeFilterForm extends StatefulWidget {
  const HomeFilterForm({Key? key}) : super(key: key);

  @override
  _HomeFilterFormState createState() => _HomeFilterFormState();
}

class _HomeFilterFormState extends State<HomeFilterForm> {
  final _filterFormKey = GlobalKey<FormBuilderState>();

  Map<String, dynamic> filterFormData = {};

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      FormBuilder(
          key: _filterFormKey,
          child: SingleChildScrollView(
              child: Column(children: <Widget>[
            const Text(
              'Filter Pet List',
              textAlign: TextAlign.center,
              style: TextStyle(
                  color: Colors.black,
                  fontSize: 40,
                  fontWeight: FontWeight.bold),
            ),
            const Padding(
              padding: EdgeInsets.fromLTRB(0, 5, 0, 35),
            ),
            FormBuilderChoiceChip(
              name: 'petType',
              decoration: const InputDecoration(
                  labelText: 'Pet Type:',
                  labelStyle: TextStyle(
                      color: Colors.black,
                      fontSize: 20,
                      fontWeight: FontWeight.bold)),
              options: const [
                FormBuilderFieldOption(value: 'Cat', child: Text('Cat🐱')),
                FormBuilderFieldOption(value: 'Dog', child: Text('Dog🐶')),
                FormBuilderFieldOption(value: 'Other', child: Text('Other🦄')),
              ],
              autovalidateMode: AutovalidateMode.onUserInteraction,
              validator: FormBuilderValidators.required(context,
                  errorText: 'Required!'),
              onChanged: (val) {
                setState(() {
                  _filterFormKey.currentState?.fields['petBreed']?.reset();
                });
              },
            ),
            const SizedBox(height: 10),
            FormBuilderFilterChip(
                name: 'petBreed',
                decoration: const InputDecoration(
                  labelText: 'Pet Breed:',
                  labelStyle: TextStyle(
                      color: Colors.black,
                      fontSize: 20,
                      fontWeight: FontWeight.bold),
                ),
                options: displayBreeds(context)),
            FormBuilderFilterChip(
              name: 'petDisposition',
              decoration: const InputDecoration(
                labelText: 'Disposition:',
                labelStyle: TextStyle(
                    color: Colors.black,
                    fontSize: 20,
                    fontWeight: FontWeight.bold),
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
                    value: 'Exercise', child: Text('Needs regular exercise')),
                FormBuilderFieldOption(value: 'Calm', child: Text('Calm')),
              ],
            ),
            FormBuilderDateRangePicker(
                name: 'petDate',
                firstDate: DateTime(1970),
                lastDate: DateTime.now(),
                format: DateFormat('yyyy-MM-dd'),
                pickerBuilder: (context, child) {
                  return Theme(
                      data: Theme.of(context).copyWith(
                        textTheme: ThemeData.light().textTheme.apply(
                              fontFamily: 'Lato',
                            ),
                      ),
                      child: child!);
                },
                decoration: const InputDecoration(
                  labelText: 'Date Range (Click to select a date range)',
                  labelStyle: TextStyle(
                      color: Colors.black,
                      fontSize: 20,
                      fontWeight: FontWeight.bold),
                )),
            ElevatedButton(
                onPressed: () async {
                  _filterFormKey.currentState?.save();
                  if (_filterFormKey.currentState!.validate()) {
                    filterFormData = _filterFormKey.currentState!.value;
                    List petDocs =
                        await BuildFilterQuery(filterData: filterFormData)
                            .getFilteredPets();
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>
                                HomeScreen(tabIndex: 0, petDocs: petDocs)));
                  } else {
                    ErrorHint("Pet type is required!");
                  }
                },
                child: const Text('Submit'))
          ])))
    ]);
  }

  List<FormBuilderFieldOption<String>> displayBreeds(BuildContext context) {
    if (_filterFormKey.currentState?.fields['petType']?.value == null) {
      return [
        const FormBuilderFieldOption(
            value: 'No selection', child: Text('Select a pet type'))
      ];
    } else if (_filterFormKey.currentState?.fields['petType']?.value == 'Cat') {
      return const [
        FormBuilderFieldOption(value: 'Persian', child: Text('Persian')),
        FormBuilderFieldOption(value: 'Maine Coon', child: Text('Maine Coon')),
        FormBuilderFieldOption(value: 'Siamese', child: Text('Siamese')),
        FormBuilderFieldOption(value: 'Ragdoll', child: Text('Ragdoll')),
        FormBuilderFieldOption(value: 'Sphynx', child: Text('Sphynx')),
        FormBuilderFieldOption(
            value: 'Domestic Shorthair', child: Text('Domestic Shorthair')),
        FormBuilderFieldOption(value: 'Other', child: Text('Other'))
      ];
    } else if (_filterFormKey.currentState?.fields['petType']?.value == 'Dog') {
      return const [
        FormBuilderFieldOption(
            value: 'Golden Retriever', child: Text('Golden Retriever')),
        FormBuilderFieldOption(value: 'Lab', child: Text('Lab')),
        FormBuilderFieldOption(value: 'Pit Mix', child: Text('Pit Mix')),
        FormBuilderFieldOption(value: 'Chihuahua', child: Text('Chihuahua')),
        FormBuilderFieldOption(value: 'Corgi', child: Text('Corgi')),
        FormBuilderFieldOption(
            value: 'German Shepherd', child: Text('German Shepherd')),
        FormBuilderFieldOption(value: 'Other', child: Text('Other'))
      ];
    } else {
      return const [
        FormBuilderFieldOption(value: 'Hamster', child: Text('Hamster')),
        FormBuilderFieldOption(value: 'Guinea Pig', child: Text('Guinea Pig')),
        FormBuilderFieldOption(value: 'Parakeet', child: Text('Parakeet')),
        FormBuilderFieldOption(value: 'Rabbit', child: Text('Rabbit')),
        FormBuilderFieldOption(value: 'Other', child: Text('Other'))
      ];
    }
  }
}
