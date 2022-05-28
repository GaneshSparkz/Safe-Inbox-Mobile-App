import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:sms/sms.dart';
import 'package:http/http.dart' as http;

class SmsProvider with ChangeNotifier {
  final List<SmsMessage> _safeSms = [];
  final List<SmsMessage> _spamSms = [];
  final SmsQuery _query = SmsQuery();

  List<SmsMessage> get safeSms {
    return [..._safeSms];
  }

  List<SmsMessage> get spamSms {
    return [..._spamSms];
  }

  fetchSms() async {
    final sms = await _query.getAllSms;
    final url = Uri.parse('https://safe-inbox.herokuapp.com/predict');
    
    final body = {
      'messages': sms
          .map(
              (message) => {'sender': message.address, 'message': message.body})
          .toList()
    };
    
    try {
      final response = await http.post(
        url,
        headers: {'content-type': 'application/json'},
        body: json.encode(body),
      );
      
      assert (response.statusCode == 200);
      final messages = json.decode(response.body)['messages'] as List<dynamic>;
      
      messages.forEach((message) {
        if (message['is_spam']) {
          _spamSms.add(SmsMessage(message['sender'], message['message']));
        } else {
          _safeSms.add(SmsMessage(message['sender'], message['message']));
        }
      });
    } catch (error) {
      print(error);
    }

    notifyListeners();
  }
}
