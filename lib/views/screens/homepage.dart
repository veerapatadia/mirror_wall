import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:mirror_wall_app/model/bookmark.dart';
import 'package:mirror_wall_app/provider/bookmarkprovider.dart';
import 'package:provider/provider.dart';
import '../../provider/connectivityprovider.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  InAppWebViewController? inAppWebViewController;
  PullToRefreshController? pullToRefreshController;
  TextEditingController searchController = TextEditingController();
  bool isTapped = false;
  bool canGoBack = false;
  bool canGoForward = false;

  @override
  void initState() {
    Provider.of<ConnectivityProvider>(context, listen: false)
        .checkConnectivity();
    super.initState();
  }

  void updateButton() async {
    if (inAppWebViewController != null) {
      bool back = await inAppWebViewController!.canGoBack();
      bool forward = await inAppWebViewController!.canGoForward();
      setState(() {
        canGoBack = back;
        canGoForward = forward;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("My Browser"),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () {
              Provider.of<bookmarkProvider>(context, listen: false)
                  .allBookmark(context);
            },
            icon: Icon(Icons.bookmark_added_rounded),
          ),
          PopupMenuButton(
            onSelected: (val) {
              inAppWebViewController?.loadUrl(
                urlRequest: URLRequest(
                  url: WebUri("$val"),
                ),
              );
            },
            itemBuilder: (context) {
              return <PopupMenuEntry>[
                PopupMenuItem(
                  child: Text("Google"),
                  value: "https://www.google.com",
                ),
                PopupMenuItem(
                  child: Text("Yahoo"),
                  value: "https://www.yahoo.com",
                ),
                PopupMenuItem(
                  child: Text("Bing"),
                  value: "https://www.bing.com",
                ),
                PopupMenuItem(
                  child: Text("DuckDuckGo"),
                  value: "https://www.duckduckgo.com",
                ),
              ];
            },
          ),
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
                      updateButton();
                    },
                    onLoadStop: (controller, url) async {
                      await pullToRefreshController!.endRefreshing();
                      updateButton();
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
                onPressed: canGoBack
                    ? () async {
                        if (inAppWebViewController != null) {
                          if (await inAppWebViewController!.canGoBack()) {
                            await inAppWebViewController!.goBack();
                            updateButton();
                          }
                        }
                      }
                    : null,
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
                onPressed: canGoForward
                    ? () async {
                        if (inAppWebViewController != null) {
                          if (await inAppWebViewController!.canGoForward()) {
                            await inAppWebViewController!.goForward();
                            updateButton();
                          }
                        }
                      }
                    : null,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
