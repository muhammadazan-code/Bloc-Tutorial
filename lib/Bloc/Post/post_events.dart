import 'package:equatable/equatable.dart';

abstract class PostApiEvents extends Equatable {
  @override
  List<Object?> get props => [];
}

class FetchPostApiEvents extends PostApiEvents {}


class SearchItemEvents extends PostApiEvents {
  final String search;
  SearchItemEvents({required this.search});
}