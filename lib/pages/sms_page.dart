import 'package:flutter/material.dart';
import 'package:flutter_email_sender/flutter_email_sender.dart';

class SmsPage extends StatelessWidget {
  const SmsPage({
    Key? key,
    required this.sender,
    required this.body,
    this.isSpam = false,
  }) : super(key: key);

  final String sender;
  final String body;
  final bool isSpam;

  Future<void> sendEmail(context, spamMsg, sender) async {
    final Email email = Email(
      subject: 'Reporting a Spam SMS',
      body:
          'Respected Sir/Ma\'am,\n\nThe below message has been received in my device and that has been reported as SMS Spam by Safe Inbox app.\n\n$spamMsg\n\nThe sender is identified as $sender.\n\n Kindly take necessary action regarding this.\n\nThanks!',
      recipients: ['mharsha.315@gmail.com'],
    );
    String response;
    try {
      await FlutterEmailSender.send(email);
      response = "SMS reported to CERT-In";
    } catch (err) {
      response = err.toString();
    }

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(response),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () => Navigator.of(context).pop(),
          icon: const Icon(Icons.arrow_back),
        ),
        title: Text(sender),
      ),
      body: Column(
        children: [
          Container(
            margin: const EdgeInsets.all(10.0),
            padding: const EdgeInsets.all(8.0),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5.0),
                color: Colors.grey[300]),
            child: Text(body),
          ),
          const Divider(height: 50.0),
          if (isSpam)
            ElevatedButton(
              onPressed: () => sendEmail(context, body, sender),
              child: const Text('REPORT TO CERT-IN'),
              style: ButtonStyle(
                  backgroundColor:
                      MaterialStateProperty.all<Color>(Colors.red)),
            )
        ],
      ),
    );
  }
}
