import 'package:bloc_tutorial/Bloc/Post/post_bloc.dart';
import 'package:bloc_tutorial/Bloc/Post/post_events.dart';
import 'package:bloc_tutorial/Bloc/Post/post_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PostApiScreen extends StatefulWidget {
  const PostApiScreen({super.key});

  @override
  State<PostApiScreen> createState() => _PostApiScreenState();
}

class _PostApiScreenState extends State<PostApiScreen> {
  @override
  void initState() {
    super.initState();
    context.read<PostBloc>().add(FetchPostApiEvents());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(child: Text("P o s t  A p i")),
        backgroundColor: Colors.blueAccent,
        foregroundColor: Colors.white,
      ),
      body: BlocBuilder<PostBloc, PostState>(
        builder: (context, state) {
          switch (state.status) {
            case PostStatus.loading:
              return Center(
                child: CircularProgressIndicator(color: Colors.blue),
              );
            case PostStatus.failure:
              return Center(child: Text(state.message));
            case PostStatus.success:
              return ListView.builder(
                itemCount: state.models.length,
                itemBuilder: (context, index) {
                  final content = state.models[index];
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Card(
                      shadowColor: Colors.black54,
                      elevation: 5,
                      child: ListTile(
                        title: Text("Email: ${content.email}"),
                        subtitle: Text(
                          "Content: ${content.body}",
                          textAlign: TextAlign.left,
                        ),
                      ),
                    ),
                  );
                },
              );
          }
        },
      ),
    );
  }
}
