import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'model/message.dart';

class MessageHandler extends StatefulWidget {
  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging();

  @override
  State<StatefulWidget> createState() => _MessageHandlerState();

  void fcmSubscribe(String topic) {
    _firebaseMessaging.subscribeToTopic(topic);
  }

  void fcmUnSubscribe(String topic) {
    _firebaseMessaging.unsubscribeFromTopic(topic);
  }
}

class _MessageHandlerState extends State<MessageHandler> {
  FirebaseMessaging _firebaseMessaging = FirebaseMessaging();
  final List<Message> messages = [];

  @override
  void initState() {
    super.initState();

    _firebaseMessaging.configure(
      onMessage: (Map<String, dynamic> message) async {
        print("onMessage: $message");
        final notification = message['notification'];
        setState(() {
          messages.add(Message(
              title: notification['title'], body: notification['body']));
        });
      },
      onLaunch: (Map<String, dynamic> message) async {
        print("onLaunch: $message");

        final notification = message['data'];
        setState(() {
          messages.add(Message(
            title: '${notification['title']}',
            body: '${notification['body']}',
          ));
        });
      },
      onResume: (Map<String, dynamic> message) async {
        print("onResume: $message");
      },
    );
    _firebaseMessaging.requestNotificationPermissions(
        const IosNotificationSettings(sound: true, badge: true, alert: true));
  }

  void fcmSubscribe(String topic) {
    _firebaseMessaging.subscribeToTopic(topic);
  }

  void fcmUnSubscribe(String topic) {
    _firebaseMessaging.unsubscribeFromTopic(topic);
  }

  @override
  Widget build(BuildContext context) {
    return null;
  }
}
