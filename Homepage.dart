import 'dart:async';
import 'dart:math';

//import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:snaky/pixel_nouri.dart';
import 'package:snaky/pixel_serpent.dart';
import 'meilleurscore.dart';
import 'pixel_vide.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}
//creation du enum, il permet d'etablir le nombre de direction possible

enum directionSerpent { UP, DOWN, LEFT, RIGHT }

class _HomePageState extends State<HomePage> {
  final _noncontroller = TextEditingController();
  int nbreTotaldecaree = 100;
  int tailleLigne = 10;
  int scoreactuel = 0;
  //cette valeur bool a ete creer pour controller le button jouer
  bool jeudebuter = false;
  // position du serpent
  //creation d'une liste
  List<int> positionSerpent = [
    0,
    1,
    2,
  ];
  //liste des meilleurs score
//  List<String> meilleurscore_DocIds = [];
  //late final Future? letsGetDocIds;

 /* @override
  //initialisation de l'etat du doc
  void initState() {
    letsGetDocIds = getDocId();
    // TODO: implement initState
    super.initState();
  }*/

 /* Future getDocId() async {
    await FirebaseFirestore.instance
        .collection("meilleurscore")
        .orderBy("score", descending: true)
        .limit(5)
        .get()
        .then((value) => value.docs.forEach((element) {
              meilleurscore_DocIds.add(element.reference.id);
            }));
  }*/

  //par defaut la direction du serpent est la doite
  var directionactuel = directionSerpent.LEFT;
  //position de la nourriture
  int positionNouri = 42;
  //jouer
  void commenceJeu() {
    jeudebuter = true;

    Timer.periodic(Duration(milliseconds: 200), (timer) {
      setState(() {
        deplacerSpert();
        //veerifier si le jeu est SliverGridDelegateWithFixedCrossAxisCount
        //le serpent cesse de se deplacer si la fonction fin de jeu s'avere applicable
        if (finJeu()) {
          timer.cancel();
          //on affiche un message à l'ecarn
          showDialog(
              barrierDismissible: true,
              context: context,
              builder: (context) {
                return AlertDialog(
                  title: Center(child: Text('F i n  d u  j e u ')),
                  content: Column(
                    children: [
                      Text(
                        " votre Score actuel est de :" + scoreactuel.toString(),
                      ),
                      TextField(
                        controller: _noncontroller,
                        decoration: InputDecoration(
                          hintText: 'Entrer votre nom',
                        ),
                      )
                    ],
                  ),
                  actions: [
                    MaterialButton(
                      onPressed: () {
                        Navigator.pop(context);
                        //commencer un nouveau jeu
                        //entrerScore();
                        commenceNouveauJeu();
                      },
                      child: Text("Entrer"),
                    )
                  ],
                );
              });
        }
      });
    });
  }

//commence nouveau jeu si le serpent se mord
  void commenceNouveauJeu() {
   /* meilleurscore_DocIds=[];
    await getDocId();*/
    setState(() {
      positionSerpent = [
        0,
        1,
        2,
      ];
      positionNouri = 42;
      directionactuel = directionSerpent.RIGHT;
      jeudebuter = false;
      scoreactuel = 0;
    });
  }

  //creation de la methide entrerscore
  /*void entrerScore() {
    //entrer dans la collection
    //creation de la base de données
    var database = FirebaseFirestore.instance;
    database.collection('meilleurscore').add({
      "nom": _noncontroller.text,
      "score": scoreactuel,
    });
  }*/

  void deplacerSpert() {
    switch (directionactuel) {
      case directionSerpent.DOWN:
        {
          /*positionSerpent.add(positionSerpent.last + tailleLigne);
          //retrait de la tete
          positionSerpent.removeAt(0);*/
          if (positionSerpent.last + tailleLigne > nbreTotaldecaree) {
            //pour rester dans la la gridview
            positionSerpent
                .add(positionSerpent.last + tailleLigne - nbreTotaldecaree);
          } else {
            positionSerpent.add(positionSerpent.last + tailleLigne);
          }
          // positionSerpent.removeAt(0);
        }
        break;
      case directionSerpent.UP:
        {
          /*/ajout de tete
          positionSerpent.add(positionSerpent.last - tailleLigne);
          //retrait de la tete
          positionSerpent.removeAt(0);*/
          if (positionSerpent.last < tailleLigne) {
            //pour rester dans la la gridview
            positionSerpent
                .add(positionSerpent.last - tailleLigne + nbreTotaldecaree);
          } else {
            positionSerpent.add(positionSerpent.last - tailleLigne);
          }
          //positionSerpent.removeAt(0);
        }
        break;
      case directionSerpent.RIGHT:
        {
          if (positionSerpent.last % tailleLigne == 9) {
            positionSerpent.add(positionSerpent.last + 1 - tailleLigne);
          } else {
            positionSerpent.add(positionSerpent.last + 1);
          }
          //positionSerpent.removeAt(0);
        }
        break;
      case directionSerpent.LEFT:
        {
          /*ajout de tete
          positionSerpent.add(positionSerpent.last - 1);
          //retrait de la tete
          positionSerpent.removeAt(0); */
          if (positionSerpent.last % tailleLigne == 0) {
            positionSerpent.add(positionSerpent.last - 1 + tailleLigne);
          } else {
            positionSerpent.add(positionSerpent.last - 1);
          }
        }
        break;
      default:
    }

    //si la position du dernier index du serpent est egal a la position de la nouriture alors le serpent s'allong
    if (positionSerpent.last == positionNouri) {
      mangerNouri();
    } else {
      positionSerpent.removeAt(0);
    }
  }

  //fonction pour manger la nouriture
  void mangerNouri() {
    scoreactuel++;
    while (positionSerpent.contains(positionNouri)) {
      //la fonction random permet de generer une position aleatoir de la nouriture
      positionNouri = Random().nextInt(nbreTotaldecaree);
    }
  }

  bool finJeu() {
    //le jeu prend fin lorsque le serpent se touche

    //cela se produit lorsque que il y a un doublon dans la list position serpent
    //creons une sous liste contenant les nouveau index de la list position serpent
    // c'est le corps du serpent sans la tête
    List<int> corpsSerpent =
        positionSerpent.sublist(0, positionSerpent.length - 1);
    //"positionSerpent.length" no,bres d"element dans la list sauf le dernier element sui est la tete du serpent
    if (corpsSerpent.contains(positionSerpent.last)) {
      return true;
    }
    return false;
  }

  @override
  Widget build(BuildContext context) {
    //gerer la responsivite de l'ecran
    double laregeurEcran = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Colors.black,
      body: SizedBox(
        width: laregeurEcran > 400 ? 400 : laregeurEcran,
        child: Column(
          children: [
            //score elevee
            Expanded(
                child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                //score utilisateur
                Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text("Score actuel"),
                        Text(
                          scoreactuel.toString(),
                          style: TextStyle(fontSize: 30),
                        ),
                      ],
                    ),
                  ),
                ),
                //score le plus elevé
                Expanded(
                  child : Container(
                    child: Text('S c o r e'),
                  ),
                  /*child: jeudebuter?Container():FutureBuilder(builder: ((context, snapshot) {
                    future:
                    letsGetDocIds;
                    return ListView.builder(itemBuilder: ((context, index) {
                      return meilleurScore(
                          documentId: meilleurscore_DocIds[index]);
                    }));
                  }))*/
                )
              ],
            )),
            //grille de jeu
            Container(
              child: Expanded(
                flex: 5,
                child: Padding(
                  padding: const EdgeInsets.all(4.0),
                  child: GestureDetector(
                    onVerticalDragUpdate: (details) {
                      if (details.delta.dy > 0 &&
                          directionactuel != directionSerpent.UP) {
                        directionactuel = directionSerpent.DOWN;
                      } else if (details.delta.dy < 0 &&
                          directionactuel != directionSerpent.DOWN) {
                        directionactuel = directionSerpent.UP;
                      }
                      ;
                    },
                    onHorizontalDragUpdate: ((details) {
                      if (details.delta.dx > 0 &&
                          directionactuel != directionSerpent.LEFT) {
                        directionactuel = directionSerpent.RIGHT;
                      } else if (details.delta.dx < 0 &&
                          directionactuel != directionSerpent.RIGHT) {
                        directionactuel = directionSerpent.LEFT;
                      }
                      ;
                    }),
                    child: GridView.builder(
                      physics: NeverScrollableScrollPhysics(),
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: tailleLigne,
                      ),
                      itemCount: nbreTotaldecaree,
                      itemBuilder: (context, int index) {
                        if (positionSerpent.contains(index)) {
                          return const pixel_serpent();
                        } else if (positionNouri == index) {
                          return const pixel_nouri();
                        } else {
                          return const pixel_vide();
                        }
                        ;
                      },
                    ),
                  ),
                ),
                // color: Colors.black,
              ),
            ),
            //button de jeu
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: Expanded(
                  child: Container(
                child: MaterialButton(
                  child: Text("Jouer"),
                  //j'ai utiliser ici les conditions ternaire pour changer la couleur du bouton en fonction de jeu debuter ou non
                  color: jeudebuter ? Colors.grey : Colors.orange,
                  onPressed: jeudebuter ? () {} : commenceJeu,
                ),
                //color: Colors.orange,
              )),
            ),
          ],
        ),
      ),
    );
  }
}
