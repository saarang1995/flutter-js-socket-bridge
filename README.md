## Welcome to Flutter JS Socket Bridge

### Problem statement
There are many web socket plugins available for flutter which connect to the socket server built using socket.io. Most of them work for Android, however, there is a lot of inconsistency when connecting to the socket on iOS.

I have used **'adhara_socket_io, flutter_socket_io, socket_io_client'** etc. All of them are great, but as we know flutter is in its development phase, all these plugins are being updated by their developers quite often, which leads to many problems like connection drop for Android and in many cases for iOS no connection at all.


### Solution statement
I finally figured out a way to resolve this using Javascript until the Flutter team provides a reliable plugin for both the platform.

The solution is very simple, completely reliable and elegant. 

I have used a web view that has no UI screen to communicate with sockets in Javascript program. This has moved Web socket code from the Flutter to Javascript Middleware application which is highly performant and consistent in connection.

### Creating a Javascript Middleware Application

Clone the template js application from this repository.
Open **js-app/index.html** file and add the necessary connection information of your socket server (Requirements are mentioned in the comments of the file).
Now host this application on your server or deploy on Netlify. Refer below official document for deploying on Netlify: ![Deploy-on-Netlify](https://www.netlify.com/blog/2016/09/29/a-step-by-step-guide-deploying-on-netlify/).


![websocket-flutter](https://saarangtiwari.com/assets/blogs/how-i-used-javascript-to-bridge-and-connect-to-websockets-in-flutter/images/websocket-flutter.png)


### Creating a Flutter Application to receive socket data

Let’s create a new flutter project and add interactive_webview package in pubspec.yaml.
Create a new socket service file **js_socket_service.dart**.

Add boiler plate code from **dart-app/js_socket_service.dart** from the repository in your **js_socket_service.dart** file (Requirements are mentioned in comments of the file).
Run the application and use it just like your usual socket application.
