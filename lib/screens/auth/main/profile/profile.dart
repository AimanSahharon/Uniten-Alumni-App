//TOREAD: This is to display content on Profile page
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:uniten_alumni_app/models/businesslistings.dart';
import 'package:uniten_alumni_app/models/post.dart';
import 'package:uniten_alumni_app/models/user.dart';
import 'package:uniten_alumni_app/screens/auth/main/Alumni_Hub_page/Business_Listings/list_business_listings.dart';
import 'package:uniten_alumni_app/screens/auth/main/Alumni_Hub_page/Interest_Group/interestgroup.dart';
import 'package:uniten_alumni_app/screens/auth/main/Alumni_Hub_page/Interest_Group/list_joined_group.dart';
import 'package:uniten_alumni_app/screens/auth/main/Alumni_Hub_page/Interest_Group/list_created_group.dart';
import 'package:uniten_alumni_app/screens/auth/main/Alumni_Hub_page/Posts_and_Interest_Groups/addpost.dart';
import 'package:uniten_alumni_app/screens/auth/main/Alumni_Hub_page/Posts_and_Interest_Groups/listposts.dart';
import 'package:uniten_alumni_app/services/businesslistings.dart';
import 'package:uniten_alumni_app/services/posts.dart';
import 'package:uniten_alumni_app/services/user.dart';
import 'edit_profile.dart';

class Profile extends StatefulWidget {
  final String uid;

  const Profile({super.key, required this.uid});

  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  final PostService _postService = PostService();
  final BusinessListingsService _businessListingsService = BusinessListingsService();
  final UserService _userService = UserService();

  Future<void> _refreshPosts() async {
    // Add your refresh logic here, such as fetching posts again
    setState(() {});
  }

  Future<void> _refreshInterestGroups() async {
    // Add your refresh logic here for interest groups if needed
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final String uid = widget.uid;

    return MultiProvider(
      providers: [
        StreamProvider<List<PostModel>?>.value(
          value: _postService.getPostsByUser(uid),
          initialData: const [],
        ),
        StreamProvider<List<BusinessListingsModel>?>.value(
          value: _businessListingsService.getPostsByUser(uid),
          initialData: const [],
        ),
        StreamProvider<UserModel?>.value(
          value: _userService.getUserInfo(uid),
          initialData: null,
        ),
        StreamProvider<bool?>.value(
          value: _userService.isFollowing(FirebaseAuth.instance.currentUser?.uid, uid),
          initialData: null,
        ),
      ],
      child: Scaffold(
        body: DefaultTabController(
          length: 4, // Adjusted to accommodate the 4 tabs
          child: NestedScrollView(
            headerSliverBuilder: (context, _) {
              return [
                SliverAppBar( // For Banner Image
                  floating: false,
                  pinned: true,
                  expandedHeight: 180,
                  flexibleSpace: FlexibleSpaceBar(
                    background: Consumer<UserModel?>(
                      builder: (context, userModel, child) {
                        return Image.network(
                          userModel?.bannerImageUrl ?? '',
                          fit: BoxFit.cover,
                          errorBuilder: (context, error, stackTrace) =>
                              Container(color: Colors.grey),
                        );
                      },
                    ),
                  ),
                ),
                SliverList(
                  delegate: SliverChildListDelegate(
                    [
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
                        child: Consumer2<UserModel?, bool?>(
                          builder: (context, userModel, isFollowing, child) {
                            final currentUser = FirebaseAuth.instance.currentUser;

                            if (currentUser == null) {
                              return const Center(child: Text("Please log in to view the profile."));
                            }

                            return Column(
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    CircleAvatar( // To make the background image circular
                                      radius: 50, // Adjust the radius as needed
                                      backgroundImage: NetworkImage(userModel?.profileImageUrl ?? ''),
                                      child: userModel?.profileImageUrl == null
                                          ? const Icon(Icons.person, size: 60)
                                          : null,
                                    ),
                                    if (currentUser.uid == uid) // If the current user is logged in and they are viewing their own profile show Edit Profile button.
                                      ElevatedButton(
                                        onPressed: () {
                                          Navigator.push(
                                            context,
                                            MaterialPageRoute(builder: (context) => const EditProfile()),
                                          );
                                        },
                                        child: const Text("Edit Profile"),
                                      )
                                    else if (isFollowing == false) // Show Follow button if not following.
                                      ElevatedButton(
                                        onPressed: () {
                                          _userService.followUser(uid);
                                        },
                                        child: const Text("Follow"),
                                      )
                                    else if (isFollowing == true) // Show Unfollow button if already following.
                                      ElevatedButton(
                                        onPressed: () {
                                          _userService.unfollowUser(uid);
                                        },
                                        child: const Text("Unfollow"),
                                      ),
                                  ],
                                ),
                                Align(
                                  alignment: Alignment.centerLeft, // To display user name
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(vertical: 10),
                                    child: Text(
                                      userModel?.name ?? 'User Name',
                                      style: const TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 20,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                ),
                SliverPersistentHeader(
                  pinned: true,
                  delegate: _SliverAppBarDelegate(
                    const TabBar( // Creating tabs for Info, Posts, Interest Groups, and Business Listings
                      tabs: [
                        Tab(text: 'Info'),
                        Tab(text: 'Posts'),
                        Tab(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text('Interest'),
                              Text('Groups'),
                            ],
                          ),
                        ),
                        Tab(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text('Business'),
                              Text('Listings'),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ];
            },
            body: TabBarView(
              children: [
                const Center(child: Text('Info Content')), // Placeholder for Info tab content
                Stack(
                  children: [
                    RefreshIndicator(
                      onRefresh: _refreshPosts, // Pass the refresh logic here
                      child: ListPosts(
                        onRefresh: _refreshPosts, // Pass the refresh function
                      ), 
                      
                      // Posts tab content
                    ),
                    Consumer<UserModel?>(
                      builder: (context, userModel, child) {
                        final currentUser = FirebaseAuth.instance.currentUser;
                        if (currentUser?.uid == uid) { // Add Post button for current user profile.
                          return Positioned(
                            bottom: 16,
                            left: 0,
                            right: 0,
                            child: Center(
                              child: Container(
                                decoration: BoxDecoration(
                                  gradient: const LinearGradient(
                                    colors: [
                                      Color.fromARGB(255, 255, 0, 0), // Red
                                      Color.fromARGB(255, 128, 0, 255),
                                    ],
                                    begin: Alignment.topLeft,
                                    end: Alignment.bottomRight,
                                  ),
                                  borderRadius: BorderRadius.circular(30),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.black.withOpacity(0.3),
                                      spreadRadius: 2,
                                      blurRadius: 8,
                                      offset: const Offset(0, 4), // Shadow position
                                    ),
                                  ],
                                ),
                                child: ElevatedButton(
                                  onPressed: () {
                                    Navigator.of(context).push(
                                      MaterialPageRoute(builder: (context) => const AddPosts()),
                                    );
                                  },
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: Colors.transparent,
                                    shadowColor: Colors.transparent,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(30),
                                    ),
                                    padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                                  ),
                                  child: const Text(
                                    'Add Post',
                                    style: TextStyle(color: Colors.white),
                                  ),
                                ),
                              ),
                            ),
                          );
                        }
                        return const SizedBox.shrink(); // Empty widget if condition not met
                      },
                    ),
                  ],
                ),

                //Interest  Group Tab Content
                RefreshIndicator(
                  onRefresh: _refreshInterestGroups, // Pass the refresh logic here
                  child:  JoinedGroup(uid: uid),//Center(child: Text('Interest Groups Content!')), // Placeholder for Interest Groups tab content
                ),


                //Business Listings Tab Content
                const BusinessListings(), // Business Listings content
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _SliverAppBarDelegate extends SliverPersistentHeaderDelegate {
  final TabBar _tabBar;

  _SliverAppBarDelegate(this._tabBar);

  @override
  double get minExtent => _tabBar.preferredSize.height;

  @override
  double get maxExtent => _tabBar.preferredSize.height;

  @override
  Widget build(BuildContext context, double shrinkOffset, bool overlapsContent) {
    return Container(
      color: Colors.white, // Set background color to match your theme
      child: _tabBar,
    );
  }

  @override
  bool shouldRebuild(covariant SliverPersistentHeaderDelegate oldDelegate) {
    return false;
  }
}
