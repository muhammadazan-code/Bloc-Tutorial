import 'package:bloc_tutorial/Bloc/Switch/switch_bloc.dart';
import 'package:bloc_tutorial/Bloc/Switch/switch_event.dart';
import 'package:bloc_tutorial/Bloc/Switch/switch_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SwitchExample extends StatefulWidget {
  const SwitchExample({super.key});

  @override
  State<SwitchExample> createState() => _SwitchExampleState();
}

class _SwitchExampleState extends State<SwitchExample> {
  late SwitchBloc _switchBloc;

  @override
  void initState() {
    _switchBloc = SwitchBloc();
    super.initState();
  }

  @override
  void dispose() {
    _switchBloc.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("S W I T C H  E X A M P L E")),
      body: SafeArea(
        child: BlocProvider(
          create: (context) => _switchBloc,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              BlocBuilder<SwitchBloc, SwitchState>(
                buildWhen: (previous, current) =>
                    previous.value != current.value,
                builder: (context, state) {
                  return Center(
                    child: Switch(
                      value: state.value,
                      onChanged: (newValue) {
                        context.read<SwitchBloc>().add(EnableNotification());
                      },
                    ),
                  );
                },
              ),
              SizedBox(height: 50),
              BlocBuilder<SwitchBloc, SwitchState>(
                // buildWhen: (previous, current) =>
                //     previous.value != current.value,
                builder: (context, state) {
                  return Container(
                    width: 200,
                    height: 80,
                    color: Colors.red.withOpacity(state.slider),
                  );
                },
              ),
              SizedBox(height: 50),
              BlocBuilder<SwitchBloc, SwitchState>(
                builder: (context, state) {
                  return Slider(
                    value: state.slider,
                    onChanged: (newValue) {
                      context.read<SwitchBloc>().add(
                        SliderEvents(slider: newValue),
                      );
                    },
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
