import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:toannm_test/feature/base/base_theme.dart';
import 'package:toannm_test/feature/user/user_page.dart';

void main() {
  Get.put(Dio());

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final route = [GetPage(name: '/', page: () => UserPage())];
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: "LINAGORA > ToanNM",
      getPages: route,
      themeMode: themeService.theme,
      theme: ThemeData.light(),
      darkTheme: ThemeData.dark(),
      initialRoute: '/',
      builder: (context, child) {
        return ScrollConfiguration(
          behavior: MyBehavior(),
          child: child!,
        );
      },
    );
  }
}

class MyBehavior extends ScrollBehavior {
  @override
  Widget buildViewportChrome(
      BuildContext context, Widget child, AxisDirection axisDirection) {
    return child;
  }
}
