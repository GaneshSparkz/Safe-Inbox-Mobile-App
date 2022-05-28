import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sms/sms.dart';

import './sms_page.dart';
import '../providers/sms_provider.dart';

class SafePage extends StatelessWidget {
  const SafePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final smsData = Provider.of<SmsProvider>(context);
    final safeSms = smsData.safeSms;
    return safeSms.isEmpty
        ? const Center(child: CircularProgressIndicator())
        : ListView.separated(
            separatorBuilder: (context, index) => const Divider(
              color: Colors.black,
            ),
            itemCount: safeSms.length,
            itemBuilder: (context, index) {
              return GestureDetector(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ListTile(
                    leading:
                        const Icon(Icons.markunread, color: Colors.green),
                    title: Text(safeSms[index].address),
                    subtitle: Text(
                      safeSms[index].body,
                      maxLines: 2,
                    ),
                  ),
                ),
                onTap: () => Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (ctx) => SmsPage(
                      sender: safeSms[index].address,
                      body: safeSms[index].body,
                    ),
                  ),
                ),
              );
            },
          );
  }
}
