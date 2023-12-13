import 'package:arthub/models/user.dart';
import 'package:arthub/pages/account/account_page.dart';
import 'package:arthub/providers/user_provider.dart';
import 'package:arthub/utils/colors.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class UsersList extends StatefulWidget {
  const UsersList({super.key, this.uid, this.types});
  final uid;
  final types ;
  @override
  State<UsersList> createState() => _UsersListState();
}

class _UsersListState extends State<UsersList> {

  @override
  Widget build(BuildContext context) {
    final User user = Provider.of<UserProvider>(context).getUser;
  var types = widget.types== 'following'?user.following:user.followers;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: mobileBackgroundColor,
        bottomOpacity: 0,
        toolbarHeight: 0,
      ),
      body: types.isNotEmpty ?FutureBuilder(
          future: FirebaseFirestore.instance
              .collection('users')
              .where(
                'uid',
                whereIn:types,
              )
              .get(),
          builder: (context, snapshot) {
            if (!snapshot.hasData) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
            return ListView.builder(
              itemCount: (snapshot.data! as dynamic).docs.length,
              itemBuilder: (context, index) {
                return InkWell(
                  onTap: () => Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => AccountPage(
                        uid: (snapshot.data! as dynamic).docs[index]['uid'],
                      ),
                    ),
                  ),
                  child: ListTile(
                    leading: CircleAvatar(
                      backgroundImage: NetworkImage(
                        (snapshot.data! as dynamic).docs[index]['photoUrl'],
                      ),
                      radius: 20,
                    ),
                    title: Text(
                      (snapshot.data! as dynamic).docs[index]['username'],
                      style: TextStyle(color: primaryColor),
                    ),
                  ),
                );
              },
            );
          }):const Center(child: Text('Список пуст...', style: TextStyle(color: primaryColor),))
    );
  }
}
