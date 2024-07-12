import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mirror_wall_app/provider/searchengineprovider.dart';
import 'package:provider/provider.dart';

class PopupMenuProvider extends ChangeNotifier {
  void allBookmark(BuildContext context, int index) {
    if (index == 1) {
      Navigator.pushNamed(context, 'bookmark');
    } else if (index == 2) {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text('Search Engine'),
            content: Consumer<RadioProvider>(
                builder: (BuildContext context, RadioProvider value, _) {
              return Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  RadioListTile<String>(
                    title: Text('Google'),
                    value: value.strGoogle,
                    groupValue: value.selectedRadio,
                    onChanged: (val) {
                      value.handleRadioValueChange(val!, context);
                    },
                  ),
                  RadioListTile<String>(
                    title: Text('Yahoo'),
                    value: value.strYahoo,
                    groupValue: value.selectedRadio,
                    onChanged: (val) {
                      value.handleRadioValueChange(val!, context);
                    },
                  ),
                  RadioListTile<String>(
                    title: Text('Bing'),
                    value: value.strBing,
                    groupValue: value.selectedRadio,
                    onChanged: (val) {
                      value.handleRadioValueChange(val!, context);
                    },
                  ),
                  RadioListTile<String>(
                    title: Text('Duck Duck Go'),
                    value: value.strDuckDuckGo,
                    groupValue: value.selectedRadio,
                    onChanged: (val) {
                      value.handleRadioValueChange(val!, context);
                    },
                  )
                ],
              );
            }),
          );
        },
      );
    }
    notifyListeners();
  }
}
