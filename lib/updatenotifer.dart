import 'dart:collection';

import 'package:Signin/models/housemodel.dart';
import 'package:flutter/cupertino.dart';

class Notifier with ChangeNotifier {
  List<Housemodel> _houselist = [];
  Housemodel _currentHouse;

  UnmodifiableListView<Housemodel> get houselist =>
      UnmodifiableListView(_houselist);

  Housemodel get currenthouse => _currentHouse;

  set houselist(List<Housemodel> houselist) {
    _houselist = houselist;
    notifyListeners();
  }
  set currenthouse(Housemodel currenthouse) {
    _currentHouse = currenthouse;
    notifyListeners();
  }
}
