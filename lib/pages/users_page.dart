import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:minimal_social_media/components/my_list_tile.dart';
import '../components/my_back_button.dart';

class UsersPage extends StatefulWidget {
  const UsersPage({Key? key}) : super(key: key);

  @override
  _UsersPageState createState() => _UsersPageState();
}

class _UsersPageState extends State<UsersPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   title: Text("Users"),
      //   backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      //   centerTitle: true,
      // ),
      backgroundColor: Theme.of(context).colorScheme.background,
      body: StreamBuilder(
        stream: FirebaseFirestore.instance.collection("Users").snapshots(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            final users = snapshot.data!.docs;
            return SafeArea(
              child: Column(
                children: [
                  const Padding(
                    padding: EdgeInsets.only(left: 25, top: 20),
                    child: Row(
                      children: [
                        MyBackButton(),
                      ],
                    ),
                  ),
                  //list of user in the app
                  Expanded(
                      child: ListView.builder(
                          itemCount: users.length,
                          itemBuilder: (context, index) {
                            final user = users[index];
                            String username = user['username'];
                            String email = user['email'];
                            return MyListTile(title: username, subTitle: email);
                          })),
                ],
              ),
            );
          }

          if (snapshot.hasError) {}

          if (snapshot.connectionState == ConnectionState.waiting) {}

          return CircularProgressIndicator();
        },
      ),
    );
  }
}
