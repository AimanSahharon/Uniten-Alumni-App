/*import 'package:flutter/material.dart';

class ConnectAlumni extends StatelessWidget {
  const ConnectAlumni({super.key});

  @override
  Widget build(BuildContext context) {
    return Container( //to contain all the elements similar the div for web development
      decoration: const BoxDecoration( //to decorate the background color
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [Color.fromARGB(255, 255, 0, 0), Color.fromARGB(255, 128, 0, 255)], //to enable gradient color on the background
        ), 
      ),
      child: const Center(
        child: Text(
          'Connect Alumni',
          style: TextStyle(
            fontSize: 24,
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
} */

/*
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart'; // Only needed if you want to use `Colors` from Material package.
import 'package:uniten_alumni_app/screens/auth/main/alumni.dart';
import 'package:uniten_alumni_app/screens/auth/main/benefits.dart';
import 'package:uniten_alumni_app/screens/auth/main/homepage.dart';
import 'package:uniten_alumni_app/screens/auth/main/mycard.dart';
import 'package:uniten_alumni_app/screens/auth/main/profile.dart';

class ConnectAlumni extends StatelessWidget {
  const ConnectAlumni({super.key});

  @override
  Widget build(BuildContext context) {
    return const CupertinoApp(
      home: BottomMenu(),
    );
  }
}

class BottomMenu extends StatelessWidget {
  const BottomMenu({super.key});

  @override
  Widget build(BuildContext context) {
    return CupertinoTabScaffold(
      tabBar: CupertinoTabBar(
        backgroundColor: Colors.white, // Set the background color to white
        activeColor: Colors.red,       // Set the color of the selected icon to red
        inactiveColor: Colors.black,   // Set the color of the unselected icons to black
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: ImageIcon(AssetImage('lib/assets/icons/profile.png')),
            label: "Profile",
          ),
          BottomNavigationBarItem(
            icon: ImageIcon(AssetImage('lib/assets/icons/mycard.png')),
            label: "MyCard",
          ),
          BottomNavigationBarItem(
            icon: ImageIcon(AssetImage('lib/assets/icons/home.png')),
            label: "Home",
          ),
          BottomNavigationBarItem(
            icon: ImageIcon(AssetImage('lib/assets/icons/benefit.png')),
            label: "Benefits",
          ),
          BottomNavigationBarItem(
            icon: ImageIcon(AssetImage('lib/assets/icons/alumni.png')),
            label: "Alumni",
          ),
        ],
      ),
      tabBuilder: (context, index) {
        return CupertinoTabView(builder: (context) {
          switch (index) {
            case 0:
              return const CupertinoPageScaffold(
                navigationBar: CupertinoNavigationBar(
                  middle: Text('Profile'),
                ),
                child: Profile(),
              );
            case 1:
              return const CupertinoPageScaffold(
                navigationBar: CupertinoNavigationBar(
                  middle: Text('MyCard'),
                ),
                child: MyCard(),
              );
            case 2:
              return const CupertinoPageScaffold(
                navigationBar: CupertinoNavigationBar(
                  middle: Text('Home'),
                ),
                child: HomePage(),
              );
            case 3:
              return const CupertinoPageScaffold(
                navigationBar: CupertinoNavigationBar(
                  middle: Text('Benefits'),
                ),
                child: Benefits(),
              );
            case 4:
              return CupertinoPageScaffold(
                navigationBar: CupertinoNavigationBar(
                  middle: Text('Alumni'),
                ),
                child: Alumni(),
              );
            default:
              return CupertinoPageScaffold(
                navigationBar: CupertinoNavigationBar(
                  middle: Text('Page not found'),
                ),
                child: Center(child: Text('Page not found')),
              );
          }
        });
      },
    );
  }
} */

/*
import 'package:flutter/material.dart';
import 'package:uniten_alumni_app/screens/auth/main/alumni.dart';
import 'package:uniten_alumni_app/screens/auth/main/benefits.dart';
import 'package:uniten_alumni_app/screens/auth/main/homepage.dart';
import 'package:uniten_alumni_app/screens/auth/main/mycard.dart';
import 'package:uniten_alumni_app/screens/auth/main/posts.dart';
import 'package:uniten_alumni_app/screens/auth/main/profile.dart';
import 'package:uniten_alumni_app/services/auth.dart';

class ConnectAlumni extends StatefulWidget {
  const ConnectAlumni({super.key});

  @override
  _ConnectAlumniState createState() => _ConnectAlumniState();
}

class _ConnectAlumniState extends State<ConnectAlumni> {
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

  int currentPage = 4;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 255, 255, 255),
        elevation: 8,
        title: Text(
          titles[currentPage],
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.w700),
        ),
        leading: Builder(
          builder: (context) {
            return IconButton(
              icon: const Icon(Icons.menu),
              onPressed: () {
                Scaffold.of(context).openDrawer();
              },
            );
          },
        ),
        actions: <Widget>[
          ElevatedButton.icon(
            label: Text('Sign out'),
            icon: Icon(Icons.person),
            onPressed: () async {
              await _authService.signOut();
              // Navigate to login screen or show confirmation dialog
            },
          )
        ],
      ),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [Color.fromARGB(255, 255, 0, 0), Color.fromARGB(255, 128, 0, 255)],
          ),
        ),
        child: Center(
          child: Text(
            "Connect Alumni",
            style: TextStyle(fontSize: 24, color: Colors.white),
          ),
        ),
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            const DrawerHeader(
              decoration: BoxDecoration(
                color: Colors.red,
              ),
              child: Text('Menu'),
            ),
            ListTile(
              title: const Text('Posts and Interest Groups'),
              selected: currentPage == 5,
              onTap: () {
                setState(() {
                  currentPage = 5;
                });
                Navigator.pop(context);
              },
            ),
            ListTile(
              title: const Text('Connect Alumni'),
              selected: currentPage == 4,
              onTap: () {
                setState(() {
                  currentPage = 4;
                });
                Navigator.pop(context);
              },
            ),
            ListTile(
              title: const Text('UNITEN Business Listings'),
              selected: currentPage == 2,
              onTap: () {
                setState(() {
                  currentPage = 2;
                });
                Navigator.pop(context);
              },
            ),
            ListTile(
              title: const Text('UNITEN Career Portal'),
              selected: currentPage == 3,
              onTap: () {
                setState(() {
                  currentPage = 3;
                });
                Navigator.pop(context);
              },
            ),
            ListTile(
              title: const Text('My Interest Group'),
              selected: currentPage == 4,
              onTap: () {
                setState(() {
                  currentPage = 4;
                });
                Navigator.pop(context);
              },
            ),
            const Divider(
              color: Colors.black,
              height: 5.0,
            ),
            ListTile(
              title: const Text('Sign Out'),
              onTap: () async {
                await _authService.signOut();
                Navigator.pop(context);
                // Navigate to login screen or show confirmation dialog
              },
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: currentPage,
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
          BottomNavigationBarItem(
            icon: ImageIcon(AssetImage('lib/assets/icons/profile.png')),
            label: "Profile",
          ),
          BottomNavigationBarItem(
            icon: ImageIcon(AssetImage('lib/assets/icons/mycard.png')),
            label: "MyCard",
          ),
          BottomNavigationBarItem(
            icon: ImageIcon(AssetImage('lib/assets/icons/home.png')),
            label: "Home",
          ),
          BottomNavigationBarItem(
            icon: ImageIcon(AssetImage('lib/assets/icons/benefit.png')),
            label: "Benefits",
          ),
          BottomNavigationBarItem(
            icon: ImageIcon(AssetImage('lib/assets/icons/alumni.png')),
            label: "Alumni",
          ),
        ],
      ),
    );
  }
} */

import 'package:flutter/material.dart';

class ConnectAlumni extends StatelessWidget {
  const ConnectAlumni({super.key});

  @override
  Widget build(BuildContext context) {
    return Container( //to contain all the elements similar the div for web development
      decoration: const BoxDecoration( //to decorate the background color
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [Color.fromARGB(255, 255, 0, 0), Color.fromARGB(255, 128, 0, 255)], //to enable gradient color on the background
        ), 
      ),
      child: const Center(
        child: Text(
          'Connect Alumni',
          style: TextStyle(
            fontSize: 24,
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}

