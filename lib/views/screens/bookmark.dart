import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mirror_wall_app/model/bookmark.dart';
import 'package:mirror_wall_app/provider/bookmarkprovider.dart';
import 'package:provider/provider.dart';

class AllBookmark extends StatelessWidget {
  const AllBookmark({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Bookmark"),
      ),
      body: Data.bookMarkURL.length == 0
          ? Container(
              alignment: Alignment.center,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    "No any bookmarks yet...",
                    style: TextStyle(fontSize: 15, color: Colors.grey),
                  )
                ],
              ),
            )
          : Consumer<bookmarkProvider>(
              builder: (BuildContext context, bookmarkProvider value,
                  Widget? child) {
                return ListView.builder(
                  padding: EdgeInsets.only(left: 20, right: 20, top: 20),
                  itemCount: Data.bookMarkURL.length,
                  itemBuilder: (context, index) {
                    return GestureDetector(
                      onTap: () {},
                      child: Container(
                        height: 50,
                        decoration:
                            BoxDecoration(color: Colors.grey.withOpacity(0.1)),
                        margin: EdgeInsets.only(top: 10),
                        child: Row(
                          children: [
                            SizedBox(
                              width: 10,
                            ),
                            SizedBox(
                              width: 280,
                              child: GestureDetector(
                                onTap: () {
                                  Navigator.of(context).pushNamed(
                                      'bookmark_page',
                                      arguments: Data.bookMarkURL[index]);
                                },
                                child: Text(
                                  "${Data.bookMarkURL[index].toString()}",
                                  style: TextStyle(
                                    fontSize: 18,
                                    decoration: TextDecoration.underline,
                                    decorationColor: Colors.blue,
                                    color: Colors.blue,
                                  ),
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                            ),
                            SizedBox(
                              width: 33,
                            ),
                            IconButton(
                              onPressed: () {
                                value.deleteBookMark(index);
                              },
                              icon: Icon(
                                Icons.cancel,
                                color: Colors.grey.shade700,
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                );
              },
            ),
    );
  }
}
