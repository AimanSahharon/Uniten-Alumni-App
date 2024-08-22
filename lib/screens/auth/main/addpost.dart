/*import 'package:flutter/material.dart';


class AddAddPosts extends StatefulWidget {
  const AddAddPosts({super.key});

  @override
  State<AddPosts> createState() => _AddPostsState();
}

class _AddPostsState extends State<AddPosts> {
  
  @override
  Widget build(BuildContext context) {
   return const Scaffold(
      backgroundColor: Color.fromARGB(255, 229, 255, 0), // Use backgroundColor instead of color
      body: Center(
        child: Text("AddPosts"),
      ),
    ); 
  }
} */

import 'package:flutter/material.dart';

class AddPosts extends StatefulWidget {
  const AddPosts({super.key});

  @override
  State<AddPosts> createState() => _AddPostsState();
}

class _AddPostsState extends State<AddPosts> {
  String text = '';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add Post'),
        actions: const <Widget>[
          ElevatedButton(
            onPressed: null, 
            child: Text('Post'))
        ],
      ),
      body: Container( 
        padding: EdgeInsets.symmetric(vertical: 20, horizontal: 10),
        child:  new Form(
          child: TextFormField(
            onChanged: (val) {
              setState(() {
                text = val; 
              });
            },)
          )

      )
    );
  }
}