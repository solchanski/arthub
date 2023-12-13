import 'package:arthub/pages/account/account_page.dart';
import 'package:arthub/pages/account/edit_page.dart';
import 'package:arthub/pages/add_post_page.dart';
import 'package:arthub/pages/auth/login_page.dart';
import 'package:arthub/pages/auth/registration_page.dart';
import 'package:arthub/pages/auth/reset_password_page.dart';
import 'package:arthub/pages/auth/verify_email_page.dart';
import 'package:arthub/pages/comments_page.dart';
import 'package:arthub/pages/feed_page.dart';
import 'package:arthub/pages/home_page.dart';
import 'package:arthub/pages/search_page.dart';
import 'package:arthub/pages/users_list.dart';
import 'package:firebase_auth/firebase_auth.dart';

class Routes{
  static final pages={
    login:(context) => LoginPage(),
    register:(context) => RegistrationPage(),
    verify_email:(context) => VerifyEmailPage(), 
    reset_password:(context) => ResetPasswordPage(),
    account:(context) => AccountPage(uid: FirebaseAuth.instance.currentUser!.uid,),
    edit_page:(context) => EditPage(),
    // all_chats:(context) => AllChatPage(),
    // messages:(context) => MessagesPage(),
    home:(context) => HomePage(),
    add_post:(context) => AddPostPage(),
    comments:(context) => CommentsPage(postId: 1,),
    // notifications:(context) =>NotificationsPage(),
    search:(context) => SearchPage(),
    feed:(context) => FeedPage(),
    users_list:(context) => UsersList(),
    };






    static const login="/login";
    static const register="/registration";
    static const home="/home";
    static const reset_password="/reset_password";
    static const account="/account";
    static const verify_email="/verify_email";
    static const edit_page="/edit_page";
    static const all_chats="/all_chats";
    static const messages="/messages";
    static const add_post="/add_post";
    static const comments="/comments";
    static const notifications="/notifications";
    static const search="/search";
    static const feed="/feed";
    static const users_list="/users_list";
}