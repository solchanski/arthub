import 'dart:typed_data';
import 'package:arthub/providers/user_provider.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:image_picker/image_picker.dart';
import 'package:arthub/resources/auth_methods.dart';
import 'package:arthub/responsive/mobile_screen_layout.dart';
import 'package:arthub/pages/auth/login_page.dart';
import 'package:arthub/utils/colors.dart';
import 'package:arthub/utils/utils.dart';
import 'package:provider/provider.dart';

class RegistrationPage extends StatefulWidget {
  const RegistrationPage({Key? key}) : super(key: key);

  @override
  State<RegistrationPage> createState() => _RegistrationPageState();
}

class _RegistrationPageState extends State<RegistrationPage> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _passwordTextRepeatInputController = TextEditingController();

  bool _isLoading = false;
  bool isHiddenPassword = true;
  // Uint8List? _image;

  @override
  void dispose() {
    super.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _usernameController.dispose();
    _passwordTextRepeatInputController.dispose();
  }

  void togglePasswordView() {
    setState(() {
      isHiddenPassword = !isHiddenPassword;
    });
  }

  void signUpUser() async {
    // set loading to true
    setState(() {
      _isLoading = true;
    });

    // signup user using our authmethodds
    String res = await AuthMethods().signUpUser(
        email: _emailController.text,
        password: _passwordController.text,
        username: _usernameController.text,
        );
    // if string returned is sucess, user has been created
    if (res == "success") {
      setState(() {
        _isLoading = false;
      });
      // navigate to the home screen
      if (context.mounted) {
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(
            builder: (context) => const MobileScreenLayout(),
          ),
        );
      }
    } else {
      setState(() {
        _isLoading = false;
      });
      // show the error
      if (context.mounted) {
        showSnackBar(context, res);
      }
    }
  }

  // selectImage() async {
  //   Uint8List im = await pickImage(ImageSource.gallery);
  //   // set state because we need to display the image we selected on the circle avatar
  //   setState(() {
  //     _image = im;
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: Container(
          decoration: BoxDecoration(image: DecorationImage(image: AssetImage('assets/images/background_reg.png'),
          fit: BoxFit.cover)),
          padding: EdgeInsets.all(30),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Spacer(),
              TextFormField(
                keyboardType: TextInputType.text,
                autocorrect: false,
                controller: _usernameController,
                decoration: InputDecoration(
                    fillColor: Colors.white,
                    filled: true,
                    hintText: 'Имя пользователя',
                    border: UnderlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(25))
                    ),
                 ),
              ),
              const SizedBox(
                height: 15,
              ),
              TextFormField(
                keyboardType: TextInputType.emailAddress,
                autocorrect: false,
                controller: _emailController,
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
              const SizedBox(
                height: 15,
              ),
              TextFormField(
                autocorrect: false,
                controller: _passwordController,
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
                                    ? Icons.visibility_off
                                    : Icons.visibility),
                                onPressed: () {
                                  setState(() {
                                    isHiddenPassword = !isHiddenPassword;
                                  });
                                },
                              ),
                ),
              ),
              const SizedBox(
                height: 15,
              ),     
              const SizedBox(
                height: 40,
              ),
              InkWell(
                onTap: () => {signUpUser(),
                context.read<UserProvider>().refreshUser()},
                child: Container(
                  height: 60,
                  width: 220,
                  alignment: Alignment.center,
                  padding: const EdgeInsets.symmetric(vertical: 12),
                  decoration: const ShapeDecoration(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(30)),
                    ),
                    color: orangeColor,
                  ),
                  child: !_isLoading
                      ? const Text(
                          'СОЗДАТЬ АККАУНТ',
                          style: TextStyle(
                          color: primaryColor,
                          fontWeight: FontWeight.bold,
                          ),
                        )
                      : const CircularProgressIndicator(
                          color: primaryColor,
                        ),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(vertical: 8),
                    child: const Text(
                      'Уже есть аккаунт? ',
                      style: TextStyle(
                       color: Colors.white,),
                    ),
                  ),
                  GestureDetector(
                    onTap: () => Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => const LoginPage(),
                      ),
                    ),
                    child: Container(
                      padding: const EdgeInsets.symmetric(vertical: 8),
                      child: const Text(
                        'Войти',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                          decoration: TextDecoration.underline,
                        ),
                      ),
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

// import 'package:arthub/config/routes.dart';
// import 'package:flutter/material.dart';
// import 'package:email_validator/email_validator.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:arthub/pages/services/snack_bar.dart';

// class RegistrationPage extends StatefulWidget {
//   const RegistrationPage({super.key});

//   @override
//   State<RegistrationPage> createState() => RegistrationPageState();
// }

// class RegistrationPageState extends State<RegistrationPage> {
//   bool isHiddenPassword = true;
//   TextEditingController emailTextInputController = TextEditingController();
//   TextEditingController passwordTextInputController = TextEditingController();
//   TextEditingController passwordTextRepeatInputController =
//       TextEditingController();
//   final formKey = GlobalKey<FormState>();

//   @override
//   void dispose() {
//     emailTextInputController.dispose();
//     passwordTextInputController.dispose();
//     passwordTextRepeatInputController.dispose();

//     super.dispose();
//   }

//   void togglePasswordView() {
//     setState(() {
//       isHiddenPassword = !isHiddenPassword;
//     });
//   }

//   Future<void> signUp() async {
//     final navigator = Navigator.of(context);

//     final isValid = formKey.currentState!.validate();
//     if (!isValid) return;

//     if (passwordTextInputController.text !=
//         passwordTextRepeatInputController.text) {
//       SnackBarService.showSnackBar(
//         context,
//         'Пароли должны совпадать',
//         true,
//       );
//       return;
//     }

//     try {
//       await FirebaseAuth.instance.createUserWithEmailAndPassword(
//         email: emailTextInputController.text.trim(),
//         password: passwordTextInputController.text.trim(),
//       );
//     } on FirebaseAuthException catch (e) {
//       print(e.code);

//       if (e.code == 'email-already-in-use') {
//         SnackBarService.showSnackBar(
//           context,
//           'Такой Email уже используется, повторите попытку с использованием другого Email',
//           true,
//         );
//         return;
//       } else {
//         SnackBarService.showSnackBar(
//           context,
//           'Неизвестная ошибка! Попробуйте еще раз или обратитесь в поддержку.',
//           true,
//         );
//       }
//     }

//     navigator.pushNamedAndRemoveUntil(Routes.home, (Route<dynamic> route) => false);
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       resizeToAvoidBottomInset: false,
//       body: Container(
//         decoration: BoxDecoration(image: DecorationImage(image: AssetImage('assets/images/background_reg.png'),
//         fit: BoxFit.cover)),
//         padding: EdgeInsets.all(30),
//         child: Form(
//           key: formKey,
//           child: Column(
//             children: [
//               Spacer(),
//               TextFormField(
//                 keyboardType: TextInputType.emailAddress,
//                 autocorrect: false,
//                 controller: emailTextInputController,
//                 validator: (email) =>
//                     email != null && !EmailValidator.validate(email)
//                         ? 'Введите правильный Email'
//                         : null,
//                 decoration: InputDecoration(
//                   fillColor: Colors.white,
//                   filled: true,
//                   hintText: 'E-mail',
//                   border: UnderlineInputBorder(
//                       borderRadius: BorderRadius.all(Radius.circular(25))),
//                 ),
//               ),
//               const SizedBox(height: 15),
//               TextFormField(
//                 keyboardType: TextInputType.emailAddress,
//                 autocorrect: false,
//                 controller: emailTextInputController,
//                 decoration: InputDecoration(
//                   fillColor: Colors.white,
//                   filled: true,
//                   hintText: 'Имя пользователя',
//                   border: UnderlineInputBorder(
//                       borderRadius: BorderRadius.all(Radius.circular(25))),
//                 ),
//               ),
//               const SizedBox(height: 15),
//               TextFormField(
//                 autocorrect: false,
//                 controller: passwordTextInputController,
//                 obscureText: isHiddenPassword,
//                 autovalidateMode: AutovalidateMode.onUserInteraction,
//                 validator: (value) => value != null && value.length < 6
//                     ? 'Минимум 6 символов'
//                     : null,
//                 decoration: InputDecoration(
//                   fillColor: Colors.white,
//                   filled: true,
//                   hintText: 'Пароль',
//                   border: UnderlineInputBorder(
//                     borderRadius: BorderRadius.all(Radius.circular(25))
//                   ),
//                   suffixIcon: IconButton(
//                                 icon: Icon(isHiddenPassword
//                                     ? Icons.visibility_off
//                                     : Icons.visibility),
//                                 onPressed: () {
//                                   setState(() {
//                                     isHiddenPassword = !isHiddenPassword;
//                                   });
//                                 },
//                               ),

//                 ),
//               ),
//               const SizedBox(height: 15),
//               TextFormField(
//                 autocorrect: false,
//                 controller: passwordTextRepeatInputController,
//                 obscureText: isHiddenPassword,
//                 autovalidateMode: AutovalidateMode.onUserInteraction,
//                 validator: (value) => value != null && value.length < 6
//                     ? 'Минимум 6 символов'
//                     : null,
//                 decoration: InputDecoration(
//                   fillColor: Colors.white,
//                   filled: true,
//                   hintText: 'Повторите пароль',
//                   border: UnderlineInputBorder(
//                     borderRadius: BorderRadius.all(Radius.circular(25))
//                   ),
//                   suffixIcon: IconButton(
//                                 icon: Icon(isHiddenPassword
//                                     ? Icons.visibility
//                                     : Icons.visibility_off),
//                                 onPressed: () {
//                                   setState(() {
//                                     isHiddenPassword = !isHiddenPassword;
//                                   });
//                                 },
//                               ),

//                 ),
//               ),
//               const SizedBox(height: 40),
//               SizedBox(
//                 height: 50,
//                 width: 270,
//                 child: ElevatedButton(
//                   style: ElevatedButton.styleFrom(
//                     backgroundColor: Color(0xffDA480A),
//                     shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(25))),
//                   ),
//                   onPressed: signUp,
//                   child: Text(
//                     'СОЗДАТЬ АККАУНТ',
//                     style: TextStyle(
//                     color: Colors.white,
//                     ),
//                   ),
//                 ),
//               ),
//               const SizedBox(height: 5),
//               Row(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 children: [
//                   Text(
//                     'Уже есть аккаунт?',
//                     style: TextStyle(
//                       color: Colors.white,
//                     ),
//                   ),
//                   TextButton(
//                   onPressed: () => Navigator.of(context).pop(),
//                     child: Text(
//                       'Войти',
//                       style: TextStyle(
//                           color: Colors.white,
//                           decoration: TextDecoration.underline),
//                     ),
//                   ),
//                 ],
//               ),
//               Spacer(),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }

