import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:plentyofpets/components/extract_pet_basics.dart';
import 'package:plentyofpets/screens/home_filter_screen.dart';
import 'package:plentyofpets/screens/news_post_screen.dart';
import 'package:plentyofpets/theme.dart';
import 'screens/signup_screen.dart';
import 'screens/home_screen.dart';
import 'screens/landing_screen.dart';
import 'screens/admin_homepage.dart';
import 'firebase_options.dart';
import 'utils/firebase_auth_util.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  bool showAdminHomePage = false;
  User? firebaseUser = FirebaseAuth.instance.currentUser;
  if (firebaseUser != null) {
    showAdminHomePage = await FirebaseAuthUtil.isUserAdmin();
  }

  runApp(MyApp(showAdminHomePage: showAdminHomePage));
}

class MyApp extends StatelessWidget {
  static const loginRoute = '/';
  static const homeRoute = '/home';
  static const signupRoute = '/signup';
  static const adminRoute = '/admin';
  static const newsPostRoute = '/newsPost';

  final bool showAdminHomePage;

  const MyApp({Key? key, required this.showAdminHomePage}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Plenty of Pets',
      theme: PlentyOfPetsTheme.getTheme(),
      builder: EasyLoading.init(),
      // Redirect to Home screen if user is already logged in
      initialRoute: FirebaseAuth.instance.currentUser != null
          ? (showAdminHomePage ? adminRoute : homeRoute)
          : loginRoute,
      routes: {
        loginRoute: (context) => const LandingScreen(),
        signupRoute: (context) => const SignupScreen(),
        homeRoute: (context) => const HomeScreen(),
        adminRoute: (context) => const AdminHomepage(),
        ExtractPetBasics.routeName: (context) => const ExtractPetBasics(),
        HomeFilterScreen.routeName: (context) => const HomeFilterScreen(),
        newsPostRoute: (context) => const NewsPostScreen()
      },
    );
  }

  static String getHomeRoute(bool isAdmin) {
    if (isAdmin) {
      return adminRoute;
    } else {
      return homeRoute;
    }
  }
}
