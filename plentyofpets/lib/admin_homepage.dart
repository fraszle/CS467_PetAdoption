import 'package:flutter/material.dart';

class AdminHomepage extends StatelessWidget {
  const AdminHomepage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Admin Homepage',
      home: Scaffold(
        body: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // App logo will go here!
              Image.network(
                'https://flutter.github.io/assets-for-api-docs/assets/widgets/owl-2.jpg',
                width: 100,
                height: 100,
              ),
              // Add a pet
              addPet('Add a pet'),
              // Edit/Delete pet list
              addPet('Edit pet list'),
              // Account information
              addPet('Account Information'),
              addPet('Add to News Feed')
            ],
          ),
        ),
      ),
    );
  }
}

Widget addPet(String buttonText) {
  
  return TextButton(
    style: TextButton.styleFrom(
      padding: const EdgeInsets.all(16.0),
      primary: Colors.redAccent,
      backgroundColor: Colors.brown,
      textStyle: const TextStyle(fontSize: 20),
    ),
    onPressed: () {
      print('navigate to add a new pet screen');
    },
    child: Text(buttonText),
  );
}
