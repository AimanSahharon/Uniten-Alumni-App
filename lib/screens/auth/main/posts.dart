/*import 'package:flutter/material.dart';


class Posts extends StatefulWidget {
  const Posts({super.key});

  @override
  State<Posts> createState() => _PostsState();
}

class _PostsState extends State<Posts> {
  
  @override
  Widget build(BuildContext context) {
   return const Scaffold(
      backgroundColor: Color.fromARGB(255, 229, 255, 0), // Use backgroundColor instead of color
      body: Center(
        child: Text("POSTS"),
      ),
    ); 
  }
} */

/*import 'package:flutter/material.dart';

class Posts extends StatefulWidget {
  const Posts({super.key});

  @override
  State<Posts> createState() => _PostsState();
}

class _PostsState extends State<Posts> {
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
} */
import 'package:flutter/material.dart';

class Posts extends StatefulWidget {
  const Posts({super.key});

  @override
  State<Posts> createState() => _PostsState();
}

class _PostsState extends State<Posts> {
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