//En este file creamos la pagina para que el user inserte su correo en caso de que olvide su contraseña al logearse

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class ForgotPasswordPage extends StatefulWidget {
  const ForgotPasswordPage({Key? key}) : super(key: key);

  @override
  State<ForgotPasswordPage> createState() => _ForgotPasswordPageState();
}

class _ForgotPasswordPageState extends State<ForgotPasswordPage> {

  final _emailController = TextEditingController();

  @override
  void dispose(){
    //TODO: implement dispose
    _emailController.dispose();
    super.dispose();
  }

  Future passwordReset() async {
    final cuentaEmail = _emailController.text.trim();

    try {
      await FirebaseAuth.instance.sendPasswordResetEmail(email: cuentaEmail);
      showDialog<void>(
          context: context,
          barrierDismissible: true,
          builder: (BuildContext dialogContext){
            return AlertDialog(
              title: const Text('Password Recovery'),
              content: Text('An Email has send to the account $cuentaEmail'),
              actions: <Widget>[
                TextButton(
                  onPressed: () {
                    Navigator.of(dialogContext).pop();
                  },
                  child: const Text('Close')
                )
              ],
            );
          }
      );
    }
    on FirebaseAuthException catch(e){
      print(e);
      showDialog<void>(
        context: context,
        barrierDismissible: true,
        builder: (BuildContext dialogContext){
          return AlertDialog(
            title: const Text('Firebase Error'),
            content: Text('Email Error: $e'),
            actions: <Widget>[
              TextButton(
                child: const Text('Close'),
                onPressed: () {
                  Navigator.of(dialogContext).pop();
                },
              )
            ],
          );
        }
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      
      appBar: AppBar(
        backgroundColor: Colors.deepPurple[200],
        elevation: 0,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 25.0),
            child: Text(
              'Insert your Email for send you an password restore',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 20),
            ),
            ),
          const SizedBox(height: 20),

          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 25.0),
            child: TextField(
              controller: _emailController,
              decoration: InputDecoration(
                enabledBorder: OutlineInputBorder(
                  borderSide: const BorderSide(color: Colors.white),
                  borderRadius: BorderRadius.circular(12),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: const BorderSide(color: Colors.deepPurple),
                  borderRadius: BorderRadius.circular(12),
                ),
                hintText: 'Email',
                fillColor: Colors.grey[200],
                filled: true
              ),
            ),
          ),
          const SizedBox(height: 20),

          MaterialButton(
            onPressed: passwordReset,
            color: Colors.deepPurple[200],
            child: const Text(
              'Restore Password',
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 16,
              ),
            ),
          )
        ],
      ),
    );
  }
}
