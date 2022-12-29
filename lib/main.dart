import 'package:flutter/material.dart';
import 'package:shop/pages/homepage.dart';
import 'package:shop/pages/signup.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:shop/pages/verification_page.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      routes: {
        SignUpPage.routeName: (context) => SignUpPage(),
        HomePage.routeName: (context) => HomePage(),
        VerificatonPage.routeName: (context) => const VerificatonPage(),
      },
      theme: ThemeData(
        primaryColor: Colors.purple,
      ),
      title: 'Flutter Demo',
      home: SignUpPage(),
    );
  }
}
