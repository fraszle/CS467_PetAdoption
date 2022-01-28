import 'package:flutter/material.dart';

class PetProfile extends StatelessWidget {
  const PetProfile({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Plenty of Pets'),
      ),
      body: Center(
          child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: const [
            Text('Name:', style: TextStyle(fontSize: 25)),
            Image(
              image: NetworkImage(
                  'https://flutter.github.io/assets-for-api-docs/assets/widgets/owl.jpg'),
            ),
            Text('Age:', style: TextStyle(fontSize: 25)),
            Text('Type:', style: TextStyle(fontSize: 25)),
            Text('Breed:', style: TextStyle(fontSize: 25)),
            Text('Availability:', style: TextStyle(fontSize: 25)),
            Text('Disposition:', style: TextStyle(fontSize: 25)),
            Text('Description:', style: TextStyle(fontSize: 25)),
            Text('Date Created:', style: TextStyle(fontSize: 25)),
            Text('Organization:', style: TextStyle(fontSize: 25))
          ])),
    );
  }
}
