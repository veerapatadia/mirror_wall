import 'package:flutter/material.dart';
import 'package:mirror_wall_app/provider/bookmarkprovider.dart';
import 'package:mirror_wall_app/provider/connectivityprovider.dart';
import 'package:mirror_wall_app/views/screens/bookmark.dart';
import 'package:mirror_wall_app/views/screens/bookmarkpage.dart';
import 'package:mirror_wall_app/views/screens/homepage.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => ConnectivityProvider()),
        ChangeNotifierProvider(create: (context) => bookmarkProvider()),
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
