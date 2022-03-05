import 'package:flutter/material.dart';
import 'package:plentyofpets/components/favorites_list.dart';

class FavoritePets extends StatelessWidget {
  const FavoritePets({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: FavPets(),
      ),
    );
  }
}
