import 'package:equatable/equatable.dart';

abstract class PostApiEvents extends Equatable {
  @override
  List<Object?> get props => [];
}

class FetchPostApiEvents extends PostApiEvents {}
