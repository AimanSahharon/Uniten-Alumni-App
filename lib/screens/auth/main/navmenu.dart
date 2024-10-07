//TOREAD: This file is to create bottom navigation menu and make it constant across all pages

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:persistent_bottom_nav_bar/persistent_bottom_nav_bar.dart';
import 'package:uniten_alumni_app/screens/auth/main/Alumni_Hub_page/Posts_and_Interest_Groups/posts_and_interest_groups.dart';
import 'package:uniten_alumni_app/screens/auth/main/alumni.dart';
import 'package:uniten_alumni_app/screens/auth/main/benefits.dart';
import 'package:uniten_alumni_app/screens/auth/main/Alumni_Hub_page/connectalumni.dart';
import 'package:uniten_alumni_app/screens/auth/main/homepage.dart';
import 'package:uniten_alumni_app/screens/auth/main/mycard.dart';
import 'package:uniten_alumni_app/screens/auth/main/profile/profile.dart';
import 'package:uniten_alumni_app/services/auth.dart';

class NavMenu extends StatefulWidget {
  const NavMenu({super.key});

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
        body: Profile(uid: FirebaseAuth.instance.currentUser!.uid,),
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
                MaterialPageRoute(builder: (context) => const ConnectAlumni()),
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
