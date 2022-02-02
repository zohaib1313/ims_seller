import 'package:flutter/cupertino.dart';

class TestViewModel extends ChangeNotifier {
  String? _name;

  String? get name => _name;

  set name(String? value) {
    _name = value;
    notifyListeners();
  }
}
