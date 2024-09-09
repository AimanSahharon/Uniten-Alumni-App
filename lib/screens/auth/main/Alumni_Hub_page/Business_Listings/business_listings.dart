import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:uniten_alumni_app/models/businesslistings.dart';

import 'package:uniten_alumni_app/screens/auth/main/Alumni_Hub_page/Business_Listings/add_business_listings.dart';
import 'package:uniten_alumni_app/screens/auth/main/Alumni_Hub_page/Business_Listings/list_business_listings.dart';
import 'package:uniten_alumni_app/screens/auth/main/Alumni_Hub_page/Business_Listings/feed.dart';
import 'package:uniten_alumni_app/screens/auth/main/Alumni_Hub_page/Business_Listings/liked_business_listings.dart';
import 'package:uniten_alumni_app/services/businesslistings.dart'; // Import LikedPostsScreen


class BusinessListingsPage extends StatefulWidget {
  const BusinessListingsPage({super.key});

  @override
  State<BusinessListingsPage> createState() => _BusinessListingsPageState();
}

class _BusinessListingsPageState extends State<BusinessListingsPage> {
  final BusinessListingsService _businessListingsService = BusinessListingsService();
  final TextEditingController _searchController = TextEditingController();
  Stream<List<BusinessListingsModel>>? _postsStream;

  @override
  void initState() {
    super.initState();
    _postsStream = _businessListingsService.getAllPosts(FirebaseAuth.instance.currentUser!.uid);
  }

  void _searchPosts(String query) {
    if (query.isEmpty) {
      setState(() {
        _postsStream = _businessListingsService.getAllPosts(FirebaseAuth.instance.currentUser!.uid);
      });
    } else {
      setState(() {
        _postsStream = _businessListingsService.searchPosts(query);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return StreamProvider<List<BusinessListingsModel>?>.value(
      value: _postsStream,
      initialData: [],
      child: DefaultTabController(
        length: 3, // Adjusted to match the number of tabs
        child: Scaffold(
          appBar: AppBar(
            leading: IconButton(
              icon: const Icon(Icons.arrow_back),
              onPressed: () => Navigator.of(context).pop(),
            ),
            bottom: const TabBar(
              tabs: [
                Tab(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text('Business'),
                      Text('Listings'),
                    ],
                  ),
                ),
                Tab(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text('Followed'),
                      Text('User Posts'),
                    ],
                  ),
                ),
                Tab(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text('Liked'),
                      Text('Business List'),
                    ],
                  ),
                ),
              ],
            ),
            title: const Text('Business Listings'),
          ),
          body: TabBarView(
            children: [
              // Post Tab Content
              Stack(
                children: [
                  Container(
                    decoration: const BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                        colors: [
                          Color.fromARGB(255, 255, 0, 0), // Red
                          Color.fromARGB(255, 128, 0, 255), // Purple
                        ],
                      ),
                    ),
                    child: Column(
                      children: [
                        // Search Bar
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: TextField(
                            controller: _searchController,
                            decoration: InputDecoration(
                              hintText: 'Search posts...',
                              prefixIcon: const Icon(Icons.search),
                              fillColor: Colors.white, // Set the fill color to white
                              filled: true, // Enable the fill color
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(30.0),
                              ),
                            ),
                            onChanged: _searchPosts,
                          ),
                        ),
                        const Expanded(
                          child: BusinessListings(),
                        ),
                      ],
                    ),
                  ),
                  Align(
                    alignment: Alignment.bottomCenter,
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Container(
                        decoration: BoxDecoration(
                          gradient: const LinearGradient(
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                            colors: [
                              Color.fromARGB(255, 255, 0, 0), // Red
                              Color.fromARGB(255, 128, 0, 255), // Purple
                            ],
                          ),
                          borderRadius: BorderRadius.circular(30),
                        ),
                        child: ElevatedButton(
                          onPressed: () {
                            Navigator.of(context).push(
                              MaterialPageRoute(builder: (context) => const AddBusinessListings()),
                            );
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.transparent, // Set the button's background to transparent
                            elevation: 10, // Add elevation for shadow
                            shadowColor: Colors.black.withOpacity(0.5), // Set the shadow color
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30),
                            ),
                            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                          ),
                          child: const Text(
                            'Add Business Listings',
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),

              // User Posts under Followed Tab Content
              Stack(
                children: [
                  Container(
                    decoration: const BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                        colors: [
                          Color.fromARGB(255, 255, 0, 0), // Red
                          Color.fromARGB(255, 128, 0, 255), // Purple
                        ],
                      ),
                    ),
                    child: const Column(
                      children: [
                        Expanded(
                          child: Feed(),
                        ),
                      ],
                    ),
                  ),
                  Align(
                    alignment: Alignment.bottomCenter,
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Container(
                        decoration: BoxDecoration(
                          gradient: const LinearGradient(
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                            colors: [
                              Color.fromARGB(255, 255, 0, 0), // Red
                              Color.fromARGB(255, 128, 0, 255), // Purple
                            ],
                          ),
                          borderRadius: BorderRadius.circular(30),
                        ),
                        child: ElevatedButton(
                          onPressed: () {
                            Navigator.of(context).push(
                              MaterialPageRoute(builder: (context) => const AddBusinessListings()),
                            );
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.transparent, // Set the button's background to transparent
                            elevation: 10, // Add elevation for shadow
                            shadowColor: Colors.black.withOpacity(0.5), // Set the shadow color
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30),
                            ),
                            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                          ),
                          child: const Text(
                            'Add Business Listings',
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),

              // Liked Posts Tab Content
              Stack(
                children: [
                  LikedPostsScreen(), // Navigate to LikedPostsScreen
                  Align(
                    alignment: Alignment.bottomCenter,
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Container(
                        decoration: BoxDecoration(
                          gradient: const LinearGradient(
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                            colors: [
                              Color.fromARGB(255, 255, 0, 0), // Red
                              Color.fromARGB(255, 128, 0, 255), // Purple
                            ],
                          ),
                          borderRadius: BorderRadius.circular(30),
                        ),
                        child: ElevatedButton(
                          onPressed: () {
                            Navigator.of(context).push(
                              MaterialPageRoute(builder: (context) => const AddBusinessListings()),
                            );
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.transparent, // Set the button's background to transparent
                            elevation: 10, // Add elevation for shadow
                            shadowColor: Colors.black.withOpacity(0.5), // Set the shadow color
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30),
                            ),
                            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                          ),
                          child: const Text(
                            'Add Business Listings',
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
