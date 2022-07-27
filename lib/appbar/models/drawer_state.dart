import 'package:flutter/material.dart';

class DrawerState extends ChangeNotifier {
  bool _isOpen = false;

  bool get isOpen => _isOpen;

  void close() {
    if (_isOpen) {
      _isOpen = false;
      notifyListeners();
    }
  }

  void open() {
    if (!_isOpen) {
      _isOpen = true;
      notifyListeners();
    }
  }

  void toggle() {
    _isOpen = !_isOpen;
    notifyListeners();
  }
}
