import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../components/my_button.dart';
import '../components/my_textfield.dart';

class RegisterPage extends StatefulWidget {
  final void Function()? onTap;

  RegisterPage({Key? key, required this.onTap}) : super(key: key);

  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final usernameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();

  //register method
  void register(String email, String password) async {
    //making sure passwords match
    if (passwordController.text != confirmPasswordController.text) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text("Passwords don't match")));
    } else {
      try {
        //create a user
        UserCredential? userCredentials = await FirebaseAuth.instance
            .createUserWithEmailAndPassword(email: email, password: password);

        //create a user document and collect them in firestore
        createUserDocument(userCredentials);
      } on FirebaseAuthException catch (e) {
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text(e.code)));
      }
    }
  }

  //create a user document and collect them in firestore
  Future<void> createUserDocument(UserCredential? userCredential) async {
    if (userCredential != null && userCredential.user != null) {
      await FirebaseFirestore.instance
          .collection("Users")
          .doc(userCredential.user!.email)
          .set({
        'email' : userCredential.user!.email,
        'username' : usernameController.text
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(25.0),
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                //logo
                Icon(
                  Icons.whatshot,
                  size: 80,
                  color: Theme.of(context).colorScheme.inversePrimary,
                ),

                const SizedBox(
                  height: 25,
                ),

                //app name
                Text(
                  "Abellilo Connect",
                  style: TextStyle(fontSize: 20),
                ),

                const SizedBox(
                  height: 25,
                ),

                //username textfield
                MyTextField(
                    hintText: "Username",
                    obsureText: false,
                    controller: usernameController),

                const SizedBox(
                  height: 10,
                ),

                //email textfield
                MyTextField(
                    hintText: "Email",
                    obsureText: false,
                    controller: emailController),

                const SizedBox(
                  height: 10,
                ),

                //password textfield
                MyTextField(
                    hintText: "Password",
                    obsureText: true,
                    controller: passwordController),

                const SizedBox(
                  height: 10,
                ),

                //confirm password textfield
                MyTextField(
                    hintText: "Confirm Password",
                    obsureText: true,
                    controller: confirmPasswordController),

                const SizedBox(
                  height: 25,
                ),

                //register button
                MyButton(
                    onTap: () =>
                        register(emailController.text, passwordController.text),
                    text: "Sign Up"),

                const SizedBox(
                  height: 25,
                ),

                //don't have an account? register now
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("Already have an account?"),
                    const SizedBox(
                      width: 5,
                    ),
                    GestureDetector(
                      onTap: widget.onTap,
                      child: const Text(
                        "Sign In here",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
