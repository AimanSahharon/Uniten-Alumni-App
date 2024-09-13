//TOREAD: This is to allow user to comment the post

import 'package:flutter/material.dart';
import 'package:uniten_alumni_app/models/businesslistings.dart';
import 'package:uniten_alumni_app/services/businesslistings.dart';
import 'package:provider/provider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:uniten_alumni_app/models/user.dart';
import 'package:uniten_alumni_app/services/user.dart';
import 'package:intl/intl.dart';

class CommentScreen extends StatefulWidget {
  final BusinessListingsModel post;

  const CommentScreen({super.key, required this.post});

  @override
  _CommentScreenState createState() => _CommentScreenState();
}

class _CommentScreenState extends State<CommentScreen> with WidgetsBindingObserver {
  final BusinessListingsService _businessListingsService = BusinessListingsService();
  final TextEditingController _commentController = TextEditingController();
  final ScrollController _scrollController = ScrollController();
  final FocusNode _focusNode = FocusNode();
  double _keyboardHeight = 0;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void didChangeMetrics() {
    setState(() {
      _keyboardHeight = WidgetsBinding.instance.window.viewInsets.bottom;
    });
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    _commentController.dispose();
    _scrollController.dispose();
    _focusNode.dispose();
    super.dispose();
  }
  //Scroll to bottom after user has sent a comment
  void _scrollToBottom() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (_scrollController.hasClients) {
        _scrollController.jumpTo(_scrollController.position.maxScrollExtent);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Comments'),
      ),
      body: Column(
        children: [
          Expanded(
            child: StreamProvider<List<BusinessListingsModel>>.value(
              value: _businessListingsService.getComments(widget.post.id),
              initialData: const [],
              builder: (context, child) {
                final comments = Provider.of<List<BusinessListingsModel>>(context);
                return ListView.builder(
                  controller: _scrollController,
                  itemCount: comments.length,
                  itemBuilder: (context, index) {
                    final comment = comments[index]; //to list the comments
                    final isCreator = comment.creator == FirebaseAuth.instance.currentUser?.uid;

                    //to get user's name on the comment
                    return FutureBuilder<UserModel?>(
                      future: UserService().getUserInfo(comment.creator).first,
                      builder: (context, snapshot) {
                        if (!snapshot.hasData) {
                          return const Center(child: CircularProgressIndicator());
                        }
                        //provide timestamp data on the comments using the date format
                        final user = snapshot.data;
                        final dateTime = (comment.timestamp).toDate();
                        final formattedTime = DateFormat.yMMMd().add_jm().format(dateTime);

                        return Container(
                          decoration: const BoxDecoration(
                            border: Border(
                              bottom: BorderSide(
                                color: Colors.black,
                                width: 1.0,
                              ),
                            ),
                          ),
                          //display the user profile picture in circle image
                          child: ListTile(
                            leading: user?.profileImageUrl != null
                                ? CircleAvatar(
                                    radius: 20,
                                    backgroundImage: NetworkImage(user!.profileImageUrl),
                                  )
                                : const Icon(Icons.person, size: 40),
                            title: Text(user?.name ?? 'Unknown User'),
                            subtitle: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(comment.text),
                                const SizedBox(height: 4.0),
                                Text(
                                  formattedTime,
                                  style: const TextStyle(
                                    color: Colors.grey,
                                    fontSize: 12.0,
                                  ),
                                ),
                              ],
                            ),
                            trailing: isCreator
                                ? Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      IconButton(
                                        icon: const Icon(Icons.edit),
                                        onPressed: () {
                                          showDialog(
                                            context: context,
                                            builder: (context) {
                                              TextEditingController editController =
                                                  TextEditingController(text: comment.text);

                                              //To edit comments
                                              return AlertDialog(
                                                title: const Text('Edit Comment'),
                                                content: TextField(
                                                  controller: editController,
                                                  decoration: const InputDecoration(
                                                    hintText: 'Edit your comment...',
                                                  ),
                                                ),
                                                actions: [
                                                  TextButton(
                                                    onPressed: () async {
                                                      await _businessListingsService.editComment(widget.post.id, comment.id, editController.text);
                                                      Navigator.of(context).pop();
                                                    },
                                                    child: const Text('Save'),
                                                  ),
                                                ],
                                              );
                                            },
                                          );
                                        },
                                      ),
                                      //To delete comments
                                      IconButton(
                                        icon: const Icon(Icons.delete),
                                        onPressed: () async {
                                          await _businessListingsService.deleteComment(widget.post.id, comment.id);
                                        },
                                      ),
                                    ],
                                  )
                                : null,
                          ),
                        );
                      },
                    );
                  },
                );
              },
            ),
          ),
          //When user press on the text box, raise the text box above the phone's keyboard and once user tap on send comment icon, bring down the text box so user can read the comments
          Padding(
            padding: EdgeInsets.only(bottom: _keyboardHeight),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _commentController,
                    focusNode: _focusNode,
                    decoration: const InputDecoration(
                      hintText: 'Write a comment...',
                    ),
                    onSubmitted: (value) async {
                      if (value.isNotEmpty) {
                        await _businessListingsService.addComment(widget.post.id, value);
                        _commentController.clear();
                        _scrollToBottom();
                      }
                    },
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.send),
                  onPressed: () async {
                    if (_commentController.text.isNotEmpty) {
                      await _businessListingsService.addComment(widget.post.id, _commentController.text);
                      _commentController.clear();
                      _scrollToBottom();

                      // Unfocus the TextField to force a layout update
                      _focusNode.unfocus();
                    }
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
