import 'package:bloc_tutorial/Bloc/Models/PostModels/post_models.dart';
import 'package:equatable/equatable.dart';

enum PostStatus { loading, failure, success }

class PostState extends Equatable {
  //Properties
  final PostStatus status;
  final List<PostModels> models;
  final String message;
  final String searchMessage;
  final List<PostModels> tempList;

  const PostState({
    this.models = const [],
    this.status = PostStatus.loading,
    this.message = "",
    this.tempList = const [],
    this.searchMessage = "",
  });
  @override
  List<Object?> get props => [status, models, message, tempList, searchMessage];

  PostState copyWith({
    PostStatus? status,
    List<PostModels>? item,
    String? message,
    List<PostModels>? tempList,
    String? searchMessage,
  }) {
    return PostState(
      models: item ?? models,
      status: status ?? this.status,
      message: message ?? this.message,
      tempList: tempList ?? this.tempList,
      searchMessage: searchMessage ?? this.searchMessage,
    );
  }
}
