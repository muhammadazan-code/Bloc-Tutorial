import 'package:bloc_tutorial/Bloc/Counter/counter_bloc.dart';
import 'package:bloc_tutorial/Bloc/Counter/counter_events.dart';
import 'package:bloc_tutorial/Bloc/Counter/counter_state.dart';
import 'package:bloc_tutorial/UI/PostApiScreen/post_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CounterApp extends StatefulWidget {
  const CounterApp({super.key});

  @override
  State<CounterApp> createState() => _CounterAppState();
}

class _CounterAppState extends State<CounterApp> {
  late CounterBloc _counterBloc;
  @override
  void initState() {
    super.initState();
    _counterBloc = CounterBloc();
  }

  @override
  void dispose() {
    _counterBloc.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blueAccent,
        foregroundColor: Colors.white,
        title: Center(child: Text("C O U N T E R   A P P")),
      ),
      body: SafeArea(
        child: BlocProvider(
          create: (context) => _counterBloc,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => PostApiScreen()),
                  );
                },
                child: Center(child: Text("Next")),
              ),
              BlocBuilder<CounterBloc, CounterState>(
                builder: (context, state) {
                  return Center(
                    child: Text(
                      state.counter.toString(),
                      style: TextStyle(
                        fontSize: 40,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  );
                },
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  BlocBuilder<CounterBloc, CounterState>(
                    buildWhen: (current, previous) => false,
                    builder: (context, state) {
                      return ElevatedButton(
                        onPressed: () {
                          context.read<CounterBloc>().add(IncrementCounter());
                        },
                        child: Center(child: Text("Increment")),
                      );
                    },
                  ),
                  SizedBox(width: 40),
                  BlocBuilder<CounterBloc, CounterState>(
                    buildWhen: (current, previous) => false,
                    builder: (context, state) {
                      return ElevatedButton(
                        onPressed: () {
                          context.read<CounterBloc>().add(DecrementCounter());
                        },
                        child: Center(child: Text("Decrement")),
                      );
                    },
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
