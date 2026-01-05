import 'package:bloc_tutorial/Bloc/Todo/todo_events.dart';
import 'package:bloc_tutorial/Bloc/Todo/todo_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class TodoAppBloc extends Bloc<TodoAppEvents, TodoAppState> {
  final List<String> listOfTask = [];
  TodoAppBloc() : super(const TodoAppState()) {
    on<AddTodoEvents>(_addTodoTask);
    on<RemoveTodoEvents>(_removeTodoTask);
  }

  void _addTodoTask(AddTodoEvents event, Emitter<TodoAppState> emit) {
    listOfTask.add(event.task);
    emit(state.copyWith(input: List.from(listOfTask)));
  }

  void _removeTodoTask(RemoveTodoEvents event, Emitter<TodoAppState> emit) {
    listOfTask.remove(event.task);
    emit(state.copyWith(input: List.from(listOfTask)));
  }
}
