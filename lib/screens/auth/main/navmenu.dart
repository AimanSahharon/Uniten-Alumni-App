/*import 'package:flutter/material.dart';
import 'package:uniten_alumni_app/screens/auth/main/alumni.dart';
import 'package:uniten_alumni_app/screens/auth/main/benefits.dart';
import 'package:uniten_alumni_app/screens/auth/main/connectalumni.dart';
import 'package:uniten_alumni_app/screens/auth/main/homepage.dart';
import 'package:uniten_alumni_app/screens/auth/main/mycard.dart';
import 'package:uniten_alumni_app/screens/auth/main/posts.dart';
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
                const Divider( //create black divider in the hamburger menu
                  color: Colors.black,
                  height: 5.0,
                ),
                 ListTile( //link to My Interest Groups in hamburger menu
                  title: const Text('Sign Out'),
                  selected: currentPage == 4,
                  onTap: ()  {
                    _authService.signOut();

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
  
} */

/* V1: Using Cupertino
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart'; // Only needed if you want to use `Colors` from Material package.
import 'package:uniten_alumni_app/screens/auth/main/alumni.dart';
import 'package:uniten_alumni_app/screens/auth/main/benefits.dart';
import 'package:uniten_alumni_app/screens/auth/main/homepage.dart';
import 'package:uniten_alumni_app/screens/auth/main/mycard.dart';
import 'package:uniten_alumni_app/screens/auth/main/profile.dart';

class NavMenu extends StatelessWidget {
  const NavMenu({super.key});

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

/* V2: With white appbar but only bottomnavigationmenu is maintained.
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart'; // Only needed if you want to use `Colors` from Material package.
import 'package:uniten_alumni_app/screens/auth/main/alumni.dart';
import 'package:uniten_alumni_app/screens/auth/main/benefits.dart';
import 'package:uniten_alumni_app/screens/auth/main/homepage.dart';
import 'package:uniten_alumni_app/screens/auth/main/mycard.dart';
import 'package:uniten_alumni_app/screens/auth/main/profile.dart';

class NavMenu extends StatelessWidget {
  const NavMenu({super.key});

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
              return CupertinoPageScaffold(
                navigationBar: CupertinoNavigationBar(
                  backgroundColor: Colors.white, // Set the background color to white
                  middle: Text('Profile', style: TextStyle(color: Colors.black)), // Set text color to black
                  border: Border(bottom: BorderSide(color: Colors.grey.shade300)), // Optional: Add a bottom border for separation
                ),
                child: DecoratedBox(
                  decoration: BoxDecoration(
                    color: Colors.white, // Set the background color to white
                  ),
                  child: const Profile(),
                ),
              );
            case 1:
              return CupertinoPageScaffold(
                navigationBar: CupertinoNavigationBar(
                  backgroundColor: Colors.white, // Set the background color to white
                  middle: Text('MyCard', style: TextStyle(color: Colors.black)), // Set text color to black
                  border: Border(bottom: BorderSide(color: Colors.grey.shade300)), // Optional: Add a bottom border for separation
                ),
                child: DecoratedBox(
                  decoration: BoxDecoration(
                    color: Colors.white, // Set the background color to white
                  ),
                  child: const MyCard(),
                ),
              );
            case 2:
              return CupertinoPageScaffold(
                navigationBar: CupertinoNavigationBar(
                  backgroundColor: Colors.white, // Set the background color to white
                  middle: Text('Home', style: TextStyle(color: Colors.black)), // Set text color to black
                  border: Border(bottom: BorderSide(color: Colors.grey.shade300)), // Optional: Add a bottom border for separation
                ),
                child: DecoratedBox(
                  decoration: BoxDecoration(
                    color: Colors.white, // Set the background color to white
                  ),
                  child: const HomePage(),
                ),
              );
            case 3:
              return CupertinoPageScaffold(
                navigationBar: CupertinoNavigationBar(
                  backgroundColor: Colors.white, // Set the background color to white
                  middle: Text('Benefits', style: TextStyle(color: Colors.black)), // Set text color to black
                  border: Border(bottom: BorderSide(color: Colors.grey.shade300)), // Optional: Add a bottom border for separation
                ),
                child: DecoratedBox(
                  decoration: BoxDecoration(
                    color: Colors.white, // Set the background color to white
                  ),
                  child: const Benefits(),
                ),
              );
            case 4:
              return CupertinoPageScaffold(
                navigationBar: CupertinoNavigationBar(
                  backgroundColor: Colors.white, // Set the background color to white
                  middle: Text('Alumni', style: TextStyle(color: Colors.black)), // Set text color to black
                  border: Border(bottom: BorderSide(color: Colors.grey.shade300)), // Optional: Add a bottom border for separation
                ),
                child: DecoratedBox(
                  decoration: BoxDecoration(
                    color: Colors.white, // Set the background color to white
                  ),
                  child: const Alumni(),
                ),
              );
            default:
              return CupertinoPageScaffold(
                navigationBar: CupertinoNavigationBar(
                  backgroundColor: Colors.white, // Set the background color to white
                  middle: Text('Page not found', style: TextStyle(color: Colors.black)), // Set text color to black
                  border: Border(bottom: BorderSide(color: Colors.grey.shade300)), // Optional: Add a bottom border for separation
                ),
                child: DecoratedBox(
                  decoration: BoxDecoration(
                    color: Colors.white, // Set the background color to white
                  ),
                  child: const Center(child: Text('Page not found')),
                ),
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
import 'package:uniten_alumni_app/screens/auth/main/connectalumni.dart';
import 'package:uniten_alumni_app/screens/auth/main/homepage.dart';
import 'package:uniten_alumni_app/screens/auth/main/mycard.dart';
import 'package:uniten_alumni_app/screens/auth/main/posts.dart';
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
    const ConnectAlumni(),

  ]; 

  final List<String> titles = [
    "Profile",
    "MyCard",
    "Home",
    "Benefits",
    "Alumni",
    "Posts"
    "Connect Alumni"
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
                    /*setState(() {
                      currentPage = 6;
                      
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
                const Divider( //create black divider in the hamburger menu
                  color: Colors.black,
                  height: 5.0,
                ),
                 ListTile( //link to My Interest Groups in hamburger menu
                  title: const Text('Sign Out'),
                  selected: currentPage == 4,
                  onTap: ()  {
                    _authService.signOut();

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
  
} */


/* Using persistent_bottom_nav_bar V1
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:persistent_bottom_nav_bar/persistent_bottom_nav_bar.dart';
import 'package:uniten_alumni_app/screens/auth/main/alumni.dart';
import 'package:uniten_alumni_app/screens/auth/main/benefits.dart';
import 'package:uniten_alumni_app/screens/auth/main/homepage.dart';
import 'package:uniten_alumni_app/screens/auth/main/mycard.dart';
import 'package:uniten_alumni_app/screens/auth/main/profile.dart';

PersistentTabController _controller;

_controller = PersistentTabController(initialIndex: 0);

class NavMenu extends StatelessWidget {
  const NavMenu({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return PersistentTabView(
        context,
        controller: _controller,
        screens: _buildScreens(),
        items: _navBarsItems(),
        handleAndroidBackButtonPress: true, // Default is true.
        resizeToAvoidBottomInset: true, // This needs to be true if you want to move up the screen on a non-scrollable screen when keyboard appears. Default is true.
        stateManagement: true, // Default is true.
        hideNavigationBarWhenKeyboardAppears: true,
        popBehaviorOnSelectedNavBarItemPress: PopActionScreensType.all,
        padding: const EdgeInsets.only(top: 8),
        backgroundColor: Colors.grey.shade900,
        isVisible: true,
        animationSettings: const NavBarAnimationSettings(
            navBarItemAnimation: ItemAnimationSettings( // Navigation Bar's items animation properties.
                duration: Duration(milliseconds: 400),
                curve: Curves.ease,
            ),
            screenTransitionAnimation: ScreenTransitionAnimationSettings( // Screen transition animation on change of selected tab.
                animateTabTransition: true,
                duration: Duration(milliseconds: 200),
                screenTransitionAnimationType: ScreenTransitionAnimationType.fadeIn,
            ),
        ),
        confineToSafeArea: true,
        navBarHeight: kBottomNavigationBarHeight,
        navBarStyle: _navBarStyle, // Choose the nav bar style with this property
      );
  }
}

List<Widget> _buildScreens() {
        return [
          HomePage(),
          Profile(),
          MyCard(),
          Benefits(),
          Alumni(),
        ];
    }

List<PersistentBottomNavBarItem> _navBarsItems() {
        return [
            PersistentBottomNavBarItem(
                icon: Icon(CupertinoIcons.home),
                title: ("Home"),
                activeColorPrimary: CupertinoColors.activeBlue,
                inactiveColorPrimary: CupertinoColors.systemGrey,
                scrollController: _scrollController1,
                routeAndNavigatorSettings: RouteAndNavigatorSettings(
                    initialRoute: "/",
                    routes: {
                    "/first": (final context) => const MainScreen2(),
                    "/second": (final context) => const MainScreen3(),
                    },
                ),
            ),
            PersistentBottomNavBarItem(
                icon: Icon(CupertinoIcons.settings),
                title: ("Settings"),
                activeColorPrimary: CupertinoColors.activeBlue,
                inactiveColorPrimary: CupertinoColors.systemGrey,
                scrollController: _scrollController2,
                routeAndNavigatorSettings: RouteAndNavigatorSettings(
                    initialRoute: "/",
                    routes: {
                    "/first": (final context) => const MainScreen2(),
                    "/second": (final context) => const MainScreen3(),
                    },
                ),
            ),
        ];
    } */

/* persistent_bottom_nav_bar V2 with appbar but appbar works on each individual pages
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:persistent_bottom_nav_bar/persistent_bottom_nav_bar.dart';
import 'package:uniten_alumni_app/screens/auth/main/alumni.dart';
import 'package:uniten_alumni_app/screens/auth/main/benefits.dart';
import 'package:uniten_alumni_app/screens/auth/main/connectalumni.dart';
import 'package:uniten_alumni_app/screens/auth/main/homepage.dart';
import 'package:uniten_alumni_app/screens/auth/main/mycard.dart';
import 'package:uniten_alumni_app/screens/auth/main/posts.dart';
import 'package:uniten_alumni_app/screens/auth/main/profile.dart';

class NavMenu extends StatefulWidget {
  const NavMenu({Key? key}) : super(key: key);

  @override
  _NavMenuState createState() => _NavMenuState();
}

class _NavMenuState extends State<NavMenu> {
  late PersistentTabController _controller;
  late ScrollController _scrollController1;
  late ScrollController _scrollController2;
  NavBarStyle _navBarStyle = NavBarStyle.style1; // Example style, choose as needed.

  @override
  void initState() {
    super.initState();
    _controller = PersistentTabController(initialIndex: 0);
    _scrollController1 = ScrollController();
    _scrollController2 = ScrollController();
  }

  @override
  Widget build(BuildContext context) {
    return PersistentTabView(
      context,
      controller: _controller,
      screens: _buildScreens(),
      items: _navBarsItems(),
      handleAndroidBackButtonPress: true,
      resizeToAvoidBottomInset: true,
      stateManagement: true,
      hideNavigationBarWhenKeyboardAppears: true,
      //popBehaviorOnSelectedNavBarItemPress: PopActionScreensType.all,
      padding: const EdgeInsets.only(top: 8),
      backgroundColor: Color.fromARGB(255, 255, 255, 255),
      isVisible: true,
      animationSettings: const NavBarAnimationSettings(
        navBarItemAnimation: ItemAnimationSettings(
          duration: Duration(milliseconds: 400),
          curve: Curves.ease,
        ),
        screenTransitionAnimation: ScreenTransitionAnimationSettings(
          animateTabTransition: true,
          duration: Duration(milliseconds: 200),
          screenTransitionAnimationType: ScreenTransitionAnimationType.fadeIn,
        ),
      ),
      confineToSafeArea: true,
      navBarHeight: kBottomNavigationBarHeight,
      navBarStyle: _navBarStyle, 
    );
  }

 List<Widget> _buildScreens() {
  return [
    Scaffold(
      appBar: AppBar(
        title: Text('Profile'),
      ),
      drawer: _buildDrawer(context), // Add the drawer here
      body: Profile(),
    ),
    Scaffold(
      appBar: AppBar(
        title: Text('My Card'),
      ),
      drawer: _buildDrawer(context), // Add the drawer here
      body: MyCard(),
    ),
    Scaffold(
      appBar: AppBar(
        title: Text('Home'),
      ),
      drawer: _buildDrawer(context), // Add the drawer here
      body: HomePage(),
    ),
    Scaffold(
      appBar: AppBar(
        title: Text('Benefits'),
      ),
      drawer: _buildDrawer(context), // Add the drawer here
      body: Benefits(),
    ),
    Scaffold(
      appBar: AppBar(
        title: Text('Alumni'),
      ),
      drawer: _buildDrawer(context), // Add the drawer here
      body: Alumni(),
    ),
  ];
}

Drawer _buildDrawer(BuildContext context) {
  return Drawer(
    child: ListView(
      padding: EdgeInsets.zero,
      children: <Widget>[
        DrawerHeader(
          decoration: BoxDecoration(
            color: Colors.red,
          ),
          child: Text(
            'Menu',
            style: TextStyle(
              color: Colors.white,
              fontSize: 24,
            ),
          ),
        ),
        ListTile(
          leading: Icon(Icons.group),
          title: Text('Posts and Interest Groups'),
          onTap: () {
            Navigator.of(context).push(
              MaterialPageRoute(builder: (context) => Posts()),
            );
          },
        ),
        ListTile(
          leading: Icon(Icons.connect_without_contact),
          title: Text('Connect Alumni'),
          onTap: () {
            Navigator.of(context).push(
              MaterialPageRoute(builder: (context) => ConnectAlumni()),
            );
          },
        ),
      ],
    ),
  );
}



  List<PersistentBottomNavBarItem> _navBarsItems() {
    return [
      PersistentBottomNavBarItem(
        icon: ImageIcon(AssetImage('lib/assets/icons/profile.png')),
        title: ("Profile"),
        activeColorPrimary: Colors.red,
        inactiveColorPrimary:  CupertinoColors.systemGrey,
        scrollController: _scrollController2,
        routeAndNavigatorSettings: RouteAndNavigatorSettings(
          initialRoute: "/",
          routes: {
            "/Profile": (final context) => const Profile(),
            "/MyCard": (final context) => const MyCard(),
            "/Benefits": (final context) => const Benefits(),
            "/Alumni": (final context) => const Alumni(),
          },
        ),
      ),
      PersistentBottomNavBarItem(
        icon: ImageIcon(AssetImage('lib/assets/icons/mycard.png')),
        title: ("MyCard"),
        activeColorPrimary:  Colors.red,
        inactiveColorPrimary: CupertinoColors.systemGrey,
        scrollController: _scrollController2,
        routeAndNavigatorSettings: RouteAndNavigatorSettings(
          initialRoute: "/",
          routes: {
            "/Profile": (final context) => const Profile(),
            "/MyCard": (final context) => const MyCard(),
            "/Benefits": (final context) => const Benefits(),
            "/Alumni": (final context) => const Alumni(),
          },
        ),
      ),
      PersistentBottomNavBarItem(
        icon: ImageIcon(AssetImage('lib/assets/icons/home.png')),
        title: ("Home"),
        activeColorPrimary:  Colors.red,
        inactiveColorPrimary: CupertinoColors.systemGrey,
        scrollController: _scrollController1,
        routeAndNavigatorSettings: RouteAndNavigatorSettings(
          initialRoute: "/",
          routes: {
            "/Profile": (final context) => const Profile(),
            "/MyCard": (final context) => const MyCard(),
            "/Benefits": (final context) => const Benefits(),
            "/Alumni": (final context) => const Alumni(),
          },
        ),
      ),
      PersistentBottomNavBarItem(
        icon: ImageIcon(AssetImage('lib/assets/icons/benefit.png')),
        title: ("Benefits"),
        activeColorPrimary:  Colors.red,
        inactiveColorPrimary: CupertinoColors.systemGrey,
        scrollController: _scrollController2,
        routeAndNavigatorSettings: RouteAndNavigatorSettings(
          initialRoute: "/",
          routes: {
            "/Profile": (final context) => const Profile(),
            "/MyCard": (final context) => const MyCard(),
            "/Benefits": (final context) => const Benefits(),
            "/Alumni": (final context) => const Alumni(),
          },
        ),
      ),
      PersistentBottomNavBarItem(
        icon: ImageIcon(AssetImage('lib/assets/icons/alumni.png')),
        title: ("Alumni"),
        activeColorPrimary:  Colors.red,
        inactiveColorPrimary: CupertinoColors.systemGrey,
        scrollController: _scrollController2,
        routeAndNavigatorSettings: RouteAndNavigatorSettings(
          initialRoute: "/",
          routes: {
            "/Profile": (final context) => const Profile(),
            "/MyCard": (final context) => const MyCard(),
            "/Benefits": (final context) => const Benefits(),
            "/Alumni": (final context) => const Alumni(),
          },
        ),
      ),
    ];
  }
} */

//TOREAD: This file is to create bottom navigation menu and make it constant

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:persistent_bottom_nav_bar/persistent_bottom_nav_bar.dart';
import 'package:uniten_alumni_app/screens/auth/main/Alumni%20Hub%20page/Posts_and_Interest_Groups/posts_and_interest_groups.dart';
import 'package:uniten_alumni_app/screens/auth/main/alumni.dart';
import 'package:uniten_alumni_app/screens/auth/main/benefits.dart';
import 'package:uniten_alumni_app/screens/auth/main/Alumni%20Hub%20page/connectalumni.dart';
import 'package:uniten_alumni_app/screens/auth/main/homepage.dart';
import 'package:uniten_alumni_app/screens/auth/main/mycard.dart';
import 'package:uniten_alumni_app/screens/auth/main/profile/edit_profile.dart';
import 'package:uniten_alumni_app/screens/auth/main/profile/profile.dart';
import 'package:uniten_alumni_app/services/auth.dart';

class NavMenu extends StatefulWidget {
  const NavMenu({Key? key}) : super(key: key);

  @override
  _NavMenuState createState() => _NavMenuState();
}

class _NavMenuState extends State<NavMenu> {
  late PersistentTabController _controller;
  late ScrollController _scrollController1;
  late ScrollController _scrollController2;
  final NavBarStyle _navBarStyle = NavBarStyle.style1; // Example style, choose as needed.
  final AuthService _authService = AuthService();

  @override
  void initState() {
    super.initState();
    _controller = PersistentTabController(initialIndex: 2); // Set Home page as default page when user is logged in
    _scrollController1 = ScrollController();
    _scrollController2 = ScrollController();
  }

  @override
  Widget build(BuildContext context) {
    return PersistentTabView(
      context,
      controller: _controller,
      screens: _buildScreens(),
      items: _navBarsItems(),
      handleAndroidBackButtonPress: true,
      resizeToAvoidBottomInset: true,
      stateManagement: true,
      hideNavigationBarWhenKeyboardAppears: true,
      padding: const EdgeInsets.only(top: 8),
      backgroundColor: Colors.white,
      isVisible: true,
      animationSettings: const NavBarAnimationSettings(
        navBarItemAnimation: ItemAnimationSettings(
          duration: Duration(milliseconds: 400),
          curve: Curves.ease,
        ),
        screenTransitionAnimation: ScreenTransitionAnimationSettings(
          animateTabTransition: true,
          duration: Duration(milliseconds: 200),
          screenTransitionAnimationType: ScreenTransitionAnimationType.fadeIn,
        ),
      ),
      confineToSafeArea: true,
      navBarHeight: kBottomNavigationBarHeight,
      navBarStyle: _navBarStyle, 
    );
  }

  List<Widget> _buildScreens() {
    return [
      Scaffold(
        appBar: AppBar(
          title: const Text('Profile'),
          actions: [
            IconButton(
              icon: const Icon(Icons.logout),
              onPressed: () async { _authService.signOut(); },
            ),
          ],
        ),
        drawer: _buildDrawer(context),
        body: Profile(uid: FirebaseAuth.instance.currentUser!.uid),
      ),
      Scaffold(
        appBar: AppBar(
          title: const Text('My Card'),
          actions: [
            IconButton(
              icon: const Icon(Icons.logout),
              onPressed: () async { _authService.signOut(); },
            ),
          ],
        ),
        drawer: _buildDrawer(context), 
        body: const MyCard(),
      ),
      Scaffold(
        appBar: AppBar(
          title: const Text('Home'),
          actions: [
            IconButton(
              icon: const Icon(Icons.logout),
              onPressed: () async { _authService.signOut(); },
            ),
          ],
        ),
        drawer: _buildDrawer(context), 
        body: const HomePage(),
      ),
      Scaffold(
        appBar: AppBar(
          title: const Text('Benefits'),
          actions: [
            IconButton(
              icon: const Icon(Icons.logout),
              onPressed: () async { _authService.signOut(); },
            ),
          ],
        ),
        drawer: _buildDrawer(context), 
        body: const Benefits(),
      ),
      Scaffold(
        appBar: AppBar(
          title: const Text('Alumni'),
          actions: [
            IconButton(
              icon: const Icon(Icons.logout),
              onPressed: () async { _authService.signOut(); },
            ),
          ],
        ),
        drawer: _buildDrawer(context), 
        body: const Alumni(),
      ),
    ];
  }

  Drawer _buildDrawer(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          const DrawerHeader(
            decoration: BoxDecoration(
              color: Colors.red,
            ),
            child: Text(
              'Menu',
              style: TextStyle(
                color: Colors.white,
                fontSize: 24,
              ),
            ),
          ),
          ListTile(
            leading: const Icon(Icons.group),
            title: const Text('Posts and Interest Groups'),
            onTap: () {
              Navigator.of(context).push(
                MaterialPageRoute(builder: (context) => const PostsAndInterestGroups()),
              );
            },
          ),
          ListTile(
            leading: const Icon(Icons.connect_without_contact),
            title: const Text('Connect Alumni'),
            onTap: () {
              Navigator.of(context).push(
                MaterialPageRoute(builder: (context) => ConnectAlumni()),
              );
            },
          ),
        ],
      ),
    );
  }

  List<PersistentBottomNavBarItem> _navBarsItems() {
    return [
      PersistentBottomNavBarItem(
        icon: const ImageIcon(AssetImage('lib/assets/icons/profile.png')),
        title: ("Profile"),
        activeColorPrimary: Colors.red,
        inactiveColorPrimary: CupertinoColors.systemGrey,
        scrollController: _scrollController2,
      ),
      PersistentBottomNavBarItem(
        icon: const ImageIcon(AssetImage('lib/assets/icons/mycard.png')),
        title: ("MyCard"),
        activeColorPrimary: Colors.red,
        inactiveColorPrimary: CupertinoColors.systemGrey,
        scrollController: _scrollController2,
      ),
      PersistentBottomNavBarItem(
        icon: const ImageIcon(AssetImage('lib/assets/icons/home.png')),
        title: ("Home"),
        activeColorPrimary: Colors.red,
        inactiveColorPrimary: CupertinoColors.systemGrey,
        scrollController: _scrollController1,
      ),
      PersistentBottomNavBarItem(
        icon: const ImageIcon(AssetImage('lib/assets/icons/benefit.png')),
        title: ("Benefits"),
        activeColorPrimary: Colors.red,
        inactiveColorPrimary: CupertinoColors.systemGrey,
        scrollController: _scrollController2,
      ),
      PersistentBottomNavBarItem(
        icon: const ImageIcon(AssetImage('lib/assets/icons/alumni.png')),
        title: ("Alumni"),
        activeColorPrimary: Colors.red,
        inactiveColorPrimary: CupertinoColors.systemGrey,
        scrollController: _scrollController2,
      ),
    ];
  }
}
