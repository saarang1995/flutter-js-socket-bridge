import 'package:interactive_webview/interactive_webview.dart';

class JSSocketService {
  static InteractiveWebView jsWebview;
  final String jsAppURL = "https://"; // url of the JS application
  JSSocketService.init() {
    _initJSSocketFile();
  }

  _initJSSocketFile() {
    jsWebview = new InteractiveWebView();
    jsWebview.loadUrl(jsAppURL);
    if (JSSocketService.jsWebview != null) {
      _initJSWebListeners();
    }
  }

  _initJSWebListeners() {
    JSSocketService.jsWebview.didReceiveMessage.listen((message) {
      String eventName = message.data["eventName"];
      String eventData = message.data["eventData"];
      switch (eventName) {
        case "new-trade":
          {
            if (eventData == null) {
              return;
            }

            // do something
            break;
          }

        case "connect":
          {
            print('[socket] -> connect');
            break;
          }
        case "disconnect":
          {
            print('[socket] -> disconnect');
            break;
          }
        case "reconnect_attempt":
          {
            print('[socket] -> reconnect_attempt');
            break;
          }
        case "reconnect":
          {
            print('[socket] -> reconnect');
            break;
          }
      }
    });
  }
}
