import 'package:flutter/services.dart';

TextInputFormatter searchFormatter = FilteringTextInputFormatter.allow(RegExp("[ء-يa-zA-Z0-9 ]"));

TextInputFormatter nameFormatter = FilteringTextInputFormatter.allow(RegExp("[ء-يa-zA-Z ]"));

TextInputFormatter noSpaceFormatter = FilteringTextInputFormatter.deny(RegExp(r'\s'));

TextInputFormatter digitsFormatter = FilteringTextInputFormatter.digitsOnly;
