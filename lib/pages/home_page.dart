import 'package:flutter/material.dart';
import 'package:arthub/config/routes.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:arthub/pages/account_page.dart';
import 'package:arthub/pages/login_page.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser;

    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Color(0xff050C16),
        showSelectedLabels: false,
        showUnselectedLabels: false,
        type: BottomNavigationBarType.fixed,
        items: [
          BottomNavigationBarItem(
              icon: Icon(
                Icons.search,
                size: 24,
                color: Colors.white,
              ),
              label: 'search'),
          BottomNavigationBarItem(
              icon: Icon(
                Icons.message_outlined,
                size: 24,
                color: Colors.white,
              ),
              label: 'message'),
          BottomNavigationBarItem(
              icon: Stack(
                children: [ Container(height: 50, width: 50
                ,decoration: BoxDecoration(borderRadius: BorderRadius.all(Radius.circular(50)), color: Color(0xff514FFF),),),
                Padding(
                  padding: const EdgeInsets.all(13.0),
                  child: Icon(
                    Icons.add,
                    size: 24,
                    color: Colors.white,
                  ),
                ),]
              ),
              label: 'add'),
          BottomNavigationBarItem(
              icon: Icon(
                Icons.notifications_on_outlined,
                size: 24,
                color: Colors.white,
              ),
              label: 'notification'),
          BottomNavigationBarItem(
              icon: Icon(
                Icons.person_sharp,
                size: 24,
                color: Colors.white,
              ),
              label: 'profile'),
        ],
      ),
    );
  }
}

//     return Scaffold(
//       resizeToAvoidBottomInset: false,
//       appBar: AppBar(
//         title: const Text('Главная страница'),
//         actions: [
//           IconButton(
//             onPressed: () {
//               if ((user == null)) {
//                 Navigator.push(
//                   context,
//                   MaterialPageRoute(builder: (context) => const LoginPage()),
//                 );
//               } else {
//                 Navigator.push(
//                   context,
//                   MaterialPageRoute(
//                       builder: (context) => const AccountPage()),
//                 );
//               }
//             },
//             icon: Icon(
//               Icons.person,
//               color: (user == null) ? Colors.white : Colors.yellow,
//             ),
//           ),
//         ],
//       ),
     
//     );
//   }
// }