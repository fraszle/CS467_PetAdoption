import 'package:flutter/material.dart';

class UserProfile extends StatelessWidget {
  const UserProfile({Key? key}) : super(key: key);

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
            Text('First Name:', style: TextStyle(fontSize: 25)),
            Text('Last Name:', style: TextStyle(fontSize: 25)),
            Image(
              image: NetworkImage(
                  'https://images.unsplash.com/photo-1642698335289-e9073f8afb03?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=687&q=80'),
            ),
            Text('Email:', style: TextStyle(fontSize: 25)),
            Text('Location:', style: TextStyle(fontSize: 25)),
          ])),
    );
  }
}
