import 'package:bloc/bloc.dart';
import 'package:bloc_tutorial/Bloc/Models/PostModels/post_models.dart';
import 'package:bloc_tutorial/Bloc/Post/post_events.dart';
import 'package:bloc_tutorial/Bloc/Post/post_state.dart';
import 'package:bloc_tutorial/Bloc/Repo/post_repo.dart';

class PostBloc extends Bloc<PostApiEvents, PostState> {
  PostRepo postRepo = PostRepo();
  List<PostModels> temp = [];

  PostBloc() : super(const PostState()) {
    on<FetchPostApiEvents>(fetchPostApi);
    on<SearchItemEvents>(fetchSearchList);
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

  void fetchSearchList(SearchItemEvents events, Emitter<PostState> emit) async {
    if (events.search.isEmpty) {
      emit(state.copyWith(tempList: [], searchMessage: ""));
    } else {
      // temp = state.models
      //     .where((element) => element.id.toString() == events.search.toString())
      //     .toList();
      temp = state.models
          .where(
            (element) => element.email.toString().toLowerCase().contains(
              events.search.toLowerCase(),
            ),
          )
          .toList();

      if (temp.isEmpty) {
        emit(state.copyWith(tempList: temp, searchMessage: "No data found"));
      } else {
        emit(state.copyWith(tempList: temp, searchMessage: ""));
      }
    }
  }
}
