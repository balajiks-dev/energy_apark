import 'package:energy_park/modules/add_task/data/employee_list_model.dart';
import 'package:energy_park/modules/home/data/model/task_model.dart';

abstract class AddTaskEvent {}

class AddTaskTapped extends AddTaskEvent{
  final TaskModel taskModel;

  AddTaskTapped({required this.taskModel});
}

class GetEmployeeList extends AddTaskEvent {
}

class AssignEmployeeEvent extends AddTaskEvent {
  final EmployeeListModel employeeListModel;

  AssignEmployeeEvent({required this.employeeListModel});
}