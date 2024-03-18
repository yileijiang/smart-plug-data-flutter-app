import 'dart:convert';
import 'dart:core';
import 'dart:io';
import 'dart:isolate';
import 'package:get_it/get_it.dart';
import 'package:smart_plug_data/data/repositories/registered_smart_plugs_repository.dart';
import 'package:smart_plug_data/data/repositories/settings_repository.dart';
import 'package:smart_plug_data/services/foreground_task_service.dart';
import 'package:smart_plug_data/services/message_pipeline_service/handlers/message_handler.dart';
import 'package:smart_plug_data/services/message_pipeline_service/message_pipeline_manager.dart';
import 'package:smart_plug_data/utils/constants.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

class HomeAssistantWebSocketAPIService {
  final settingsRepository = GetIt.instance<SettingsRepository>();
  final registeredSmartPlugsRepository =
      GetIt.instance<RegisteredSmartPlugsRepository>();
  late SendPort _sendPort;

  late final WebSocketChannel channel;

  void setSendPort(SendPort sendPort) {
    _sendPort = sendPort;
  }

  Future<void> establishAPIConnection() async {
    try {
      var homeAssistantAddress =
          await settingsRepository.getHomeAssistantAddress();

      channel = WebSocketChannel.connect(
        Uri.parse(Constants.webSocketAPIAddress(homeAssistantAddress)),
      );

      await channel.ready;
    } on ArgumentError catch (e) {
      _sendPort.send({'connection_error': 'Error: ${e.message.toString()}'});
      await closeForegroundTask();
    } on SocketException catch (e) {
      _sendPort.send({'connection_error': 'Error: ${e.message}'});
      await closeForegroundTask();
    } catch (e) {
      _sendPort
          .send({'connection_error': 'Error connecting to Home Assistant API'});
      await closeForegroundTask();
    }
  }

  Future<void> listenToChannelMessages() async {
    channel.stream.listen((message) async {
      Map<String, dynamic> messageMap = jsonDecode(message);
      _checkAuthenticationValid(messageMap);
      _processMessage(messageMap);
    });
  }

  Future<void> authenticateWithAccessToken() async {
    var accessToken = await settingsRepository.getAccessToken();

    String authMessage = Constants.webSocketAuthenticationMessage(accessToken);
    channel.sink.add(authMessage);
  }

  void subscribeToEvents() {
    channel.sink.add(Constants.eventsSubscriptionMessage);
  }

  closeForegroundTask() async {
    await settingsRepository.saveConnectionStatus(false);
    GetIt.instance<ForegroundTaskService>().stopForegroundTask();
    _sendPort.send({'connection_closed': 'Connection closed'});
  }

  Future<void> _checkAuthenticationValid(Map<String, dynamic> message) async {
    String authenticationString = message['type'];
    if (authenticationString == 'auth_invalid') {
      _sendPort.send({'auth_error': 'Error: invalid access token'});
      await closeForegroundTask();
    } else if (authenticationString == 'auth_ok') {
      _sendPort.send({'auth_ok': 'Connected to Home Assistant API'});
      await settingsRepository.saveConnectionStatus(true);
    }
  }

  Future<void> _processMessage(Map<String, dynamic> message) async {
    MessageHandler messageHandler =
        GetIt.instance<MessagePipelineManager>().setUpPipeline();
    messageHandler.handle(message);
  }
}
