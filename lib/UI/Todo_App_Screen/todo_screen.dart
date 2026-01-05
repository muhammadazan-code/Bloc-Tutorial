import 'package:bloc_tutorial/Bloc/Todo/todo_bloc.dart';
import 'package:bloc_tutorial/Bloc/Todo/todo_events.dart';
import 'package:bloc_tutorial/Bloc/Todo/todo_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class TodoAppScreen extends StatefulWidget {
  const TodoAppScreen({super.key});

  @override
  State<TodoAppScreen> createState() => _TodoAppScreenState();
}

class _TodoAppScreenState extends State<TodoAppScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Center(child: Text("T O D O  L I S T"))),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsetsGeometry.all(15),
          child: BlocBuilder<TodoAppBloc, TodoAppState>(
            builder: (context, state) {
              if (state.todoList.isEmpty) {
                return Center(child: Text("No founds"));
              } else if (state.todoList.isNotEmpty) {
                return ListView.builder(
                  itemCount: state.todoList.length,
                  itemBuilder: (context, index) {
                    return ListTile(
                      title: Text(state.todoList[index].toString()),
                      trailing: IconButton(
                        onPressed: () {
                          context.read<TodoAppBloc>().add(
                            RemoveTodoEvents(task: state.todoList[index]),
                          );
                        },
                        icon: Icon(Icons.delete),
                      ),
                    );
                  },
                );
              } else {
                return SizedBox();
              }
            },
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          for (var i = 0; i < 20; i++) {
            context.read<TodoAppBloc>().add(AddTodoEvents(task: "task: $i"));
          }
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
