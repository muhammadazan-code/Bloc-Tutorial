import 'package:bloc_tutorial/Bloc/Models/favourite_items_model.dart';
import 'package:equatable/equatable.dart';

enum ListStatus { loading, success, failure }

class FavouriteItemsState extends Equatable {

  final List<FavouriteItemModels> tempfavouriteItemList;
  final List<FavouriteItemModels> favouriteItemList;
  final ListStatus listStatus;

  const FavouriteItemsState({
    this.favouriteItemList = const [],
    this.listStatus = ListStatus.loading,
    this.tempfavouriteItemList = const [],
  });

  FavouriteItemsState copyWith({
    List<FavouriteItemModels>? favouriteItemList,
    List<FavouriteItemModels>? tempFavouriteItems,
    ListStatus? listStatus,
  }) {
    return FavouriteItemsState(
      favouriteItemList: favouriteItemList ?? this.favouriteItemList,
      listStatus: listStatus ?? this.listStatus,
      tempfavouriteItemList: tempFavouriteItems ?? this.favouriteItemList,
    );
  }

  @override
  List<Object?> get props => [
    favouriteItemList,
    listStatus,
    tempfavouriteItemList,
  ];
}
