import 'package:arthub/models/user.dart';
import 'package:arthub/providers/user_provider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:arthub/utils/colors.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher_string.dart';

class AllChatsPage extends StatelessWidget {
  const AllChatsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final User user = Provider.of<UserProvider>(context).getUser;
    var following = user.following;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: mobileBackgroundColor,
        bottomOpacity: 0,
        toolbarHeight: 0,
      ),
      body: following.isNotEmpty ?StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection('users')
            .where('uid', whereIn: following)
            .snapshots(),
        builder: (context,
            AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          return snapshot.data!.docs.isEmpty || snapshot.data?.docs == null
              ? const Center(
                  child: Text(
                  'У вас нет чатов...',
                  style: TextStyle(color: primaryColor),
                ))
              : ListView.builder(
                  itemCount: snapshot.data!.docs.length,
                  itemBuilder: (ctx, index) => snapshot.data!.docs[index]
                          .data()["chat"]
                          .toString()
                          .isEmpty
                      ? Container()
                      : Container(
                          child: ListTile(
                            leading: CircleAvatar(
                              backgroundImage: NetworkImage(
                                snapshot.data!.docs[index].data()['photoUrl'],
                              ),
                              radius: 20,
                            ),
                            title: Text(
                              snapshot.data!.docs[index]
                                  .data()["username"],
                              style: TextStyle(color: primaryColor, fontWeight: FontWeight.bold,),
                            ),
                            subtitle: InkWell(
                              child: Text(
                                snapshot.data!.docs[index]
                                    .data()["chat"]
                                    .toString(),
                                style: TextStyle(color: primaryColor, decoration: TextDecoration.underline),
                              ),
                              onTap: () => launchUrlString(snapshot.data!.docs[index]
                                    .data()["chat"]
                                    .toString(),),
                            ),
                          ),
                        ),
                );
        },
      ): const Center(child: Text('У вас нет чатов...', style: TextStyle(color: primaryColor),))
    );
  }
}
