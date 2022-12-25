import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:shop/pages/signup.dart';
import 'package:shop/services/firebase_services.dart';

class VerificatonPage extends StatefulWidget {
  const VerificatonPage({super.key});
  static String routeName = '/verify';

  @override
  State<VerificatonPage> createState() => _VerificatonPageState();
}

class _VerificatonPageState extends State<VerificatonPage> {
  FirebaseServices _firebaseServices = FirebaseServices();
  @override
  void initState() {
    print('hey');
    _firebaseServices.sendVerificationEmailAndNavigate(context);

    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context)!.settings.arguments as Email;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.purple,
        title: const Center(child: Text('Verify Emial')),
      ),
      body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Verifying Email: ',
                  style: TextStyle(fontSize: 15),
                ),
                GestureDetector(
                  onTap: () async {
                    await FirebaseAuth.instance.currentUser!.delete();
                    Navigator.of(context).pop();
                  },
                  child: Text(
                    args.emailAddress,
                    style: TextStyle(
                        fontSize: 17,
                        fontWeight: FontWeight.bold,
                        decoration: TextDecoration.underline),
                  ),
                ),
                IconButton(
                    onPressed: () async {
                      await FirebaseAuth.instance.currentUser!.delete();
                      Navigator.of(context).pop();
                    },
                    icon: Icon(Icons.edit))
              ],
            ),
            SizedBox(
              height: 10,
            ),
            ElevatedButton.icon(
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all(Colors.purple),
              ),
              onPressed: () {},
              icon: Icon(Icons.email),
              label: Text('Resend Email'),
            )
          ]),
    );
  }
}
