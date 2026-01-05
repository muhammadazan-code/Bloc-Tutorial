import 'package:bloc/bloc.dart';
import 'package:bloc_tutorial/Bloc/Post/post_events.dart';
import 'package:bloc_tutorial/Bloc/Post/post_state.dart';
import 'package:bloc_tutorial/Bloc/Repo/post_repo.dart';

class PostBloc extends Bloc<PostApiEvents, PostState> {
  PostRepo postRepo = PostRepo();

  PostBloc() : super(const PostState()) {
    on<FetchPostApiEvents>(fetchPostApi);
  }

  Future<void> fetchPostApi(
    FetchPostApiEvents events,
    Emitter<PostState> emit,
  ) async {
    await postRepo
        .fetchPost()
        .then((value) {
          emit(
            state.copyWith(
              status: PostStatus.success,
              item: value,
              message: "Success",
            ),
          );
        })
        .onError((error, stackTrace) {
          emit(
            state.copyWith(
              status: PostStatus.failure,
              message: stackTrace.toString(),
            ),
          );
        });
  }
}
