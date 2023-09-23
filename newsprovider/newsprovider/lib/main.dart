import 'package:flutter/material.dart';
import 'package:newsprovider/src/pages/tabs_page.dart';
import 'package:newsprovider/src/services/news_service.dart';
import 'package:newsprovider/src/theme/tema.dart';
import 'package:provider/provider.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => NewsService(),)
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: miTema,
        title: 'Material App',
        home: TabsPage(),
      ),
    );
  }
}