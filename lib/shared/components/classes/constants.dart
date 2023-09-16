import 'package:intl/intl.dart';

void printFullText(String text) {
  final pattern = RegExp('.{1,800}'); // 800 is the size of each chunk
  pattern.allMatches(text).forEach((match) => print(match.group(0)));
}

String decimalFormatZeros(double n) {
  NumberFormat formatter = NumberFormat();
  formatter.minimumFractionDigits = 0;
  formatter.maximumFractionDigits = 2;
  return formatter.format(n);
}
