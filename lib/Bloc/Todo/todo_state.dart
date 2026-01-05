import 'package:equatable/equatable.dart';

class TodoAppState extends Equatable {
  final List<String> todoList;
  const TodoAppState({this.todoList = const []});

  @override
  List<Object?> get props => [todoList];

  TodoAppState copyWith({List<String>? input}) {
    return TodoAppState(todoList: input ?? todoList);
  }
}
