import 'package:flutter/cupertino.dart';

import '../model/bookmark.dart';

class bookmarkProvider extends ChangeNotifier {
  void deleteAll() {
    Data.bookURL.clear();
    Data.bookMarkURL.clear();
    notifyListeners();
  }

  void deleteBookMark(int index) {
    Data.bookURL.remove(Data.bookMarkURL[index]);
    Data.bookMarkURL.removeAt(index);
    notifyListeners();
  }
}
