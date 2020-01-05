import 'package:interactive_webview/interactive_webview.dart';

class JSSocketService {
  static InteractiveWebView jsWebview;
  final String jsAppURL = "https://"; // url of the JS application

  JSSocketService() {
    _initJSSocketFile();
  }

  _initJSSocketFile() {
    jsWebview = new InteractiveWebView();
    jsWebview.loadUrl(jsAppURL);
    _initJSWebListeners();
  }

  _initJSWebListeners() {
    // Listener to receive data from Javascript to Flutter
    JSSocketService.jsWebview.didReceiveMessage.listen((message) {
      String eventName = message.data["eventName"]; // event name from server
      String eventData = message.data["eventData"]; // event data from server

      switch (eventName) {
        case "event_name_from_server":
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

  _leaveChannel(String channelName) {
    callJavaScript("leaveChannel", channelName);
  }

  // Method to send data from Flutter to Javascript
  void callJavaScript(String eventName, String path) {
    String script =
        "javascript:document.dispatchEvent(new CustomEvent('dcxAndroidListener', {detail: {eventName: '$eventName',eventData: '$path'}}));";
    JSSocketService.jsWebview.evalJavascript(script);
  }
}
