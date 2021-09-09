import 'package:flutter/widgets.dart';
import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart' as path_provider;
import 'package:toannm_test/configs/app_const.dart';

class HiveApp {
  HiveApp._();

  static final HiveApp instance = HiveApp._();

  late Box hive;

  Future<void> initHive() async {
    WidgetsFlutterBinding.ensureInitialized();
    final appDocumentDirectory =
        await path_provider.getApplicationDocumentsDirectory();
    Hive.init(appDocumentDirectory.path);
    hive = await Hive.openBox(AppConst.appName);
  }
}
