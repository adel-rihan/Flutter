import 'package:flutter/material.dart';

Widget metalItem(
  context, {
  required bool gold,
  required int price,
}) =>
    Column(
      children: [
        Image.asset(
          gold ? 'assets/images/gold.png' : 'assets/images/silver.png',
          height: MediaQuery.of(context).size.height / 5,
          width: MediaQuery.of(context).size.width / 2.5,
        ),
        Text(
          gold ? 'Gold' : 'Silver',
          style: TextStyle(
            fontSize: 28,
            fontWeight: FontWeight.bold,
            color: gold ? Colors.orange : Colors.grey,
            shadows: [
              BoxShadow(
                color: gold ? Colors.yellow[300]! : Colors.grey[300]!,
                offset: const Offset(2, 2),
                blurRadius: 5,
              )
            ],
          ),
        ),
        Text(
          '$price EGP',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Colors.green,
            shadows: [
              BoxShadow(
                color: Colors.lightGreen[200]!,
                offset: const Offset(2, 2),
                blurRadius: 5,
              )
            ],
          ),
        ),
      ],
    );
