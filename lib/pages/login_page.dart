//Cristian Quevedo - 2470980
///En este file creamos la pagina de inicio de sesion

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'forgot_password_page.dart';

//
class LoginPage extends StatefulWidget {
  final VoidCallback showRegisterPage;
  const LoginPage({Key? key, required this.showRegisterPage}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {

  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  //metodo que nos ayuda al inicio de sesion
  Future signIn() async{
    await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: _emailController.text.trim(),
        password: _passwordController.text.trim(),
    );
  }

  //Ayuda al gestor de memoria a reciclar los datos que ya no se utilizan
  @override
  void dispose (){
    // TODO: implement dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.black12,
        body: SafeArea(
          child: Center(
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const SizedBox(height: 25),
                  const Icon(
                    Icons.android_outlined,
                    size: 100,
                  ),
                  //Hello user!!
                  Text(
                      'Hello User!!',
                      style: GoogleFonts.bebasNeue(
                          fontSize: 52
                      )
                  ),
                  const SizedBox(height: 70,),
                  const Text(
                    'Welcome back, you\'ve been missed!!',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20,
                    ),
                  ),
                  const SizedBox(height: 50),

                  //email textfield
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextField(
                      controller: _emailController,
                      obscureText: false,
                      decoration: InputDecoration(
                        enabledBorder: OutlineInputBorder(
                          borderSide: const BorderSide(color: Colors.white),
                          borderRadius: BorderRadius.circular(12)
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: const BorderSide(color: Colors.deepPurple),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        hintText: 'E-mail',
                        fillColor: Colors.grey[200],
                        filled: true
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),

                  //password textfield
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextField(
                      controller: _passwordController,
                      obscureText: true,
                      decoration: InputDecoration(
                        enabledBorder: OutlineInputBorder(
                          borderSide: const BorderSide(color: Colors.white),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: const BorderSide(color: Colors.deepPurple),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        hintText: 'Password',
                        fillColor: Colors.grey[200],
                        filled: true
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),

                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 25.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        GestureDetector(
                          onTap: (){
                            Navigator.push(context, MaterialPageRoute(builder: (context){
                              return  const ForgotPasswordPage();
                            }
                            ),
                            );
                          },
                          child: const Text(
                            'Forgot Password?',
                            style: TextStyle(
                              color: Colors.blue,
                              fontWeight: FontWeight.bold
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                  const SizedBox(height: 10),


                  //sing in button
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 25.0),
                    child: GestureDetector(
                      onTap: signIn,
                      child: Container(
                          padding: const EdgeInsets.all(25),
                          decoration: BoxDecoration(color: Colors.deepPurple,
                              borderRadius: BorderRadius.circular(12)
                          ),
                          child: const Center(
                            child: Text('Sing in',style: TextStyle(color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 18,
                            ),
                            ),
                          )
                      ),
                    ),
                  ),
                  const SizedBox(height: 25),

                  //not remember your password
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      const Text(
                          'Not a member?',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                          ),
                      ),
                      GestureDetector(
                        onTap: widget.showRegisterPage,
                        child: const Text(
                            ' Register now!',
                            style: TextStyle(
                              color: Colors.blue,
                              fontWeight: FontWeight.bold,
                            )
                        ),
                      )
                    ],
                  ),
                ],
              ),
            ),
          ),
        )
    );
  }
}
