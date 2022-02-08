import 'package:intl/intl.dart';

void printWrapped(String text) {
  final pattern = RegExp('.{1,800}'); // 800 is the size of each chunk
  pattern.allMatches(text).forEach((match) => print(match.group(0)));
}

String formatAmount(String? amount) {
  return NumberFormat("#,##0.0", "en_US").format(double.parse(amount ?? "0.0"));
}
