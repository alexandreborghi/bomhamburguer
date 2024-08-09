import 'package:flutter/material.dart';
import 'sandwich.dart';
import 'extra.dart';

class Cart with ChangeNotifier {
  Sandwich? _sandwich;
  Extra? _fries;
  Extra? _softDrink;

  Sandwich? get sandwich => _sandwich;
  Extra? get fries => _fries;
  Extra? get softDrink => _softDrink;

  double get total {
    double subtotal = 0.0;

    if (_sandwich != null) subtotal += _sandwich!.price;
    if (_fries != null) subtotal += _fries!.price;
    if (_softDrink != null) subtotal += _softDrink!.price;

    // Apply discounts
    if (_sandwich != null && _fries != null && _softDrink != null) {
      return subtotal * 0.8;
    } else if (_sandwich != null && _softDrink != null) {
      return subtotal * 0.85;
    } else if (_sandwich != null && _fries != null) {
      return subtotal * 0.9;
    }

    return subtotal;
  }

  void addSandwich(Sandwich sandwich) {
    if (_sandwich == null) {
      _sandwich = sandwich;
      notifyListeners();
    } else {
      throw Exception("You can only add one sandwich to the cart.");
    }
  }

  void addFries(Extra fries) {
    if (_fries == null) {
      _fries = fries;
      notifyListeners();
    } else {
      throw Exception("You can only add one fries to the cart.");
    }
  }

  void addSoftDrink(Extra softDrink) {
    if (_softDrink == null) {
      _softDrink = softDrink;
      notifyListeners();
    } else {
      throw Exception("You can only add one soft drink to the cart.");
    }
  }

  void clearCart() {
    _sandwich = null;
    _fries = null;
    _softDrink = null;
    notifyListeners();
  }
}
