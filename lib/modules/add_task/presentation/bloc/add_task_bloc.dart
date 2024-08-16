import 'dart:convert';

import 'package:energy_park/modules/add_task/data/employee_list_model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:energy_park/modules/add_task/presentation/bloc/add_task_event.dart';
import 'package:energy_park/modules/add_task/presentation/bloc/add_task_state.dart';
import 'package:energy_park/modules/home/data/model/task_model.dart';
import 'package:energy_park/modules/home/data/repository/home_repository.dart';
import 'package:flutter/services.dart' show rootBundle;


class AddTaskBloc extends Bloc<AddTaskEvent, AddTaskState> {
  AddTaskBloc() : super(AddTaskInitial()) {
    on<AddTaskTapped>(_onAddTaskTappedEvent);
    on<GetEmployeeList>(_onGetEmployeeList);
    on<AssignEmployeeEvent>(_onAssignEmployeeEvent);
  }

  Future<void> _onAddTaskTappedEvent(
    AddTaskTapped event,
    Emitter<AddTaskState> emit,
  ) async {
    if (event.taskModel.title != null &&
        event.taskModel.title!.isNotEmpty &&
        event.taskModel.description != null &&
        event.taskModel.description!.isNotEmpty &&
        event.taskModel.date != null && event.taskModel.employee != null) {
      List<TaskModel> tasks = await HomeRepository().getTaskList();
      tasks.add(event.taskModel);
      bool isSaved = await HomeRepository().saveTaskList(tasks);
      if (isSaved) {
        emit(TaskAddedSuccess(taskList: tasks));
      }
    } else {
      String error = "Please check the validation of the fields";
      emit(FailureState(message: error));
    }
  }

  Future<void> _onGetEmployeeList(
      GetEmployeeList event,
      Emitter<AddTaskState> emit,
      ) async {
    emit(ShowProgressBar());
    final String response = await rootBundle.loadString('assets/employee_list.json');
    final List<dynamic> data = jsonDecode(response);
    List<EmployeeListModel> employeeList = data.map((json) => EmployeeListModel.fromJson(json)).toList();
    emit(ShowEmployeeListState(employeeList: employeeList));
  }

  Future<void> _onAssignEmployeeEvent(
      AssignEmployeeEvent event,
      Emitter<AddTaskState> emit,
      ) async {
    emit(AssignEmployeeState(employeeListModel :event.employeeListModel));
  }
}
