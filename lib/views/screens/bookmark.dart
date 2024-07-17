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
        // actions: [
        //   IconButton(
        //     onPressed: () {
        //       showDialog(
        //         context: context,
        //         builder: (BuildContext context) {
        //           return AlertDialog(
        //             title: const Text('Delete'),
        //             content: const Text(
        //                 'Are you sure you want to delete all Bookmarks?'),
        //             actions: <Widget>[
        //               TextButton(
        //                 child: const Text('Cancel'),
        //                 onPressed: () {
        //                   Navigator.of(context).pop();
        //                 },
        //               ),
        //               TextButton(
        //                 child: const Text('Confirm'),
        //                 onPressed: () {
        //                   Provider.of<bookmarkProvider>(context, listen: false)
        //                       .deleteAll();
        //                   Navigator.of(context).pop();
        //                 },
        //               ),
        //             ],
        //           );
        //         },
        //       );
        //     },
        //     icon: Icon(Icons.delete_forever_rounded),
        //     color: Colors.black.withOpacity(0.5),
        //   )
        // ],
      ),
      body: Data.bookMarkURL.length == 0
          ? Container(
              alignment: Alignment.center,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    "No any bookmarks yet...",
                    style: TextStyle(fontSize: 18, color: Colors.grey),
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
                        height: 60,
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
                                    fontSize: 20,
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
