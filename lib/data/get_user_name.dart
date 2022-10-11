import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class GetUserName extends StatelessWidget {

  final String documentId;

  const GetUserName({required this.documentId});

  @override
  Widget build(BuildContext context) {

    CollectionReference users = FirebaseFirestore.instance.collection('Account');

    return FutureBuilder<DocumentSnapshot>(
      future: users.doc(documentId).get(),
      builder: ((context, snapshot){
        if(snapshot.connectionState == ConnectionState.done){
          Map<String, dynamic> data =
          snapshot.data!.data() as Map<String, dynamic>;
          return Text('User Name:  ${data['first name']} ${data['sur name']}');
        }
        return const Text('Loading...');
      }),
    );
  }
}
