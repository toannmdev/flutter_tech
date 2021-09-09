import 'package:get/get.dart';
import 'package:toannm_test/screens/notification/controllers/controller.dart';

class NotificationBindings implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<NotificationController>(
      () => NotificationController(),
    );
  }
}
