import 'package:smart_plug_data/data/database/database.dart';

abstract class MessageHandler {
  MessageHandler? next;

  MessageHandler({this.next});

  void setNext(MessageHandler messageHandler) {
    next = messageHandler;
  }
  void handle(Map<String, dynamic> message, RegisteredSmartPlug? registeredSmartPlug) {

  }
}