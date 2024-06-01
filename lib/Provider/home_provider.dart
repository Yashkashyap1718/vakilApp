import 'package:flutter/material.dart';

class HomeProvider extends ChangeNotifier {
  int pageIndex = 0;

  bool isLoading = false;

  updatePageIndex(v) {
    pageIndex = v;
  }

  showLoader() {
    isLoading = true;
    notifyListeners();
  }

  hideLoader() {
    isLoading = false;
    notifyListeners();
  }
}
