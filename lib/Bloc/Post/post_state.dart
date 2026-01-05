import 'package:bloc_tutorial/Bloc/Models/PostModels/post_models.dart';
import 'package:equatable/equatable.dart';

enum PostStatus { loading, failure, success }

class PostState extends Equatable {
  //Properties
  final PostStatus status;
  final List<PostModels> models;
  final String message;

  const PostState({
    this.models = const [],
    this.status = PostStatus.loading,
    this.message = "",
  });
  @override
  List<Object?> get props => [status, models, message];

  PostState copyWith({
    PostStatus? status,
    List<PostModels>? item,
    String? message,
  }) {
    return PostState(
      models: item ?? models,
      status: status ?? this.status,
      message: message ?? this.message,
    );
  }
}
