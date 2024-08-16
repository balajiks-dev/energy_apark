import 'package:energy_park/modules/home/data/model/task_model.dart';
import 'package:energy_park/modules/home/data/repository/home_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:energy_park/modules/home/presentation/bloc/home_event.dart';
import 'package:energy_park/modules/home/presentation/bloc/home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  HomeBloc() : super(HomeInitial()) {
    on<GetTaskList>(_onGetTaskList);
  }

  Future<void> _onGetTaskList(
    GetTaskList event,
    Emitter<HomeState> emit,
  ) async {
    emit(ShowProgressBar());
    List<TaskModel> tasks = await HomeRepository().getTaskList();
    int completedTaskCount = 0;
    int pendingTaskCount = 0;
    for (var element in tasks) {
      if (element.status != null && element.status == 0) {
        pendingTaskCount++;
      } else {
        completedTaskCount++;
      }
    }
    emit(ShowTaskList(
      taskList: tasks,
      pendingTaskCount: pendingTaskCount,
      completedTaskCount: completedTaskCount,
    ));
  }
}
