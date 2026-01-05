import 'package:bloc_tutorial/Bloc/Favourite/favourite_bloc.dart';
import 'package:bloc_tutorial/Bloc/Favourite/favourite_events.dart';
import 'package:bloc_tutorial/Bloc/Favourite/favourite_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DeleteButtonWidget extends StatelessWidget {
  const DeleteButtonWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<FavouriteBloc, FavouriteItemsState>(
      buildWhen: (previous, current) => previous.tempfavouriteItemList != current.tempfavouriteItemList,
      builder: (context, state) {
        return Visibility(
          visible: state.tempfavouriteItemList.isNotEmpty ? true : false,
          child: IconButton(onPressed: () {
            context.read<FavouriteBloc>().add(DeleteItemsEvents());
          }, icon: Icon(Icons.delete, color: Colors.red,)),
        );
      },
    );
  }
}
