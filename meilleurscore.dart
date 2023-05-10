import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class meilleurScore extends StatelessWidget {
  final String documentId;
  const meilleurScore({Key? key, required this.documentId}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    //collection des meilleur score
    CollectionReference meilleurscore =
        FirebaseFirestore.instance.collection('meilleurscore');

    return FutureBuilder<DocumentSnapshot>(
      future: meilleurscore.doc(documentId).get(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          Map<String, dynamic> data =
              snapshot.data!.data() as Map<String, dynamic>;
              return Row(children: [
                Text(data['score'].toString()),
                SizedBox(width: 10,),
                Text(data["nom"])
              ],);
        } else {
          return Text('chargement...');
        }
      },
    );
  }
}
