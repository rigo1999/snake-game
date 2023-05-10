import 'package:flutter/material.dart';

class pixel_nouri extends StatelessWidget {
  const pixel_nouri({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(4.0),
      child: Container(
        // height: 10,
        //width: 10,
        decoration: BoxDecoration(
            color: Colors.green, borderRadius: BorderRadius.circular(4)),
      ),
    );
  }
}
