import 'package:get/get.dart';
import 'package:toannm_test/routes/app_routes.dart';
import 'package:toannm_test/screens/notification/bindings/notification_bindings.dart';
import 'package:toannm_test/screens/notification/notification_page.dart';

abstract class AppPage {
  const AppPage._();

  static final pages = [
    GetPage(
      name: AppRoutes.notification,
      page: () => NotificationPage(),
      binding: NotificationBindings(),
    ),
  ];
}
