import 'package:flutter/material.dart';
import 'package:plentyofpets/components/admin_homepage_buttons.dart';
import '../components/decorations.dart';

class AdminHomepage extends StatelessWidget {
  const AdminHomepage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: const Text('Admin Homepage'),
        ),
        body: SizedBox(
          child: Column(
            children: [
              const SizedBox(
                height: 100,
              ),
              // App logo will go here!
              const PawPrint(angle: 0),
              const SizedBox(
                height: 100,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  AddPetCardButton(buttonText: 'Add a Pet'),
                  EditPetListCardButton(buttonText: 'Edit Pet List')
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  AddNewsCardButton(buttonText: 'Add News'),
                  AccountProfileCardButton(buttonText: 'Account Info')
                ],
              )
            ],
          ),
        ));
  }
}
