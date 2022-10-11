//Cristian Quevedo - 2470980
///En este file creamos la pgina de registro

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_fonts/google_fonts.dart';


class RegisterPage extends StatefulWidget {
  final VoidCallback showLoginPage;
  const RegisterPage({Key? key, required this.showLoginPage}) : super(key: key);

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {

  //definimos los controladores para los textfields
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  final _firstNameController = TextEditingController();
  final _surNameController = TextEditingController();

  //conectamos la base de datos con los controladores
  Future signIn() async{
    if (passwordConfirmed()){
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: _emailController.text.trim(),
        password: _passwordController.text.trim(),
      );

      // add user details
      //son los controladores de los datos que le solicitamos al usuario para poder registrarse
      addUserDetails(
        _firstNameController.text.trim(),
        _surNameController.text.trim(),
        _emailController.text.trim(),
        _passwordController.text.trim(),
      );

    }
  }

  //
  Future addUserDetails(
      String firstName,
      String surName,
      String email,
      String password
      ) async {
    await FirebaseFirestore.instance.collection('Accounts').add({
      'first name': firstName,
      'surname': surName,
      'email': email,
      'password': password
    });
  }

  //condicionamos que la contraseña que digita el usuario sea la misma en los dos textfields
  bool passwordConfirmed(){
    if(_passwordController.text.trim() == _confirmPasswordController.text.trim()){
      return true;
    }else {
      return false;
    }
  }

  //limpia el estado en cada textfield
  @override
  void dispose(){
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    _firstNameController.dispose();
    _surNameController.dispose();
    super.dispose();
  }

  //damos diseño y funcionalidad a nuestro login
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //definimos un fondo de color para nuestra page
        backgroundColor: Colors.grey[300],
        body: SafeArea(
          child: Center(
            //funcionalidad del scroll en nuestra pagina
            child: SingleChildScrollView(
              //almacenamos todo en un column
              child: Column(
                //alineamos todo en el centro
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  //espacio entre el top de la pagina con la box
                  const SizedBox(height: 10),
                  //Hello user!!
                  Text(
                      'Hello User!!',
                      style: GoogleFonts.bebasNeue(
                        fontSize: 60,
                      )
                  ),
                  //espacio entre las dos cajas
                  const SizedBox(height: 10,),

                  const Text(
                    'Register your dates now!!',
                    style: TextStyle(
                      fontSize: 20,
                    ),
                  ),
                  const SizedBox(height: 40),

                  //name textfield
                  Padding(
                    //definimos el espacio que tendra
                    padding: const EdgeInsets.symmetric(horizontal: 25.0),
                    //se define el textfield para que el usuario ingrese su nombre
                    child: TextField(
                      //definimos el controlador para ese campo
                      controller: _firstNameController,
                      //se le da diseño a el textfiel
                      decoration: InputDecoration(
                        enabledBorder: OutlineInputBorder(
                          borderSide: const BorderSide(color: Colors.white),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: const BorderSide(color: Colors.deepPurple),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        //se pone un titulo para ese textfield (una vez el user digite algo se borrara automaticamente
                        hintText: 'Name',
                        fillColor: Colors.grey[200],
                        filled: true,
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),

                  //surname TextField
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 25.0),
                    child: TextField(
                      controller: _surNameController,
                      decoration: InputDecoration(
                        enabledBorder: OutlineInputBorder(
                          borderSide: const BorderSide(color: Colors.white),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: const BorderSide(color: Colors.deepPurple),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        hintText: 'Surname',
                        fillColor: Colors.grey[200],
                        filled: true
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),

                  //email textfield
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
                  const SizedBox(height: 10),

                  //password textfield
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 25.0),
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
                  const SizedBox(height: 20),

                  //password confirm textfield
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 25.0),
                    child: TextField(
                      controller: _confirmPasswordController,
                      obscureText: true,
                      decoration: InputDecoration(
                        enabledBorder: OutlineInputBorder(
                          borderSide:  const BorderSide(color: Colors.white),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: const BorderSide(color: Colors.deepPurple),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        hintText: 'Confirm Password',
                        fillColor: Colors.grey[200],
                        filled: true
                      ),
                    )
                  ),
                  const SizedBox(height: 20),

                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 30.0),
                      child: GestureDetector(
                        onTap: signIn,
                        child: Container(
                            padding: const EdgeInsets.all(15.0),
                            decoration: BoxDecoration(
                                color: Colors.deepPurple,
                                borderRadius: BorderRadius.circular(12)
                            ),
                            child: const Center(
                              child: Text(
                                'Sing in',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16,
                                ),
                              ),
                            )
                        ),
                      ),
                  ),
                  const SizedBox(height: 30),

                  //not remember your password
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      const Text(
                        'I\'m a member',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      //este detector nos enviara a la pagina de registro en caso de que el user de click en la palabra marcada con color azul
                      GestureDetector(
                        onTap: widget.showLoginPage,
                        child: const Text(
                            ' Sign In!',
                            style: TextStyle(
                              color: Colors.blue,
                              fontWeight: FontWeight.bold,
                            )
                        ),
                      )
                    ],
                  ),
                  const SizedBox(height: 20),
                ],
              ),
            ),
          ),
        )
    );
  }
}
