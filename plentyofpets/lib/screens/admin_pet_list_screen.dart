import 'package:flutter/material.dart';
import 'package:plentyofpets/components/admin_pet_list.dart';

// Displays the entire catalog of animals an organization has
class AdminPetList extends StatelessWidget {
  const AdminPetList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Currently Listed Pets'),
        centerTitle: true,
      ),
      body: const Center(
        child: AdminPets(),
      ),
    );
  }
}
