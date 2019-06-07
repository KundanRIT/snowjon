import 'package:scoped_model/scoped_model.dart';
import 'package:snowjon/models/food.dart';

class FoodModel extends Model {
  final List<Food> _foods = [];
  int _selectedIndex;
  bool _showFavouriteOnly = false;

  List<Food> get foods {
    return List.from(_foods);
  }

  int get selectedIndex {
    return _selectedIndex;
  }

  Food get selectedFood {
    return _selectedIndex == null ? null : _foods[_selectedIndex];
  }

  bool get showFavouriteOnly {
    return _showFavouriteOnly;
  }

  List<Food> get displayFood {
    if (_showFavouriteOnly)
      return _foods.where((Food food) => food.isFavourite).toList();
    return foods;
  }

  void addFood(Food newFood) {
    _foods.add(newFood);
  }

  void updateFood(Food food) {
    _foods[_selectedIndex] = food;
    _selectedIndex = null;
  }

  void deleteFood() {
    _foods.removeAt(_selectedIndex);
    _selectedIndex = null;
  }

  void selectIndex(int index) {
    _selectedIndex = index;
  }

  void toggleFavourite() {
    bool fav = selectedFood.isFavourite;
    bool newFav = !fav;
    Food newFood = Food(
      title: selectedFood.title,
      description: selectedFood.description,
      price: selectedFood.price,
      imageUrl: selectedFood.imageUrl,
      isFavourite: newFav
    );
    updateFood(newFood);
    notifyListeners();
  }

  void toggleDisplayMode() {
    _showFavouriteOnly = !_showFavouriteOnly;
    notifyListeners();
  }
}