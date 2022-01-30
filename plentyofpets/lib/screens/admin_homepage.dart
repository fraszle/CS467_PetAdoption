import 'package:flutter/material.dart';

class AdminHomepage extends StatelessWidget {
  const AdminHomepage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Admin Home')
      ),
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
            const Padding(padding: EdgeInsets.all(10)),
            // Add a pet
            addPet('Add a pet'),
            const Padding(padding: EdgeInsets.all(10)),
            // Edit/Delete pet list
            addPet('Edit pet list'),
            const Padding(padding: EdgeInsets.all(10)),
            // Account information
            addPet('Account Information'),
            const Padding(padding: EdgeInsets.all(10)),
            addPet('Add to News Feed')
          ],
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
