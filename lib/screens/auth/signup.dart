import 'package:flutter/material.dart';
import 'package:uniten_alumni_app/services/auth.dart'; //to use stateful widget or widget


class SignUp extends StatefulWidget {
  const SignUp({super.key});

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {

  final AuthService _authService = AuthService(); //creating AuthService class
  String email = '';
  String password = '';

  @override
  Widget build(BuildContext context) { //build is there to render the application, if a state changes it will rerender
    return Scaffold( //Scaffold already contains some basic features such as app bar
      appBar: AppBar(backgroundColor: const Color.fromARGB(255, 255, 255, 255), //the top bar for appearance
      elevation: 8, //brings the appbar "forward" to have shadows at the bottom
      title: const Text("Sign Up", style: TextStyle(color: Colors.black, fontWeight: FontWeight.w700)) //add title to the appbar

      ),
      
      body: Container( //to contain all the elements similar the div for web development
        decoration: const BoxDecoration( //to decorated the background color
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [Color.fromARGB(255, 255, 0, 0), Color.fromARGB(255, 128, 0, 255)], //to enable graident color on the background
          ),
        ),
        padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 50), //to prevent elements reaching/stuck on the edges of the screen
        child: Form( //create new form for user to input data
          child: Column( //to arrange the elements by stacking
            children: [
              TextField( //create text box for usernamne or email
              onChanged: (val) => setState((){
                email = val;
              }),  
                decoration: const InputDecoration(
                  filled: true, // Enable fill color
                    fillColor: Colors.white, // Set the fill color
                      border: OutlineInputBorder(), //creates the outline box of the textbox
                        hintText: "Enter Username")),

                    const SizedBox(height: 20), //add space between the textbox
                    
                    TextField( //create text box for password
              onChanged: (val) => setState((){
                password = val;
              }),  
                decoration: const InputDecoration( //to customize the textbox
                  filled: true, // Enable fill color
                    fillColor: Colors.white, // Set the fill color
                      border: OutlineInputBorder(), //creates the outline box of the textbox
                        hintText: "Enter Password"),
                    ),
                    
                    const SizedBox(height: 20),
                    ElevatedButton( //creates button
                      child: const Text('Sign Up'),
                      onPressed: () async => {_authService.signUp(email, password)}), //when pressed access the AuthService function called SignIn

                    const SizedBox(height: 20),
                    ElevatedButton( //creates button
                      child: const Text('Sign In'),
                      onPressed: () async => {_authService.signIn(email, password)}) //when pressed access the AuthService function called SignIn 

                    ] //placement text] //placement text
            
            )),
      )



    );
  }
}