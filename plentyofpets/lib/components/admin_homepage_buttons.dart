import 'package:flutter/material.dart';
//import '../screens/add_pet_screen.dart';
import '../screens/add_edit_pet_screen.dart';


class AddPetCardButton extends StatelessWidget {
  final String buttonText;

  const AddPetCardButton({required this.buttonText, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 150,
      height: 100,
      child: Card(
        elevation: 12,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        color: Colors.white,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            TextButton(
                onPressed: () {
                  Navigator.of(context).push(
                      MaterialPageRoute(builder: (context) => AddPetScreen()));
                },
                child: Text(buttonText)),
          ],
        ),
      ),
    );
  }
}

class EditPetListCardButton extends StatelessWidget {
  final String buttonText;

  const EditPetListCardButton({required this.buttonText, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 150,
      height: 100,
      child: Card(
        elevation: 12,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        color: Colors.white,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            TextButton(
                onPressed: () {
                  Navigator.of(context).push(
                      MaterialPageRoute(builder: (context) => AddPetScreen()));
                },
                child: Text(buttonText)),
          ],
        ),
      ),
    );
  }
}

class AddNewsCardButton extends StatelessWidget {
  final String buttonText;

  const AddNewsCardButton({required this.buttonText, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 150,
      height: 100,
      child: Card(
        elevation: 12,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        color: Colors.white,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            TextButton(
                onPressed: () {
                  Navigator.of(context).push(
                      MaterialPageRoute(builder: (context) => AddPetScreen()));
                },
                child: Text(buttonText)),
          ],
        ),
      ),
    );
  }
}

class AccountInfoCardButton extends StatelessWidget {
  final String buttonText;

  const AccountInfoCardButton({required this.buttonText, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 150,
      height: 100,
      child: Card(
        elevation: 12,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        color: Colors.white,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            TextButton(
                onPressed: () {
                  Navigator.of(context).push(
                      MaterialPageRoute(builder: (context) => AddPetScreen()));
                },
                child: Text(buttonText)),
          ],
        ),
      ),
    );
  }
}
