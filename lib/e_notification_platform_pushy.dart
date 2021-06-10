library e_notification_platform_pushy;

import 'dart:async';

import 'package:e_notification_platform_interface/e_notification_platform_interface.dart';
import 'package:pushy_flutter/pushy_flutter.dart';

NotificationCallback backgroundNotificationListener(
    StreamSink backgroundNotificationStream, StreamSink notificationStream) {
  return (Map<String, dynamic> data) {
    // Print notification payload data
    print('Received notification: $data');

    // Notification title
    String notificationTitle = 'MyApp';

    // Attempt to extract the "message" property from the payload: {"message":"Hello World!"}
    String notificationText = data['message'] ?? 'Hello World!';

    // Android: Displays a system notification
    // iOS: Displays an alert dialog
    Pushy.notify(notificationTitle, notificationText, data);

    ENotificationMessage message = ENotificationMessage.fromJson(data);

    backgroundNotificationStream.add(message);

    notificationStream.add(message);

    // Clear iOS app badge number
    Pushy.clearBadge();
  };
}

class ENotificationPlatformPushy extends ENotificationPlatformInterface {
  StreamController<ENotificationMessage>
      _backgroundNotificationMessageController = StreamController();

  StreamController<ENotificationMessage> _notificationMessageController =
      StreamController();

  @override
  late Stream<ENotificationMessage> backgroundNotificationMessageStream;

  @override
  late Stream<ENotificationMessage> notificationMessageStream;

  late String _deviceId;

  @override
  Future<void> init(Map<String, dynamic> params) async {
    backgroundNotificationMessageStream =
        _backgroundNotificationMessageController.stream;
    notificationMessageStream = _notificationMessageController.stream;

    Pushy.listen();

    _deviceId = await Pushy.register();

    Pushy.setNotificationListener(backgroundNotificationListener(
        _backgroundNotificationMessageController.sink,
        _notificationMessageController.sink));

    Pushy.setNotificationClickListener((data) {
      print("click $data");
    });
  }

  @override
  Future<String> getDeviceId() {
    return Future.value(_deviceId);
  }

  @override
  Future<void> subscribe(String topic) async {
    await Pushy.subscribe(topic);
  }

  @override
  Future<void> unsubscribe(String topic) {
    throw UnimplementedError();
  }

  @override
  Future<List<String>> getTags() {
    throw UnimplementedError();
  }

  @override
  Future<String> setTag(String tag) {
    throw UnimplementedError();
  }

  @override
  Future<void> close() async {
    this._notificationMessageController.close();
    this._backgroundNotificationMessageController.close();
  }
}
