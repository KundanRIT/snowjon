import 'package:scoped_model/scoped_model.dart';
import 'package:http/http.dart' as http;
import 'package:snowjon/models/authmode.dart';
import 'dart:convert';
import 'package:snowjon/models/food.dart';
import 'package:snowjon/models/user.dart';

class FoodUserModel extends Model {
  List<Food> _foods = [];
  User _authenticatedUser;
  bool _isLoading = false;

  final String apiKey = 'AIzaSyAr-ylLSh9QVSCQsIiruOHpEqrqiq3zSLc';
}

class FoodModel extends FoodUserModel {
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

  Future<bool> fetchFoods() {
    _isLoading = true;
    notifyListeners();
    return http.get('https://snowjohn-9ddcf.firebaseio.com/foods.json').then(
      (response) {
        if (response.statusCode == 200 || response.statusCode == 201) {
          final List<Food> foods = [];
          Map<String, dynamic> res = json.decode(response.body);
          if (res != null) {
            res.forEach((String key, dynamic value) {
              Food food = Food(
                  id: key,
                  title: value['title'],
                  description: value['description'],
                  price: value['price'],
                  imageUrl: value['imageUrl'],
                  isFavourite: value['isFavourite'],
                  email: value['email'],
                  userId: value['userId']);
              foods.add(food);
            });
          }
          _foods = foods;
          _isLoading = false;
          notifyListeners();
          return true;
        } else {
          _isLoading = false;
          notifyListeners();
          return false;
        }
      },
    );
  }

  Future<bool> addFood(Map<String, dynamic> newFood) {
    newFood['userId'] = _authenticatedUser.id;
    newFood['email'] = _authenticatedUser.email;
    newFood['isFavourite'] = false;
    _isLoading = true;
    notifyListeners();
    return http
        .post(
      'https://snowjohn-9ddcf.firebaseio.com/foods.json',
      body: json.encode(newFood),
    )
        .then(
      (response) {
        if (response.statusCode == 200 || response.statusCode == 201) {
          Map<String, dynamic> id = json.decode(response.body);
          _foods.add(Food(
              id: id['name'],
              title: newFood['title'],
              description: newFood['description'],
              price: newFood['price'],
              imageUrl: newFood['imageUrl'],
              userId: _authenticatedUser.id,
              email: _authenticatedUser.email));
          _isLoading = false;
          notifyListeners();
          return true;
        } else {
          _isLoading = false;
          notifyListeners();
          return false;
        }
      },
    );
  }

  Future<bool> updateFood(Map<String, dynamic> food) {
    food['userId'] = selectedFood.id;
    food['email'] = selectedFood.email;
    food['isFavourite'] = selectedFood.isFavourite;
    _isLoading = true;
    notifyListeners();
    return http
        .put(
      'https://snowjohn-9ddcf.firebaseio.com/foods/${selectedFood.id}.json',
      body: json.encode(food),
    )
        .then(
      (response) {
        if (response.statusCode == 200 || response.statusCode == 201) {
          Map<String, dynamic> id = json.decode(response.body);
          _foods[selectedIndex] = Food(
              id: id['name'],
              title: food['title'],
              description: food['description'],
              price: food['price'],
              imageUrl: food['imageUrl'],
              isFavourite: selectedFood.isFavourite,
              userId: selectedFood.id,
              email: selectedFood.email);
          _isLoading = false;
          notifyListeners();
          return true;
        } else {
          _isLoading = false;
          notifyListeners();
          return false;
        }
      },
    );
  }

  void deleteFood() {
    _isLoading = true;
    String selectedFoodId = selectedFood.id;
    _foods.removeAt(_selectedIndex);
    _selectedIndex = null;
    notifyListeners();
    http
        .delete(
            'https://snowjohn-9ddcf.firebaseio.com/foods/$selectedFoodId.json')
        .then((response) {
      _isLoading = false;
      notifyListeners();
    });
  }

  void selectIndex(int index) {
    _selectedIndex = index;
  }

  void toggleFavourite() {
    selectedFood.isFavourite = !selectedFood.isFavourite;
    _selectedIndex = null;
    notifyListeners();
  }

  void toggleDisplayMode() {
    _showFavouriteOnly = !_showFavouriteOnly;
    notifyListeners();
  }
}

class UserModel extends FoodUserModel {
  User get authenticatedUser {
    return _authenticatedUser;
  }

  Future<Map<String, dynamic>> authenticate(String email, String password,
      [AuthMode authmode = AuthMode.LOGIN]) async {
    _isLoading = true;
    notifyListeners();
    try {
      Map<String, dynamic> body = {
        'email': email,
        'password': password,
        'returnSecureToken': true
      };
      http.Response response;
      if (authmode == AuthMode.SIGNUP) {
        response = await http.post(
            'https://www.googleapis.com/identitytoolkit/v3/relyingparty/signupNewUser?key=$apiKey',
            body: json.encode(body),
            headers: {'contentType': 'application/json'});
      } else {
        response = await http.post(
            'https://www.googleapis.com/identitytoolkit/v3/relyingparty/verifyPassword?key=$apiKey',
            body: json.encode(body),
            headers: {'contentType': 'application/json'});
      }
      _authenticatedUser = User("1", email, password);
      _isLoading = false;
      notifyListeners();
      return json.decode(response.body);
    } catch (error) {
      _isLoading = false;
      notifyListeners();
      return error;
    }
  }
}

class UtilityModel extends FoodUserModel {
  bool get isLoading {
    return _isLoading;
  }
}
