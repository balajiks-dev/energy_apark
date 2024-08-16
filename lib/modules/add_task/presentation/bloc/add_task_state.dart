import 'package:energy_park/modules/add_task/data/employee_list_model.dart';
import 'package:energy_park/modules/home/data/model/task_model.dart';


abstract class AddTaskState {}

class AddTaskInitial extends AddTaskState {}

class TaskAddedState extends AddTaskState {}

class ShowProgressBar extends AddTaskState {}

class TaskAddedSuccess extends AddTaskState {
  final List<TaskModel> taskList;

  TaskAddedSuccess({required this.taskList});
}

class ShowEmployeeListState extends AddTaskState {
  final List<EmployeeListModel> employeeList;

  ShowEmployeeListState({required this.employeeList});
}

class FailureState extends AddTaskState {
  final String message;

  FailureState({required this.message});
}

class AssignEmployeeState extends AddTaskState {
  final EmployeeListModel employeeListModel;

  AssignEmployeeState({required this.employeeListModel});
}