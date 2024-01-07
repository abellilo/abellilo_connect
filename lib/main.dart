import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:minimal_social_media/auth/auth_gate.dart';
import 'package:minimal_social_media/firebase_options.dart';
import 'package:minimal_social_media/pages/home_page.dart';
import 'package:minimal_social_media/pages/login_page.dart';
import 'package:minimal_social_media/auth/register_or_login_page.dart';
import 'package:minimal_social_media/pages/profile_page.dart';
import 'package:minimal_social_media/pages/register_page.dart';
import 'package:minimal_social_media/pages/users_page.dart';
import 'package:minimal_social_media/theme/dark_mode.dart';
import 'package:minimal_social_media/theme/light_mode.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: AuthGate(),
      theme: lightMode,
      darkTheme: dark_mode,
      routes: {
        '/login_register_page' : (context)=> RegisterOrLogin(),
        '/home_page': (context)=> HomePage(),
        '/user_page' : (context)=> UsersPage(),
        '/profile_page' : (context)=> ProfilePage(),
      },
    );
  }
}

