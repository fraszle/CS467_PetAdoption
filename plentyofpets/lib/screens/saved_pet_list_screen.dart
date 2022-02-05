import 'package:flutter/material.dart';

class SavedPetList extends StatelessWidget {
  const SavedPetList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Saved Pets List'),
      ),
      body: const Center(
        child: Text('Go back!'),
      ),
    );
  }
}
