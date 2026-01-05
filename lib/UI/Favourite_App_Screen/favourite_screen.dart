import 'package:bloc_tutorial/Bloc/Favourite/favourite_bloc.dart';
import 'package:bloc_tutorial/Bloc/Favourite/favourite_events.dart';
import 'package:bloc_tutorial/Bloc/Favourite/favourite_state.dart';
import 'package:bloc_tutorial/Bloc/Models/favourite_items_model.dart';
import 'package:bloc_tutorial/UI/Favourite_App_Screen/Widget/delete_button_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class FavouriteAppScreen extends StatefulWidget {
  const FavouriteAppScreen({super.key});

  @override
  State<FavouriteAppScreen> createState() => _FavouriteAppScreenState();
}

class _FavouriteAppScreenState extends State<FavouriteAppScreen> {
  @override
  void initState() {
    super.initState();
    context.read<FavouriteBloc>().add(FetchFavouriteItemListEvents());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(child: Text("F A V O U R I T E   A P P ")),
        actions: [DeleteButtonWidget()],
      ),
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: BlocBuilder<FavouriteBloc, FavouriteItemsState>(
          builder: (context, state) {
            switch (state.listStatus) {
              case ListStatus.loading:
                return Center(
                  child: CircularProgressIndicator(color: Colors.blueAccent),
                );
              case ListStatus.failure:
                return Center(child: Text("Something went wrong."));
              case ListStatus.success:
                return ListView.builder(
                  itemCount: state.favouriteItemList.length,
                  itemBuilder: (context, index) {
                    final item = state.favouriteItemList[index];
                    return Card(
                      color: Colors.grey,
                      child: ListTile(
                        leading: Checkbox(
                          value:
                              state.tempfavouriteItemList.contains(
                                state.favouriteItemList[index],
                              )
                              ? true
                              : false,
                          onChanged: (bool? value) {
                            FavouriteItemModels items =
                                state.favouriteItemList[index];
                            if (value!) {
                              context.read<FavouriteBloc>().add(
                                SelectItems(items: items),
                              );
                            } else {
                              context.read<FavouriteBloc>().add(
                                UnSelectItems(item: items),
                              );
                            }
                          },
                        ),
                        title: Text(
                          state.favouriteItemList[index].value,
                          style: TextStyle(
                            decoration:
                                state.tempfavouriteItemList.contains(
                                  state.favouriteItemList[index],
                                )
                                ? TextDecoration.lineThrough
                                : TextDecoration.none,
                                color: state.tempfavouriteItemList.contains(state.favouriteItemList[index]) ? Colors.red : Colors.white
                          ),
                        ),
                        trailing: IconButton(
                          onPressed: () {
                            FavouriteItemModels favouriteItemModels =
                                FavouriteItemModels(
                                  id: item.id,
                                  value: item.value.toString(),
                                  isFavourite: item.isFavourite ? false : true,
                                );
                            context.read<FavouriteBloc>().add(
                              FavouriteItemsEvents(items: favouriteItemModels),
                            );
                          },
                          icon: Icon(
                            Icons.favorite,
                            color: item.isFavourite ? Colors.red : Colors.white,
                          ),
                        ),
                      ),
                    );
                  },
                );
            }
          },
        ),
      ),
    );
  }
}
