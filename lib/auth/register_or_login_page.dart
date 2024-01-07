import 'package:flutter/material.dart';
import 'package:minimal_social_media/pages/login_page.dart';
import 'package:minimal_social_media/pages/register_page.dart';

class RegisterOrLogin extends StatefulWidget {
  const RegisterOrLogin({Key? key}) : super(key: key);

  @override
  _RegisterOrLoginState createState() => _RegisterOrLoginState();
}

class _RegisterOrLoginState extends State<RegisterOrLogin> {

  bool loginPage = true;

  //toggle button
  void togglePages(){
    setState(() {
      loginPage = !loginPage;
    });
  }
  @override
  Widget build(BuildContext context) {
    if(loginPage){
      return LoginPage(onTap: togglePages);
    }
    else{
      return RegisterPage(onTap: togglePages);
    }
  }
}
