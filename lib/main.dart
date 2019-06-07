import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:snowjon/pages/auth.dart';
import 'package:snowjon/pages/details.dart';
import 'package:snowjon/pages/foods.dart';
import 'package:snowjon/pages/managefood.dart';
import 'package:snowjon/scope-models/foodmodel.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _MyApp();
  }
}

class _MyApp extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return ScopedModel<FoodModel>(
      model: FoodModel(),
      child: MaterialApp(
        home: AuthPage(),
        theme: ThemeData(
            primarySwatch: Colors.deepPurple,
            accentColor: Colors.deepOrange,
            brightness: Brightness.light),
        routes: {
          'food': (BuildContext context) => FoodsPage(),
          'managefood': (BuildContext context) => ManageFood()
        },
        onGenerateRoute: (RouteSettings settings) {
          final List<String> path = settings.name.split('/');
          if (path[0] != '') {
            return null;
          }
          if (path[1] == 'food') {
            int index = int.parse(path[2]);
            return MaterialPageRoute<bool>(
                builder: (BuildContext context) => DetailsPage(index));
          }
        },
      ),
    );
  }
}
