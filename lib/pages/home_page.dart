
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../data/get_user_name.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  final user = FirebaseAuth.instance.currentUser!;

  //lista de identificadores
  List<String> docIds = [];

  //metodo para obtener los id
  Future getDocId() async {
    await FirebaseFirestore.instance.collection('cuentas').get().then(
      (snapshot) => snapshot.docs.forEach((document) {
        print(document.reference);
        docIds.add(document.reference.id);
      })
    );
  }

  @override
  void initState(){
    getDocId();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Welcome! ${user.email!}',
              style: const TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.bold,
                fontSize: 16,
              ),
            ),
            MaterialButton(
              onPressed: (){
                FirebaseAuth.instance.signOut();
              },
              color: Colors.deepPurple[200],
              child: const Text(
                'Sing Out',
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
            ),
            Expanded(
              child: FutureBuilder(
                future: getDocId(),
                builder: (context, snapshot){
                  return ListView.builder(
                    itemCount: docIds.length,
                    itemBuilder: (context, index){
                      return ListTile(
                        title: GetUserName(documentId: docIds[index]),
                      );
                    }
                  );
                },
              )
            )
          ],
        ),
      ),
    );
  }
}
