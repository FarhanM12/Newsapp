import 'package:flutter/material.dart';

class NewsProvider extends ChangeNotifier {
  List _savedArticles = [];

  List get savedArticles => _savedArticles;

  void addArticle(article) {
    _savedArticles.add(article);
    notifyListeners();
  }

  void removeArticle(article) {
    _savedArticles.remove(article);
    notifyListeners();
  }
}
