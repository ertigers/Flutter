import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:boxApp/nav_router/manager.dart';
import 'package:boxApp/util/jssdk.dart';

class Browser extends StatefulWidget {
  const Browser(
      {Key key, this.url, this.title, this.isLocalUrl = false, this.isFull = false, this.callback})
      : super(key: key);

  final String url;
  final bool isLocalUrl;
  final String title;
  final Function callback;
  final bool isFull;

  @override
  _Browser createState() => _Browser();
}

class _Browser extends State<Browser> with AutomaticKeepAliveClientMixin {
  WebViewController _webViewController;
  bool isLoading = true; // 加载状态
  String title;

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: widget.isFull ? null : _buildAppbar(),
      body: _buildBody()
    );
  }

  Widget _buildAppbar() {
    return AppBar(
      elevation: 0,
      backgroundColor: Colors.transparent,
      title: Text(
        title ?? this.widget.title ?? "",
        style: TextStyle(color: Colors.white, fontSize: 18.0),
      ),
      centerTitle: true,
      leading: IconButton(
        icon: Icon(
          Icons.arrow_back,
          color: Colors.white,
        ),
        onPressed: () async {
          if (await _webViewController.canGoBack()) {
            _webViewController.goBack();
          } else {
            NavigatorManager.pop();
          }
        }
      )
    );
  }

  Widget _buildBody() {
    return Builder(builder: (BuildContext context) {   
      return Stack(
        children: <Widget>[
          WebView(
            initialUrl: widget.isLocalUrl ? Uri.dataFromString(widget.url, mimeType: 'text/html', encoding: Encoding.getByName('utf-8'))
                .toString() : widget.url,
            javascriptMode: JavascriptMode.unrestricted,
            javascriptChannels: <JavascriptChannel>[
              _toasterJavascriptChannel(context),
            ].toSet(),
            onWebViewCreated: (WebViewController controller){
              _webViewController = controller;
              if(widget.isLocalUrl){
                _loadHtmlAssets(controller);
              }else{
                controller.loadUrl(widget.url);
              }
            },
            onPageFinished: (String value){
              _webViewController.evaluateJavascript('document.title').then((result) => {
                setState(() {
                  title = result;
                  isLoading = false; // 页面加载完成，更新状态
                })
              });
            },
            navigationDelegate: (NavigationRequest request) {
              print("即将打开 ${request.url}");
              if(request.url.startsWith("app://")) {  
                print("内部跳转");
                return NavigationDecision.prevent;
              } else if (request.url.startsWith("webview://")) {
                NavigatorManager.push(Browser(url: request.url.replaceFirst("webview://", "https://"), title: "商品详情")); 
                return NavigationDecision.prevent;
              }
              return NavigationDecision.navigate;
            } 
          ),  
          isLoading
          ? Container(
            child: Center(
              child: CircularProgressIndicator(),
            ),
          )
          : Container(),
        ],
      );
    });
  }

  //加载本地文件
  _loadHtmlAssets(WebViewController controller) async {
    String htmlPath = await rootBundle.loadString(widget.url);
    controller.loadUrl(Uri.dataFromString(htmlPath, mimeType: 'text/html', encoding: Encoding.getByName('utf-8')).toString());
  }

  JavascriptChannel _toasterJavascriptChannel(BuildContext context) {
    return JavascriptChannel(
      name: 'FlutterSDK',
      onMessageReceived: (JavascriptMessage message) {
        String jsonStr = message.message;
        JsSDK.executeMethod(context, _webViewController, jsonStr);
      }
    );
  }

  @override
  bool get wantKeepAlive => true;
}
