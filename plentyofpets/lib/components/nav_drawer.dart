import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:plentyofpets/main.dart';

import 'package:plentyofpets/screens/admin_homepage.dart';
import 'package:plentyofpets/screens/add_edit_pet_screen.dart';
import 'package:plentyofpets/screens/landing_screen.dart';
import 'package:plentyofpets/screens/pet_profile.dart';
import 'package:plentyofpets/screens/signup_screen.dart';
import 'package:plentyofpets/components/user_profile.dart';

class NavDrawer extends StatelessWidget {
  const NavDrawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(children: <Widget>[
      const DrawerHeader(
          child: Text('Temp Nav',
              style: TextStyle(
                  color: Colors.black,
                  fontSize: 40,
                  fontWeight: FontWeight.bold))),
      ListTile(
        leading: const Icon(Icons.arrow_right),
        title: const Text('Admin Screen'),
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute<void>(
              builder: (context) => const AdminHomepage(),
            ),
          );
        },
      ),
      ListTile(
        leading: const Icon(Icons.arrow_right),
        title: const Text('Add Pet Screen'),
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute<void>(
              builder: (context) => const AddPetScreen(),
            ),
          );
        },
      ),
      ListTile(
        leading: const Icon(Icons.arrow_right),
        title: const Text('Landing Screen'),
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute<void>(
              builder: (context) => const LandingScreen(),
            ),
          );
        },
      ),
      ListTile(
        leading: const Icon(Icons.arrow_right),
        title: const Text('Sign Up Screen'),
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute<void>(
              builder: (context) => const SignupScreen(),
            ),
          );
        },
      ),
      ListTile(
        leading: const Icon(Icons.arrow_right),
        title: const Text('Pet Profile Screen'),
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute<void>(
              builder: (context) => PetProfile('x23u57Kvl6byMHFb5K7P'),
            ),
          );
        },
      ),
      ListTile(
        leading: const Icon(Icons.arrow_right),
        title: const Text('User Profile Screen'),
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute<void>(
              builder: (context) => const UserProfile(),
            ),
          );
        },
      ),
      ListTile(
        leading: const Icon(Icons.arrow_right),
        title: const Text('Signout'),
        onTap: () async {
          try {
            await FirebaseAuth.instance.signOut();
          } catch (e) {
            showDialog(
                context: context,
                builder: (_) => const AlertDialog(
                      title: Text(
                        "Error Logging Out",
                        textAlign: TextAlign.center,
                      ),
                      content: Text(
                          'Error while logging out. Please try again in a few minutes.'),
                    ));
            return;
          }
          Navigator.pushNamed(context, MyApp.loginRoute);
        },
      )
      // ListTile(
      //   leading: const Icon(Icons.arrow_right),
      //   title: const Text('Add pet screen'),
      //   onTap: () {
      //     Navigator.push(context,
      //       MaterialPageRoute<void>(
      //         builder: (context) => const AddPetScreen(),
      //       ),
      //     );
      //   },
      // ),
    ]);
  }
}
