//TOREAD: This is to only display the post that the current logged in user is following and not all the user's posts

/*import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:uniten_alumni_app/models/businesslistings.dart';
import 'package:uniten_alumni_app/screens/auth/main/Alumni_Hub_page/Business_listings/list_business_listings.dart';
import 'package:uniten_alumni_app/services/businesslistings.dart';

class Feed extends StatefulWidget {
  const Feed({super.key});

  @override
  State<Feed> createState() => _FeedState();
}

class _FeedState extends State<Feed> {
  BusinessListingsService _businessListingsService = BusinessListingsService();

  @override
  Widget build(BuildContext context) {
    return FutureProvider<List<BusinessListingsModel>>.value(
      value: _businessListingsService.getFeed(FirebaseAuth.instance.currentUser!.uid),
      initialData: <BusinessListingsModel>[],
      child: Scaffold(
        body: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [const Color.fromARGB(255, 255, 0, 0), const Color.fromARGB(255, 128, 0, 255)], // Customize gradient colors for background colors
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
          child: BusinessListings(),
        ),
      ),
    );
  }
} */

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:uniten_alumni_app/models/businesslistings.dart';
import 'package:uniten_alumni_app/screens/auth/main/Alumni_Hub_page/Business_Listings/list_business_listings.dart';
import 'package:uniten_alumni_app/services/businesslistings.dart';

class Feed extends StatefulWidget {
  const Feed({super.key});

  @override
  State<Feed> createState() => _FeedState();
}

class _FeedState extends State<Feed> {
  final BusinessListingsService _BusinessListingsService = BusinessListingsService();

  @override
  Widget build(BuildContext context) {
    return FutureProvider<List<BusinessListingsModel>>.value(
      value: _BusinessListingsService.getFeed(FirebaseAuth.instance.currentUser!.uid),
      initialData: const <BusinessListingsModel>[],
      child: Scaffold(
        body: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [Color.fromARGB(255, 255, 0, 0), Color.fromARGB(255, 128, 0, 255)], // Customize gradient colors for background colors
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
          child: const BusinessListings(),
        ),
      ),
    );
  }
}

