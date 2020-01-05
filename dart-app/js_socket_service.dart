import 'package:interactive_webview/interactive_webview.dart';

class JSSocketService {
  static InteractiveWebView jsWebview;
  const String jsAppURL = "https://";  // url of the JS application
  JSSocketService.init() {
    _initJSSocketFile();
  }

  _initJSSocketFile() {
    jsWebview = new InteractiveWebView();
    jsWebview.loadUrl(jsAppURL); 
      if (JSSocketBase.jsWebview != null) {
      _initJSWebListeners();
    }
  }

  _initJSWebListeners(){
     JSSocketBase.jsWebview.didReceiveMessage.listen((message) {
      String eventName = message.data["eventName"];
      String eventData = message.data["eventData"];
      switch (eventName) {
        case "new-trade":
          {
            if (eventData == null) {
              return;
            }

            dynamic tradeHistoryData = jsonDecode(eventData);
            TradeEntry tradeHistory = TradeEntry.fromJson(tradeHistoryData);
            TradeHistoryDataStore.addToTradeHistory(tradeHistory);
            break;
          }
        case "depth-update-1":
          {
            if (eventData == null) {
              return;
            }

            dynamic orderBookData = jsonDecode(eventData);
            List<dynamic> a = orderBookData['a'];
            List<dynamic> b = orderBookData['b'];
            a.sublist(0, Constant.MAX_NO_OF_ORDERBOOK_RECORDS);
            b.sublist(0, Constant.MAX_NO_OF_ORDERBOOK_RECORDS);
            Orderbook orderBook = Orderbook(
                a, b, orderBookData['channel'], orderBookData['type']);
            OrderbookDataStore.setOrderbook(orderBook,
                shouldSubscribeToNewChannel: false);
            break;
          }
        case 'update-prices':
          {
            if (eventData == null) {
              return;
            }

            CurrencyDataStore.setCurrentPrices(jsonDecode(eventData));
            break;
          }
        case "update-24-hour":
          {
            CurrencyDataStore.setCurrencyPair24HourChange(
                jsonDecode(eventData));
            break;
          }
        // Private listeners
        case "balance-update":
          {
            if (eventData == null) {
              return;
            }

            List<dynamic> data = jsonDecode(eventData);
            if (data == null && data.length == 0) {
              return;
            }
            List<Wallet> updatedWallets = data
                .map((updatedWallet) => Wallet.fromJson(updatedWallet))
                .toList();
            UserDataStore.updateUserWallets(updatedWallets);
            break;
          }
        case "order-update":
          {
            if (eventData == null) {
              return;
            }

            dynamic data = jsonDecode(eventData);

            dynamic updatedTradeObj = data[0];
            updatedTradeObj =
                Utility.getCompleteTradeOrderObject(updatedTradeObj);
            UserDataStore.updateOpenOrder(TradeOrder.fromJson(updatedTradeObj));
            // NotificationService.addOrderPlacedNotification(updatedTradeObj);
            break;
          }

        case "connect":
          {
            _initializeStreamListeners();
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
}



