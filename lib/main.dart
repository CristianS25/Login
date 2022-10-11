//Cristian Quevedo - 2470980
///Este file es el que nos permite usar y/o ver nuestra app flutter

import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'auth/main_page.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    //Retornamos el material desing
    return const MaterialApp(
      //quitamos el banner de flutter en nuestra app
      debugShowCheckedModeBanner: false,
      //el home es nuestra "pantalla principal" por ende definimos MainPage, que se encuentra en uno de los files importados
      home: MainPage(),
    );
  }
}
