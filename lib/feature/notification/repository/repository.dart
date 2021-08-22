import 'package:toannm_test/feature/notification/model/response.dart';
import 'package:get/get.dart';
import 'package:flutter/services.dart' show rootBundle;

class NotificationRepository {
  Future<NotificationResponse> getNotifications() async {
    await 0.25.seconds.delay();
    String notiJson = await _loadNotificationJson();
    return NotificationResponse.fromRawJson(notiJson);
  }

  Future<String> _loadNotificationJson() async {
    return await rootBundle.loadString('assets/json/noti.json');
  }
}
