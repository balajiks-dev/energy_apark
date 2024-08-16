import 'package:energy_park/constants/app_constants.dart';
import 'package:energy_park/utils/preference_helper.dart';

class Prefs {
  static Future<List<String>> get getTaskList =>
      PreferencesHelper.getStringList(AppConstants.taskList);

  static Future setTaskList(List<String> value) =>
      PreferencesHelper.setStringList(AppConstants.taskList, value);

  static Future<void> clear() =>
      PreferencesHelper.clearPreference();
}
