import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:energy_park/modules/task_filter/bloc/task_filter_event.dart';
import 'package:energy_park/modules/task_filter/bloc/task_filter_state.dart';

class TaskFilterBloc extends Bloc<TaskFilterEvent, TaskFilterState> {
  TaskFilterBloc() : super(TaskFilterInitial()) {
    on<SelectTaskStatus>(_onSelectTaskStatus);
  }

  Future<void> _onSelectTaskStatus(
      SelectTaskStatus event,
      Emitter<TaskFilterState> emit,
      ) async {
     emit(UpdateTaskStatus(status: event.status));
  }
}
