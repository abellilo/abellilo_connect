import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:minimal_social_media/components/my_drawer.dart';
import 'package:minimal_social_media/components/my_list_tile.dart';
import 'package:minimal_social_media/components/my_post_button.dart';
import 'package:minimal_social_media/components/my_textfield.dart';
import 'package:minimal_social_media/database/firestore.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  //access firestore
  final database = FirestoreDatabase();

  //text controller
  final newPostController = TextEditingController();

  //post message
  void postMessage() {
    //only post message is there is something in the textfield
    if (newPostController.text.isNotEmpty) {
      database.addPost(newPostController.text);

      //clear the controller
      newPostController.clear();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Welcome"),
        centerTitle: true,
        foregroundColor: Theme.of(context).colorScheme.inversePrimary,
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      drawer: const MyDrawer(),
      backgroundColor: Theme.of(context).colorScheme.background,
      body: Column(
        children: [
          //textfield box for user to type
          Padding(
            padding: const EdgeInsets.all(25.0),
            child: Row(
              children: [
                //textfield to send post
                Expanded(
                  child: MyTextField(
                      hintText: "Say something",
                      obsureText: false,
                      controller: newPostController),
                ),

                //post button
                MyPostButton(onTap: postMessage)
              ],
            ),
          ),

          //post
          StreamBuilder(
              stream: database.getPostStream(),
              builder: (context, snapshot) {
                final posts = snapshot.data!.docs;
                //if there is data
                if (snapshot.hasData) {
                  return Expanded(
                    child: ListView.builder(
                        itemCount: posts.length,
                        itemBuilder: (context, index) {
                          final post = posts[index];
                          String messgae = post['PostMessage'];
                          String userEmail = post['userEmail'];
                          Timestamp timeStamp = post['TimeStamp'];
                          return MyListTile(title: messgae, subTitle: userEmail);
                        }),
                  );
                }

                //if error
                if (snapshot.hasError) {
                  return Text("Error: " + snapshot.hasError.toString());
                }

                //if no data
                if (snapshot == null || posts.isEmpty) {
                  return const Center(
                    child: Padding(
                      padding: EdgeInsets.all(25),
                      child: Text("No Post... Post Something!"),
                    ),
                  );
                }

                return Center(child: CircularProgressIndicator());
              }),
        ],
      ),
    );
  }
}
