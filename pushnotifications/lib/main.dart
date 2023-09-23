import 'package:flutter/material.dart';
import 'package:pushnotifications/screens/home_screen.dart';
import 'package:pushnotifications/screens/message_screen.dart';
import 'package:pushnotifications/services/push_notifications_services.dart';

void main() async {

  WidgetsFlutterBinding.ensureInitialized();
  await PushNotificationService.initializeApp();

  runApp(const MyApp());

}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}


class _MyAppState extends State<MyApp> {

  final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();
  final GlobalKey<ScaffoldMessengerState> messengerKey = GlobalKey<ScaffoldMessengerState>();

  @override
  void initState() {
    super.initState();

    // Context
    PushNotificationService.messagesStream.listen((message) {
      print('MyApp: $message');
      navigatorKey.currentState?.pushNamed('Message',arguments: message);

      final snackBar = SnackBar(content: Text(message));
      messengerKey.currentState?.showSnackBar(snackBar);
    });
    
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Material App',
      initialRoute: 'Home',
      navigatorKey: navigatorKey,
      scaffoldMessengerKey: messengerKey,
      routes: {
        'Home'    : ( _ ) => HomeScreen(),
        'Message' : ( _ ) => MessageScreen(),
      },
    );
  }
}