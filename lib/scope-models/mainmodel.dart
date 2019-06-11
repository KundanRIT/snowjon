import 'package:scoped_model/scoped_model.dart';
import 'package:snowjon/scope-models/foodmodel.dart';

class MainModel extends Model
    with FoodUserModel, UserModel, FoodModel, UtilityModel {}
