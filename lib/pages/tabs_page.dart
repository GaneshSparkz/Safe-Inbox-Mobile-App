import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import './safe_page.dart';
import './spam_page.dart';
import '../providers/sms_provider.dart';

class TabsPage extends StatefulWidget {
  const TabsPage({Key? key}) : super(key: key);

  @override
  State<TabsPage> createState() => _TabsPageState();
}

class _TabsPageState extends State<TabsPage> {
  @override
  Widget build(BuildContext context) {
    Provider.of<SmsProvider>(context, listen: false).fetchSms();
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Safe Inbox'),
          bottom: const TabBar(tabs: <Widget>[
            Tab(
              icon: Icon(
                Icons.security,
              ),
              text: 'Safe',
            ),
            Tab(
              icon: Icon(
                Icons.dangerous_outlined,
              ),
              text: 'Spam',
            ),
          ]),
        ),
        body: const TabBarView(children: <Widget>[
          SafePage(),
          SpamPage(),
        ]),
      ),
    );
  }
}
