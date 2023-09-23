import 'dart:async';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

// SHA1: DF:6B:EF:C5:BD:90:E4:3F:AC:92:5D:FA:33:1C:16:18:09:38:1C:95


class PushNotificationService {

  static FirebaseMessaging messaging = FirebaseMessaging.instance;
  static String? token;
  static final StreamController<String> _messageStream = StreamController.broadcast();
  static Stream<String> get messagesStream => _messageStream.stream;

  static Future _backgroundHandler( RemoteMessage message ) async {
    print(message.data);
    _messageStream.add(message.data['product'] ?? 'No data');
  }
  static Future _onMessageHandler( RemoteMessage message ) async {
    print(message.data);
    _messageStream.add(message.data['product'] ?? 'No data');
  }
  static Future _onMessageOpenApp( RemoteMessage message ) async {
    print(message.data);
    _messageStream.add(message.data['product'] ?? 'No data');
  }

  static Future initializeApp() async {
    // Push Notifications
    await Firebase.initializeApp();
    token = await FirebaseMessaging.instance.getToken();
    print('Token: $token');

    // Handlers
    FirebaseMessaging.onBackgroundMessage( _backgroundHandler );
    FirebaseMessaging.onMessage.listen( _onMessageHandler );
    FirebaseMessaging.onMessageOpenedApp.listen( _onMessageOpenApp );

    // Local Notifications

  }

  static closeStreams(){
    _messageStream.close();
  }

}