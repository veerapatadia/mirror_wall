import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:mirror_wall_app/model/bookmark.dart';
import 'package:provider/provider.dart';

import '../../provider/connectivityprovider.dart';
import '../../provider/popupmenuprovider.dart';

class homepage extends StatefulWidget {
  const homepage({super.key});

  @override
  State<homepage> createState() => _homepageState();
}

class _homepageState extends State<homepage> {
  InAppWebViewController? inAppWebViewController;
  PullToRefreshController? pullToRefreshController;
  TextEditingController searchController = TextEditingController();
  bool isTapped = false;

  @override
  void initState() {
    Provider.of<ConnectivityProvider>(context, listen: false)
        .checkConnectivity();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("My Browser"),
        centerTitle: true,
        actions: [
          PopupMenuButton(
            onSelected: (value) {
              Provider.of<PopupMenuProvider>(context, listen: false)
                  .allBookmark(context, value);
            },
            itemBuilder: (context) {
              return [
                PopupMenuItem(
                  value: 1,
                  child: Row(
                    children: [
                      Icon(Icons.bookmark),
                      SizedBox(
                        width: 10,
                      ),
                      Text("All `Bookmarks")
                    ],
                  ),
                ),
                PopupMenuItem(
                  value: 2,
                  child: Row(
                    children: [
                      Icon(Icons.screen_search_desktop_outlined),
                      SizedBox(
                        width: 10,
                      ),
                      Text("Search Engine")
                    ],
                  ),
                ),
              ];
            },
          )
        ],
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: searchController,
              decoration: InputDecoration(
                hintText: 'Search or type web address',
                prefixIcon: Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8.0),
                ),
              ),
              onSubmitted: (value) {
                if (inAppWebViewController != null) {
                  inAppWebViewController!.loadUrl(
                    urlRequest: URLRequest(
                        url: WebUri('https://www.google.com/search?q=$value')),
                  );
                }
              },
            ),
          ),
          Expanded(
            child: Consumer<ConnectivityProvider>(
              builder: (context, connectivityProvider, _) {
                if (connectivityProvider.isInternet) {
                  return InAppWebView(
                    pullToRefreshController: pullToRefreshController,
                    initialUrlRequest: URLRequest(
                      url: WebUri("https://www.google.com"),
                    ),
                    onLoadStart: (controller, url) {
                      inAppWebViewController = controller;
                    },
                    onLoadStop: (controller, url) async {
                      await pullToRefreshController!.endRefreshing();
                    },
                  );
                } else {
                  return Center(
                    child: Text("No Internet"),
                  );
                }
              },
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              IconButton(
                icon: Icon(Icons.home),
                onPressed: () {
                  if (inAppWebViewController != null) {
                    inAppWebViewController!.loadUrl(
                      urlRequest: URLRequest(
                        url: WebUri("https://www.google.com"),
                      ),
                    );
                  }
                },
              ),
              IconButton(
                icon: (isTapped)
                    ? Icon(Icons.bookmark_add)
                    : Icon(Icons.bookmark_add_outlined),
                onPressed: () async {
                  setState(() {
                    isTapped = !isTapped;
                  });
                  WebUri? txt = await inAppWebViewController!.getUrl();
                  Data.bookURL.add(txt.toString());
                  Data.covertUniqueData();
                  print(Data.bookURL.length.toString());
                },
              ),
              IconButton(
                icon: Icon(Icons.arrow_back),
                onPressed: () async {
                  if (inAppWebViewController != null) {
                    if (await inAppWebViewController!.canGoBack()) {
                      await inAppWebViewController!.goBack();
                    }
                  }
                },
              ),
              IconButton(
                icon: Icon(Icons.refresh),
                onPressed: () async {
                  if (inAppWebViewController != null) {
                    await inAppWebViewController!.reload();
                  }
                },
              ),
              IconButton(
                icon: Icon(Icons.arrow_forward),
                onPressed: () async {
                  if (inAppWebViewController != null) {
                    if (await inAppWebViewController!.canGoForward()) {
                      await inAppWebViewController!.goForward();
                    }
                  }
                },
              ),
            ],
          ),
        ],
      ),
    );
  }
}
