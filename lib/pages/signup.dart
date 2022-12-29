import 'package:flutter/material.dart';
import 'package:shop/pages/homepage.dart';
import 'package:shop/pages/verification_page.dart';
import 'package:shop/services/firebase_services.dart';

class Email {
  String emailAddress;
  Email({required this.emailAddress});
}

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  _SignUpPageState createState() => _SignUpPageState();
  static String routeName = '/sign-up';
}

class _SignUpPageState extends State<SignUpPage> {
  final _formKey = GlobalKey<FormState>();
  bool _isLogin = true;
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  TextEditingController userName = TextEditingController();
  FirebaseServices firebaseServices = FirebaseServices();
  bool isLoading = false;
  void signInOrSignUp() async {
    setState(() {
      isLoading = true;
    });
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      if (_isLogin) {
        if (await firebaseServices.emailSignIn(
                email.text.trim(), password.text, context) !=
            null) {
          Navigator.pushReplacementNamed(context, HomePage.routeName);
        }
      } else {
        if (await firebaseServices.emailSignUp(
                email.text, password.text, context) !=
            null) {
          Navigator.pushNamed(context, VerificatonPage.routeName,
              arguments: Email(emailAddress: email.text));
        }
      }
    }
    setState(() {
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Padding(
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 50),
      child: SafeArea(
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Row(
                children: [
                  Text(
                    _isLogin ? 'Log In' : 'Sign Up',
                    style: const TextStyle(
                        fontWeight: FontWeight.bold, fontSize: 30),
                  ),
                ],
              ),
              if (!_isLogin)
                TextFormField(
                  controller: userName,
                  validator: ((value) {
                    if (value!.isEmpty) {
                      return 'Cannot be  empty';
                    }
                    return null;
                  }),
                  style: const TextStyle(color: Colors.purple),
                  decoration: const InputDecoration(
                    focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.purple),
                    ),
                    hintText: "User Name",
                  ),
                ),
              TextFormField(
                controller: email,
                validator: ((value) {
                  if (value!.isEmpty) {
                    return 'Cannot be  empty';
                  }
                  return null;
                }),
                style: const TextStyle(color: Colors.purple),
                decoration: const InputDecoration(
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.purple),
                  ),
                  hintText: "Email",
                ),
              ),
              TextFormField(
                controller: password,
                validator: ((value) {
                  if (value!.isEmpty) {
                    return 'Cannot be  empty';
                  }
                  return null;
                }),
                style: const TextStyle(color: Colors.purple),
                decoration: const InputDecoration(
                    focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.purple),
                    ),
                    hintText: "Password",
                    fillColor: Colors.purple,
                    focusColor: Colors.purple),
              ),
              if (_isLogin)
                Row(
                  children: [
                    TextButton(
                        onPressed: () {},
                        child: const Text(
                          'Forgot Password ?',
                          style: TextStyle(color: Colors.black),
                        ))
                  ],
                ),
              SizedBox(
                width: 135,
                height: 40,
                child: isLoading
                    ? const Center(
                        child: CircularProgressIndicator(
                          color: Colors.purple,
                        ),
                      )
                    : ElevatedButton(
                        style: ButtonStyle(
                          backgroundColor:
                              MaterialStateProperty.all(Colors.purple),
                        ),
                        onPressed: () {
                          signInOrSignUp();
                        },
                        child: Text(
                          _isLogin ? 'Log In' : 'Sign Up',
                          style: const TextStyle(fontSize: 15),
                        )),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(_isLogin
                      ? "Don't have accout?"
                      : "Already have an account?"),
                  TextButton(
                      onPressed: () {
                        setState(() {
                          _isLogin = !_isLogin;
                          email.text = '';
                          password.text = '';
                          userName.text = '';
                        });
                      },
                      child: Text(
                        _isLogin ? "Sign Up" : 'Log In',
                        style: const TextStyle(
                            color: Colors.purple, fontWeight: FontWeight.bold),
                      ))
                ],
              )
            ],
          ),
        ),
      ),
    ));
  }
}
