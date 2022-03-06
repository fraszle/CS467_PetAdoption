import 'package:flutter/material.dart';

import 'package:plentyofpets/theme.dart';
import 'package:plentyofpets/utils/firebase_auth_util.dart';

class NavDrawer extends StatelessWidget {
  const NavDrawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(children: <Widget>[
      Container(
        height: 200,
        width: 350,
        decoration: BoxDecoration(color:  Colors.green.shade200),
        child: DrawerHeader(
          child:
            Image.asset('assets/images/plentyOfPetsPic.png',
              height: 30,
              width: 30,
            ),     
        ),
      ),
     
      ListTile(
        leading: const Icon(
          Icons.door_front_door_outlined,
          size: 40
        ),
        title: Text('Signout', style: PlentyOfPetsTheme.petCardName,),
        onTap: () => FirebaseAuthUtil.signOut(context),
      )
    ]);
  }
}
