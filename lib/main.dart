import 'package:flutter/material.dart';
import 'package:mirror_wall_app/provider/bookmarkprovider.dart';
import 'package:mirror_wall_app/provider/connectivityprovider.dart';
import 'package:mirror_wall_app/provider/popupmenuprovider.dart';
import 'package:mirror_wall_app/provider/searchengineprovider.dart';
import 'package:mirror_wall_app/views/screens/bookmark.dart';
import 'package:mirror_wall_app/views/screens/bookmarkpage.dart';
import 'package:mirror_wall_app/views/screens/homepage.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        //  ChangeNotifierProvider(create: (context) => HomeProvider()),
        ChangeNotifierProvider(create: (context) => ConnectivityProvider()),
        ChangeNotifierProvider(create: (context) => PopupMenuProvider()),
        ChangeNotifierProvider(create: (context) => bookmarkProvider()),
        ChangeNotifierProvider(create: (context) => RadioProvider()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        routes: {
          '/': (context) => homepage(),
          'bookmark': (context) => AllBookmark(),
          'bookmark_page': (context) => bookmarkpage(),
        },
      ),
    ),
  );
}
