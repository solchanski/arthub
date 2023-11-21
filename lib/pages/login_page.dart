import 'package:arthub/config/routes.dart';
import 'package:flutter/material.dart';
import 'package:email_validator/email_validator.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:arthub/pages/services/snack_bar.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => LoginPageState();
}

class LoginPageState extends State<LoginPage> {
  bool isHiddenPassword = true;
  TextEditingController emailTextInputController = TextEditingController();
  TextEditingController passwordTextInputController = TextEditingController();
  final formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    emailTextInputController.dispose();
    passwordTextInputController.dispose();

    super.dispose();
  }

  void togglePasswordView() {
    setState(() {
      isHiddenPassword = !isHiddenPassword;
    });
  }

  Future<void> login() async {
    final navigator = Navigator.of(context);

    final isValid = formKey.currentState!.validate();
    if (!isValid) return;

    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: emailTextInputController.text.trim(),
        password: passwordTextInputController.text.trim(),
      );
    } on FirebaseAuthException catch (e) {
      print(e.code);

      if (e.code == 'user-not-found' || e.code == 'wrong-password') {
        SnackBarService.showSnackBar(
          context,
          'Неправильный email или пароль. Повторите попытку',
          true,
        );
        return;
      } else {
        SnackBarService.showSnackBar(
          context,
          'Неизвестная ошибка! Попробуйте еще раз или обратитесь в поддержку.',
          true,
        );
        return;
      }
    }

    navigator.pushNamedAndRemoveUntil(Routes.home, (Route<dynamic> route) => false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Container(
        decoration: BoxDecoration(image: DecorationImage(image: AssetImage('assets/images/background_log.png'),
        fit: BoxFit.cover)),
        padding: EdgeInsets.all(30),
        child: Form(
          key: formKey,
          child: Column(
            children: [
              Spacer(),
              TextFormField(
                keyboardType: TextInputType.emailAddress,
                autocorrect: false,
                controller: emailTextInputController,
                validator: (email) =>
                    email != null && !EmailValidator.validate(email)
                        ? 'Введите правильный Email'
                        : null,
                decoration: InputDecoration(
                    fillColor: Colors.white,
                    filled: true,
                    hintText: 'E-mail',
                    border: UnderlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(25))
                    ),
                 ),
              ),
              const SizedBox(height: 15),
              TextFormField(
                autocorrect: false,
                controller: passwordTextInputController,
                obscureText: isHiddenPassword,
                validator: (value) => value != null && value.length < 6
                    ? 'Минимум 6 символов'
                    : null,
                autovalidateMode: AutovalidateMode.onUserInteraction,
                decoration: InputDecoration(
                  fillColor: Colors.white,
                  filled: true,
                  hintText: 'Пароль',
                  border: UnderlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(25))
                  ),
                  suffixIcon: IconButton(
                                icon: Icon(isHiddenPassword
                                    ? Icons.visibility
                                    : Icons.visibility_off),
                                onPressed: () {
                                  setState(() {
                                    isHiddenPassword = !isHiddenPassword;
                                  });
                                },
                              ),

                ),
              ),
              Align(
                alignment: Alignment.centerRight,
                child: TextButton(
                  onPressed: () =>
                      Navigator.of(context).pushNamed('/reset_password'),
                  child: const Text('Забыли пароль?',
                    style: TextStyle(
                      color: Colors.white,
                      decoration: TextDecoration.underline),
                  ),
                ),
              ),
              const SizedBox(height: 40),
              SizedBox(
                height: 50,
                width: 135,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color(0xff514FFF),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(25))),
                  ),
                onPressed: login,
                child: Text(
                  'ВОЙТИ',
                  style: TextStyle(
                  color: Colors.white,
                  ),
                 ),
                ),
              ),
              const SizedBox(height: 5),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Нет аккаунта?',
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  ),
                  TextButton(
                    onPressed: () => Navigator.of(context).pushNamed('/registration'),
                    child: Text(
                      'Cоздать',
                      style: TextStyle(
                          color: Colors.white,
                          decoration: TextDecoration.underline),
                    ),
                  ),
                ],
              ),
              Spacer(),
            ],
          ),
        ),
      ),
    );
  }
}

// class LoginPage extends StatelessWidget {
//   const LoginPage({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Container(
//         decoration: BoxDecoration(image: DecorationImage(image: AssetImage('assets/images/background_log.png'),
//         fit: BoxFit.cover)),
//         padding: EdgeInsets.all(30),
//         child: Column(
//           crossAxisAlignment : CrossAxisAlignment.center,
//           children: [
//             Spacer(),
//             TextField(
//               decoration: InputDecoration(
//                 fillColor: Colors.white,
//                 filled: true,
//                 hintText: 'E-mail',
//                 border: UnderlineInputBorder(
//                     borderRadius: BorderRadius.all(Radius.circular(25))),
//               ),
//             ),
//             SizedBox(
//               height: 15,
//             ),
//             TextField(
//               decoration: InputDecoration(
//                 fillColor: Colors.white,
//                 filled: true,
//                 hintText: 'Пароль',
//                 border: UnderlineInputBorder(
//                     borderRadius: BorderRadius.all(Radius.circular(25))),
//               ),
//             ),
//             Align(
//               alignment: Alignment.centerRight,
//               child: TextButton(
//                 onPressed: null,
//                 child: Text(
//                   'Забыли пароль?',
//                   style: TextStyle(
//                       color: Colors.white,
//                       decoration: TextDecoration.underline),
//                 ),
//               ),
//             ),
//             SizedBox(
//               height: 40,
//             ),
//             SizedBox(
//               height: 50,
//               width: 135,
//               child: ElevatedButton(
//                 style: ElevatedButton.styleFrom(
//                   backgroundColor: Color(0xff514FFF),
//                   shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(25))),
//                 ),
//                 onPressed: (){
//                     Navigator.of(context).pushNamed(Routes.home);
//                   },
//                 child: Text(
//                   'ВОЙТИ',
//                   style: TextStyle(
//                   color: Colors.white,
//                   ),
//                 ),
//               ),
//             ),
//             Row(
//               mainAxisAlignment: MainAxisAlignment.center,
//               children: [
//                 Text(
//                   'Нет аккаунта?',
//                   style: TextStyle(
//                     color: Colors.white,
//                   ),
//                 ),
//                 TextButton(
//                   onPressed: (){
//                     Navigator.of(context).pushNamed(Routes.register);
//                   },
//                   child: Text(
//                     'Cоздать',
//                     style: TextStyle(
//                         color: Colors.white,
//                         decoration: TextDecoration.underline),
//                   ),
//                 ),
//               ],
//             ),
//             Spacer(),
//           ],
//         ),
//       ),
//     );
//   }
// }
