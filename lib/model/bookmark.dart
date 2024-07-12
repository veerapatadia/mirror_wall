import 'package:flutter/material.dart';

class Data {
  static Set<String> bookURL = {};
  static List<String> bookMarkURL = [];

  static void covertUniqueData() {
    bookMarkURL = bookURL.toList();
  }
}
