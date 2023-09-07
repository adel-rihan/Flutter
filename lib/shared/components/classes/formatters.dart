import 'package:flutter/services.dart';

TextInputFormatter nameFormatter =
    FilteringTextInputFormatter.allow(RegExp("[ء-يa-zA-Z0-9 ]"));
