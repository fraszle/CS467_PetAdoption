import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'components/home_screen.dart';
import 'components/landing_screen.dart';
import 'admin_homepage.dart';
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

  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Plenty of Pets',
      initialRoute: loginRoute,
      routes: {
        loginRoute: (context) => const LandingScreen(),
        homeRoute: (context) => const HomeScreen()
      },
    );
  }
}
