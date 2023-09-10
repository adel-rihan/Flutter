import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';

Widget genderCard(
  context, {
  required bool male,
  required void Function()? onTap,
  required bool isSelected,
}) =>
    GestureDetector(
      onTap: onTap,
      child: Card(
        elevation: isSelected ? 4 : 1,
        color: isSelected ? HexColor('#1a1b2c') : HexColor('#101421'),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Icon(
              male ? Icons.male : Icons.female,
              size: 100,
            ),
            Text(
              male ? 'Male'.toUpperCase() : 'Female'.toUpperCase(),
              style: Theme.of(context).textTheme.bodyLarge,
            ),
          ],
        ),
      ),
    );

Widget plusMinCard(
  context, {
  required String title,
  required int value,
  required bool isEnabledMin,
  required bool isEnabledPlus,
  required void Function()? onPressedMin,
  required void Function()? onPressedPlus,
}) =>
    Card(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            title.toUpperCase(),
            style: Theme.of(context).textTheme.bodyLarge,
          ),
          Text(
            value.toString(),
            style: Theme.of(context).textTheme.displayLarge,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              IconButton(
                icon: const Icon(Icons.remove),
                onPressed: isEnabledMin ? onPressedMin : null,
                style: ButtonStyle(
                  backgroundColor:
                      MaterialStatePropertyAll<Color>(HexColor('#424553')),
                  iconSize: const MaterialStatePropertyAll<double>(30),
                ),
              ),
              const SizedBox(width: 10),
              IconButton(
                icon: const Icon(Icons.add),
                onPressed: isEnabledPlus ? onPressedPlus : null,
                style: ButtonStyle(
                  backgroundColor:
                      MaterialStatePropertyAll<Color>(HexColor('#424553')),
                  iconSize: const MaterialStatePropertyAll<double>(30),
                ),
              ),
            ],
          ),
        ],
      ),
    );

Widget inputRow(
  context, {
  required String title,
  required String value,
  double width = 70,
}) =>
    Row(
      crossAxisAlignment: CrossAxisAlignment.baseline,
      textBaseline: TextBaseline.ideographic,
      children: [
        SizedBox(
          // width: width,
          child: Text(
            '$title: ',
            style: Theme.of(context).textTheme.bodyMedium,
          ),
        ),
        Text(
          value,
          style: Theme.of(context).textTheme.bodySmall,
        ),
      ],
    );
