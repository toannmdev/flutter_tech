import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:toannm_test/routes/app_page.dart';
import 'package:toannm_test/routes/app_routes.dart';
import 'package:toannm_test/storages/hive_app.dart';
import 'package:toannm_test/theme/base_theme.dart';

void main() async {
  Get.put(Dio());

  await HiveApp.instance.initHive();

  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      statusBarColor: Colors.white,
      statusBarBrightness: Brightness.light,
      statusBarIconBrightness: Brightness.dark));

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: "ToanNM Test",
      getPages: AppPage.pages,
      theme: ThemeService.instance.getThemeApp(),
      darkTheme: ThemeService.instance.getThemeApp(),
      themeMode: ThemeMode.light,
      initialRoute: AppRoutes.defaultRoute,
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
