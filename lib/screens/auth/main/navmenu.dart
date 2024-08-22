import 'package:flutter/material.dart';
import 'package:uniten_alumni_app/screens/auth/main/alumni.dart';
import 'package:uniten_alumni_app/screens/auth/main/benefits.dart';
import 'package:uniten_alumni_app/screens/auth/main/connectalumni.dart';
import 'package:uniten_alumni_app/screens/auth/main/homepage.dart';
import 'package:uniten_alumni_app/screens/auth/main/mycard.dart';
import 'package:uniten_alumni_app/screens/auth/main/post.dart';
import 'package:uniten_alumni_app/screens/auth/main/profile.dart';
import 'package:uniten_alumni_app/services/auth.dart';

//TOREADFIRST: This page is to create the navigation menu at the bottom screen and the appbar at the top screen.

class NavMenu extends StatefulWidget {
  const NavMenu({super.key});



  @override
   _NavMenuState createState() => _NavMenuState();
}

class _NavMenuState extends State<NavMenu> {
  final AuthService _authService = AuthService();

  final List<Widget> pages = [

    const Profile(),
    const MyCard(),
    const HomePage(),
    const Benefits(),
    const Alumni(),
    const Posts(),

  ]; 

  final List<String> titles = [
    "Profile",
    "MyCard",
    "Home",
    "Benefits",
    "Alumni",
    "Posts"
  ];
  int currentPage = 2;




  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
      appBar: AppBar(backgroundColor: const Color.fromARGB(255, 255, 255, 255), //the top bar for appearance
      elevation: 8, //brings the appbar "forward" to have shadows at the bottom
      title: Text(titles[currentPage], style: TextStyle(color: Colors.black, fontWeight: FontWeight.w700)), //change the tile of the app bar at the top based on the current page
      leading: Builder( //To create the hamburger button and the function
        builder: (context) {
          return IconButton(
            icon: const Icon(Icons.menu),
            onPressed: () {
              Scaffold.of(context).openDrawer();
            });
        }),
      actions:  <Widget>[
        ElevatedButton.icon(
          label: Text('Sign out'),
          icon: Icon(Icons.person),
          onPressed: () async {_authService.signOut();})
      ]
    ),

    body: Container( //to contain all the elements similar the div for web development
        decoration: const BoxDecoration( //to decorated the background color
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [Color.fromARGB(255, 255, 0, 0), Color.fromARGB(255, 128, 0, 255)], //to enable graident color on the background
          ), 
        ),
        child: pages[currentPage],
        ),
        drawer: Drawer( //To create content inside the hamburger menu
          child: ListView(
            padding: EdgeInsets.zero, //place the hamburger menu to the edge
            children: [
              const DrawerHeader( //the header or top part of the hamburger menu
                decoration: BoxDecoration(
                  color:Colors.red,
                ),
                child: Text('Menu'),), //title of the hamburger menu header
                ListTile( //link to Posts and Interest Groups in hamburger menu
                  title: const Text('Posts and Interest Groups'),
                  selected: currentPage == 5,
                  onTap: () {
                    /*setState(() {
                      currentPage = 5;
                    }); */
                    Navigator.pop(context);
                    Navigator.push(context, MaterialPageRoute(builder: (context) => const Posts()),);

                  },
                ),
                ListTile( //link to Connect Alumnu in hamburger menu
                  title: const Text('Connect Alumni'),
                  //selected: currentPage == 1,
                  onTap: () {
                   /* setState(() {
                      currentPage = 1;
                    }); */
                    Navigator.pop(context);
                    Navigator.push(context, MaterialPageRoute(builder: (context) => const ConnectAlumni()),);

                  },
                ),
                ListTile( //link to UNITEN Business Listings in hamburger menu
                  title: const Text('UNITEN Business Listings'),
                  selected: currentPage == 2,
                  onTap: () {
                    setState(() {
                      currentPage = 2;
                    });
                    Navigator.pop(context);

                  },
                ),
                ListTile( //link to UNITEN Career Portal in hamburger menu
                  title: const Text('UNITEN Career Portal'),
                  selected: currentPage == 3,
                  onTap: () {
                    setState(() {
                      currentPage = 3;
                    });
                    Navigator.pop(context);

                  },
                ),
                ListTile( //link to My Interest Groups in hamburger menu
                  title: const Text('My Interest Group'),
                  selected: currentPage == 4,
                  onTap: () {
                    setState(() {
                      currentPage = 4;
                    });
                    Navigator.pop(context);

                  },
                ),


            ]),),


      
      

      bottomNavigationBar: BottomNavigationBar(
        currentIndex: currentPage, //whatever the menu is being tap on that will be the active page, also it changes the color when selected
        onTap: (value) {
          setState(() {
            currentPage = value;
          });
        },
        type: BottomNavigationBarType.fixed,
        selectedItemColor: Colors.red,
        unselectedItemColor: Colors.black,
        selectedLabelStyle: TextStyle(color: Colors.red),
        unselectedLabelStyle: TextStyle(color: Colors.black),
        
        
        items: const [
        BottomNavigationBarItem( //create profile button at the bottom screen
            icon: ImageIcon(AssetImage('lib/assets/icons/profile.png')),
          /*icon:Icon(
            Icons.person
            ), */
            label: "Profile",
          ),
        BottomNavigationBarItem( //create MyCard button at the bottom screen
        icon: ImageIcon(AssetImage('lib/assets/icons/mycard.png')), //import custom images, must setup from pubspec.yaml
          /*icon:Icon(
            Icons.card_membership
            ), */
            label: "MyCard",
          ),
        BottomNavigationBarItem( //create Home button at the bottom screen
            icon: ImageIcon(AssetImage('lib/assets/icons/home.png')), 
          /*icon:Icon(
            Icons.home,
            ), */
            label: "Home",
          ),
        BottomNavigationBarItem( //create Benefits button at the bottom screen
            icon: ImageIcon(AssetImage('lib/assets/icons/benefit.png')), 
          /*icon:Icon(
            Icons.card_giftcard,
            ), */
            label: "Benefits",
          ),
        BottomNavigationBarItem( //create Alumni button at the bottom screen
            icon: ImageIcon(AssetImage('lib/assets/icons/alumni.png')),
          /*icon:Icon(
            Icons.school,
            ), */
            label: "Alumni",
          ), 
        ],
        
      ),
    
    );
  }
  
}