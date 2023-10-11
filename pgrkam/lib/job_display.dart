import 'package:flutter/material.dart';

class JobDisplay extends ChangeNotifier {
  List<String> jobTitle=[];

  void addJobTitle(String title) {
    jobTitle.add(title);
    notifyListeners();
  }

  void clearJobTitles() {
    jobTitle.clear();
    notifyListeners();
  }
}