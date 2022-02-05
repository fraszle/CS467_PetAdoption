import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'package:firebase_core/firebase_core.dart';
import 'package:plentyofpets/theme.dart';

import 'screens/signup_screen.dart';
import 'screens/home_screen.dart';
import 'screens/landing_screen.dart';
import 'screens/admin_homepage.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  static const loginRoute = '/';
  static const homeRoute = '/home';
  static const signupRoute = '/signup';
  static const adminRoute = '/admin';

  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    User? firebaseUser = FirebaseAuth.instance.currentUser;

    return MaterialApp(
      title: 'Plenty of Pets',
      theme: PlentyOfPetsTheme.getTheme(),
      // Redirect to Home screen if user is already logged in
      initialRoute: firebaseUser != null ? homeRoute : loginRoute,
      routes: {
        loginRoute: (context) => const LandingScreen(),
        signupRoute: (context) => const SignupScreen(),
        homeRoute: (context) => const HomeScreen(),
        adminRoute: (context) => const AdminHomepage()
      },
    );
  }
}
