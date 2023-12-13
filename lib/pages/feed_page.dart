import 'package:arthub/models/user.dart' as model;
import 'package:arthub/providers/user_provider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:arthub/utils/colors.dart';
import 'package:arthub/pages/widgets/post_card.dart';
import 'package:provider/provider.dart';

class FeedPage extends StatefulWidget {
  const FeedPage({Key? key}) : super(key: key);

  @override
  State<FeedPage> createState() => _FeedPageState();
}

class _FeedPageState extends State<FeedPage> {

  @override
  void initState() {
    context.read<UserProvider>().refreshUser();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final model.User user = Provider.of<UserProvider>(context).getUser;
  // var following = user.following;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: mobileBackgroundColor,
        bottomOpacity: 0,
        toolbarHeight: 0,
      ),
      body: user.following.isNotEmpty ?StreamBuilder(
        stream: FirebaseFirestore.instance.collection('posts').where('uid', whereIn:user.following).snapshots(),
        builder: (context,
            AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          return snapshot.data!.docs.isEmpty || snapshot.data?.docs == null?
          const Center(child: Text('Ваша лента пуста...', style: TextStyle(color: primaryColor),))
          :ListView.builder(
            itemCount: snapshot.data!.docs.length,
            itemBuilder: (ctx, index) => Container(
              child: PostCard(
                snap: snapshot.data!.docs[index].data(),
              ),
            ),
          );
        },
      ): const Center(child: Text('Ваша лента пуста...', style: TextStyle(color: primaryColor),))
    );
  }
}