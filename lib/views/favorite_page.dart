import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:latihan_responsi_plug_e/db/local.dart';
import 'package:latihan_responsi_plug_e/models/MealsModel.dart';
import '../api/api_data_source.dart';

class FavoritePage extends StatefulWidget {
  const FavoritePage({Key? key}) : super(key: key);

  @override
  State<FavoritePage> createState() => _FavoritePageState();
}

class _FavoritePageState extends State<FavoritePage> {
  List<Meals> favorites = [];

  @override
  void initState() {
    super.initState();
    _loadItems();
  }

  Future<void> _loadItems() async {
    final source = SaveToLocalDb.getString('favorite');
    if (source != null && source.isNotEmpty) {
      final List<dynamic> itemsDb = jsonDecode(source);
      final List<String> favoriteIds =
          itemsDb.map((item) => item as String).toList();
      final List<Meals> favoriteMeals = await _fetchFavoriteMeals(favoriteIds);
      setState(() {
        favorites = favoriteMeals;
      });
    }
  }

  Future<List<Meals>> _fetchFavoriteMeals(List<String> mealIds) async {
    List<Meals> favoriteMeals = [];
    for (String mealId in mealIds) {
      final mealDetails = await ApiDataSource.instance.loadMealDetails(mealId);
      if (mealDetails != null) {
        final Meals meal = Meals.fromJson(mealDetails);
        favoriteMeals.add(meal);
      }
    }
    return favoriteMeals;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Favorites Meals',
          style: TextStyle(
            color: Colors.white,
          ),
        ),
        centerTitle: true,
        backgroundColor: Colors.brown[700],
      ),
      body: _buildFavoritesList(),
    );
  }

  Widget _buildFavoritesList() {
    if (favorites.isEmpty) {
      return Center(
        child: Text('No favorites added yet.'),
      );
    } else {
      return ListView.builder(
        itemCount: favorites.length,
        itemBuilder: (context, index) {
          return _buildFavoriteItem(favorites[index]);
        },
      );
    }
  }

  Widget _buildFavoriteItem(Meals meal) {
    return ListTile(
      leading: CircleAvatar(
        backgroundImage: NetworkImage(meal.strMealThumb ?? ''),
      ),
      title: Text(meal.strMeal ?? 'Unknown'),
      onTap: () {
        // Navigate to meal details page or perform other action
      },
    );
  }
}
