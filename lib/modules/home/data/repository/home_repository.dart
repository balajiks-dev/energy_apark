import 'dart:convert';

import 'package:energy_park/modules/home/data/model/task_model.dart';
import 'package:energy_park/utils/pref.dart';


class HomeRepository {
  Future<dynamic> saveTaskList(List<TaskModel> taskList) async {
    List<String> jsonStringList = taskList.map((task) => json.encode(task.toJson())).toList();
    return await Prefs.setTaskList(jsonStringList);
  }

  Future<List<TaskModel>> getTaskList() async {
    List<String>? jsonStringList = await Prefs.getTaskList;
    if (jsonStringList == null) {
      return [];
    }
    return jsonStringList.map((jsonString) => TaskModel.fromJson(json.decode(jsonString))).toList();
  }
}
