import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import './pages/tabs_page.dart';
import './providers/sms_provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<SmsProvider>(
      create: (context) => SmsProvider(),
      child: MaterialApp(
        title: 'Safe Inbox',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: const TabsPage(),
      ),
    );
  }
}
