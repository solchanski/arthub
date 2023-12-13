import 'package:arthub/pages/chat/all_chats_page.dart';
import 'package:arthub/pages/search_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:arthub/pages/add_post_page.dart';
import 'package:arthub/pages/feed_page.dart';
import 'package:arthub/pages/account/account_page.dart';

List<Widget> homeScreenItems = [
  const FeedPage(),
  const SearchPage(),
  const AddPostPage(),
  const AllChatsPage(),
  AccountPage (
    uid: FirebaseAuth.instance.currentUser!.uid,
  ),
];