import 'package:equatable/equatable.dart';

abstract class TodoAppEvents extends Equatable {
  const TodoAppEvents();
}

class AddTodoEvents extends TodoAppEvents {
  final String task;
  const AddTodoEvents({required this.task});
  @override
  List<Object?> get props => [task];
}

class RemoveTodoEvents extends TodoAppEvents {
  final Object task;
  const RemoveTodoEvents({required this.task});
  @override
  List<Object?> get props => [task];
}
