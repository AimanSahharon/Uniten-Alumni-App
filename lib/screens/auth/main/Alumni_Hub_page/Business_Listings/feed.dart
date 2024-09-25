//TOREAD: This is to only display the business listings that the current logged in user is following and not all the user's business listings
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
  final BusinessListingsService _businessListingsService = BusinessListingsService();

  // Method to fetch feed
  Future<void> _fetchFeed() async {
    // Trigger a rebuild of the FutureProvider
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return FutureProvider<List<BusinessListingsModel>>.value(
      value: _businessListingsService.getFeed(FirebaseAuth.instance.currentUser!.uid), //use getFeed function from businesslistings.dart in service folder to get following user's posts
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
          child: RefreshIndicator(
            onRefresh: _fetchFeed, // Call the method to refresh
            child: const BusinessListings(), // The child widget remains the same
          ),
        ),
      ),
    );
  }
}


