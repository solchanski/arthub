import 'package:arthub/config/routes.dart';
import 'package:flutter/material.dart';
import 'package:email_validator/email_validator.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:arthub/pages/services/snack_bar.dart';

class RegistrationPage extends StatefulWidget {
  const RegistrationPage({super.key});

  @override
  State<RegistrationPage> createState() => RegistrationPageState();
}

class RegistrationPageState extends State<RegistrationPage> {
  bool isHiddenPassword = true;
  TextEditingController emailTextInputController = TextEditingController();
  TextEditingController passwordTextInputController = TextEditingController();
  TextEditingController passwordTextRepeatInputController =
      TextEditingController();
  final formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    emailTextInputController.dispose();
    passwordTextInputController.dispose();
    passwordTextRepeatInputController.dispose();

    super.dispose();
  }

  void togglePasswordView() {
    setState(() {
      isHiddenPassword = !isHiddenPassword;
    });
  }

  Future<void> signUp() async {
    final navigator = Navigator.of(context);

    final isValid = formKey.currentState!.validate();
    if (!isValid) return;

    if (passwordTextInputController.text !=
        passwordTextRepeatInputController.text) {
      SnackBarService.showSnackBar(
        context,
        'Пароли должны совпадать',
        true,
      );
      return;
    }

    try {
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: emailTextInputController.text.trim(),
        password: passwordTextInputController.text.trim(),
      );
    } on FirebaseAuthException catch (e) {
      print(e.code);

      if (e.code == 'email-already-in-use') {
        SnackBarService.showSnackBar(
          context,
          'Такой Email уже используется, повторите попытку с использованием другого Email',
          true,
        );
        return;
      } else {
        SnackBarService.showSnackBar(
          context,
          'Неизвестная ошибка! Попробуйте еще раз или обратитесь в поддержку.',
          true,
        );
      }
    }

    navigator.pushNamedAndRemoveUntil('/', (Route<dynamic> route) => false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Container(
        decoration: BoxDecoration(image: DecorationImage(image: AssetImage('assets/images/background_reg.png'),
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
                      borderRadius: BorderRadius.all(Radius.circular(25))),
                ),
              ),
              const SizedBox(height: 15),
              TextFormField(
                autocorrect: false,
                controller: passwordTextInputController,
                obscureText: isHiddenPassword,
                autovalidateMode: AutovalidateMode.onUserInteraction,
                validator: (value) => value != null && value.length < 6
                    ? 'Минимум 6 символов'
                    : null,
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
              const SizedBox(height: 15),
              TextFormField(
                autocorrect: false,
                controller: passwordTextRepeatInputController,
                obscureText: isHiddenPassword,
                autovalidateMode: AutovalidateMode.onUserInteraction,
                validator: (value) => value != null && value.length < 6
                    ? 'Минимум 6 символов'
                    : null,
                decoration: InputDecoration(
                  fillColor: Colors.white,
                  filled: true,
                  hintText: 'Повторите пароль',
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
              const SizedBox(height: 40),
              SizedBox(
                height: 50,
                width: 270,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color(0xffDA480A),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(25))),
                  ),
                  onPressed: signUp,
                  child: Text(
                    'СОЗДАТЬ АККАУНТ',
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
                    'Уже есть аккаунт?',
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  ),
                  TextButton(
                  onPressed: () => Navigator.of(context).pop(),
                    child: Text(
                      'Войти',
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


//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Container(
//         decoration: BoxDecoration(image: DecorationImage(image: AssetImage('assets/images/background_reg.png'),
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
//                 hintText: 'Имя пользователя',
//                 border: UnderlineInputBorder(
//                     borderRadius: BorderRadius.all(Radius.circular(25))),
//               ),
//             ),
//             SizedBox(
//               height: 15,
//             ),TextField(
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
//             SizedBox(
//               height: 15,
//             ),
//             TextField(
//               decoration: InputDecoration(
//                 fillColor: Colors.white,
//                 filled: true,
//                 hintText: 'Повторите пароль',
//                 border: UnderlineInputBorder(
//                     borderRadius: BorderRadius.all(Radius.circular(25))),
//               ),
//             ),
//             SizedBox(
//               height: 40,
//             ),
//             SizedBox(
//               height: 50,
//               width: 270,
//               child: ElevatedButton(
//                 style: ElevatedButton.styleFrom(
//                   backgroundColor: Color(0xffDA480A),
//                   shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(25))),
//                 ),
//                 onPressed: (){
//                     Navigator.of(context).pushNamed(Routes.home);
//                   },
//                 child: Text(
//                   'СОЗДАТЬ АККАУНТ',
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
//                   'Уже есть аккаунт?',
//                   style: TextStyle(
//                     color: Colors.white,
//                   ),
//                 ),
//                 TextButton(
//                   onPressed: (){
//                     Navigator.of(context).pushNamed(Routes.login);
//                   },
//                   child: Text(
//                     'Войти',
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
