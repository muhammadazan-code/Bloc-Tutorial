import 'package:bloc_tutorial/Bloc/Favourite/favourite_events.dart';
import 'package:bloc_tutorial/Bloc/Favourite/favourite_state.dart';
import 'package:bloc_tutorial/Bloc/Models/favourite_items_model.dart';
import 'package:bloc_tutorial/Bloc/Repo/favourite_repo.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class FavouriteBloc extends Bloc<FavouriteAppEvents, FavouriteItemsState> {
  List<FavouriteItemModels> favouriteList = [];
  List<FavouriteItemModels> tempFavList = [];

  FavouriteRepository favouriteRepository;

  FavouriteBloc(this.favouriteRepository) : super(const FavouriteItemsState()) {
    on<FetchFavouriteItemListEvents>(fetchList);
    on<FavouriteItemsEvents>(_addFavouriteList);
    on<SelectItems>(_selectItem);
    on<UnSelectItems>(_unSelectItem);
    on<DeleteItemsEvents>(_deleteItem);
  }

  void fetchList(
    FetchFavouriteItemListEvents event,
    Emitter<FavouriteItemsState> emit,
  ) async {
    favouriteList = await favouriteRepository.fetchItems();
    emit(
      state.copyWith(
        favouriteItemList: List.from(favouriteList),
        listStatus: ListStatus.success,
      ),
    );
  }

  void _addFavouriteList(
    FavouriteItemsEvents events,
    Emitter<FavouriteItemsState> emit,
  ) async {
    final index = favouriteList.indexWhere(
      (element) => element.id == events.items.id,
    );

    if (events.items.isFavourite) {
      if (tempFavList.contains(favouriteList[index])) {
        tempFavList.remove(favouriteList[index]);
        tempFavList.add(favouriteList[index]);
      }
    } else {
      if (tempFavList.contains(favouriteList[index])) {
        tempFavList.remove(favouriteList[index]);
        tempFavList.add(events.items);
      }
    }
    favouriteList[index] = events.items;

    emit(
      state.copyWith(
        favouriteItemList: List.from(favouriteList),
        tempFavouriteItems: List.from(tempFavList),
      ),
    );
  }

  void _selectItem(SelectItems event, Emitter<FavouriteItemsState> emit) async {
    tempFavList.add(event.items);
    emit(state.copyWith(tempFavouriteItems: List.from(tempFavList)));
  }

  void _unSelectItem(
    UnSelectItems event,
    Emitter<FavouriteItemsState> emit,
  ) async {
    tempFavList.remove(event.item);
    emit(state.copyWith(tempFavouriteItems: List.from(tempFavList)));
  }

  void _deleteItem(DeleteItemsEvents event, Emitter<FavouriteItemsState> emit) {
    for (var i = 0; i < tempFavList.length; i++) {
      favouriteList.remove(tempFavList[i]);
    }
    tempFavList.clear();

    emit(
      state.copyWith(
        favouriteItemList: List.from(favouriteList),
        tempFavouriteItems: List.from(tempFavList),
      ),
    );
  }
}
