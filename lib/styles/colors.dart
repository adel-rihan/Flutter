import 'package:flutter/material.dart';

Color bgColor(BuildContext context) => Theme.of(context).colorScheme.background;

Color textFGColor(BuildContext context) => Theme.of(context).colorScheme.onPrimary;

Color textFGColor2(BuildContext context) => Theme.of(context).colorScheme.onPrimary.withOpacity(0.8);

Color textFGColorPrimary(BuildContext context) => Theme.of(context).colorScheme.primary;

Color textFGColorPrimary2(BuildContext context) => Theme.of(context).colorScheme.primary.withOpacity(0.8);

Color selectedColor(BuildContext context) => Theme.of(context).colorScheme.primary;

Color unSelectedColor(BuildContext context) => Theme.of(context).colorScheme.primary.withAlpha(110);
