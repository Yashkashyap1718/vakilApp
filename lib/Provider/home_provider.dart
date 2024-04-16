import 'package:flutter/material.dart';

class HomeProvider extends ChangeNotifier {
  int pageIndex = 0;

  updatePageIndex(v) {
    pageIndex = v;
  }
}
