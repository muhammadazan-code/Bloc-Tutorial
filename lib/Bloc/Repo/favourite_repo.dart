import 'package:bloc_tutorial/Bloc/Models/favourite_items_model.dart';

class FavouriteRepository {

  /* This metod will return the list */
  Future<List<FavouriteItemModels>> fetchItems() async {
    await Future.delayed(Duration(seconds: 2));
    return List.of(_generateList(20));
  }
/* In this method list will be generated*/
  List<FavouriteItemModels> _generateList(int length) {
    return List.generate(
      length,
      (index) =>
          FavouriteItemModels(id: index.toString(), value: "Items: $index"),
    );
  }
}
