import 'package:flutter/material.dart';
class pixel_serpent extends StatelessWidget {
  const pixel_serpent({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
                      padding: const EdgeInsets.all(4.0),
                      child: Container(
                       // height: 10,
                        //width: 10,
                        decoration: BoxDecoration(
                            color: Colors.orange[900],
                            borderRadius: BorderRadius.circular(4)),
                      ),
                    );
  }
}