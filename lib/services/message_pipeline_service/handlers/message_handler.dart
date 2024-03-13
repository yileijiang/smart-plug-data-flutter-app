import 'package:smart_plug_data/data/database/database.dart';
// TODO: refactor class and structure it
abstract class MessageHandler {
  MessageHandler? next;
  static late RegisteredSmartPlug registeredSmartPlug;
  static late int entryId;

  MessageHandler({this.next});

  void setNext(MessageHandler messageHandler) {
    next = messageHandler;
  }

  void handle(Map<String, dynamic> message);

  static void setRegisteredSmartPlug(RegisteredSmartPlug registeredSmartPlug) {
    MessageHandler.registeredSmartPlug = registeredSmartPlug;
  }

  static void setEntryId(int entryId) {
    MessageHandler.entryId = entryId;
  }
}
