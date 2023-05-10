import 'package:flutter/material.dart';
class pixel_vide extends StatelessWidget {
  const pixel_vide({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
                      padding: const EdgeInsets.all(4.0),
                      child: Container(
                       // height: 10,
                        //width: 10,
                        decoration: BoxDecoration(
                            color: Colors.grey[900],
                            borderRadius: BorderRadius.circular(4)),
                      ),
                    );
  }
}