import 'package:fastic_demo/model/alarm_manager.dart';
import 'package:fastic_demo/model/app_prefs.dart';
import 'package:fastic_demo/model/health_data_source.dart';
import 'package:get_it/get_it.dart';

class DiModule {
  static Future<void> setup() async {
    final getIt = GetIt.instance;

    final appPrefs = AppPrefs();
    await appPrefs.init();

    getIt
      ..registerLazySingleton(() => appPrefs)
      ..registerLazySingleton(() => HealthKit())
      ..registerLazySingleton(() => AlarmManager())
    ;
  }
}
