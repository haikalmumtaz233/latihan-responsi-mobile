import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:latihan_responsi_plug_e/models/MealDetailsModel.dart';
import '../api/api_data_source.dart';

class MealDetailsPage extends StatefulWidget {
  final String idMeal;
  const MealDetailsPage({super.key, required this.idMeal});

  @override
  State<MealDetailsPage> createState() => _MealDetailsState();
}

class _MealDetailsState extends State<MealDetailsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Meal Detail'),
        centerTitle: true,
      ),
      body: _buildMealDetails(widget.idMeal),
    );
  }

  Widget _buildMealDetails(String idMeal) {
    return FutureBuilder(
      future: ApiDataSource.instance.loadMealDetails(idMeal),
      builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
        if (snapshot.hasError) {
          return _buildErrorSection();
        }
        if (snapshot.connectionState == ConnectionState.waiting) {
          return _buildLoadingSection();
        }
        if (snapshot.hasData) {
          MealDetailModel mealDetailModel =
              MealDetailModel.fromJson(snapshot.data);
          return _buildSuccessSection(mealDetailModel);
        }
        return _buildErrorSection(); // This handles the case where there's no error, no data, but still no data is available (shouldn't happen usually).
      },
    );
  }

  Widget _buildErrorSection() {
    return Center(child: Text("Error"));
  }

  Widget _buildLoadingSection() {
    return Center(
      child: CircularProgressIndicator(),
    );
  }

  Widget _buildSuccessSection(MealDetailModel mealDetailModel) {
    if (mealDetailModel.meals == null || mealDetailModel.meals!.isEmpty) {
      return Center(child: Text("No meal details available"));
    }

    Meals meal = mealDetailModel.meals!.first;

    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Image.network(
            meal.strMealThumb!,
            fit: BoxFit.cover,
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  meal.strMeal!,
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 8),
                Text(
                  "Category: ${meal.strCategory ?? 'N/A'}",
                  style: TextStyle(fontSize: 16),
                ),
                SizedBox(height: 8),
                Text(
                  "Area: ${meal.strArea ?? 'N/A'}",
                  style: TextStyle(fontSize: 16),
                ),
                SizedBox(height: 16),
                Text(
                  "Ingredients",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 8),
                ..._buildIngredientsList(meal),
                SizedBox(height: 16),
                Text(
                  "Instructions",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 8),
                Text(
                  meal.strInstructions ?? 'N/A',
                  style: TextStyle(fontSize: 16),
                ),
                SizedBox(height: 16),
                if (meal.strYoutube != null)
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 16.0),
                    child: SizedBox(
                      width: double.infinity,
                      child: ElevatedButton.icon(
                        onPressed: () => _launchedUrl(meal.strYoutube!),
                        icon: Icon(Icons.play_arrow, color: Colors.brown[800]),
                        label: Text("Watch Tutorial",
                            style: TextStyle(
                              color: Colors.brown[800],
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            )),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.brown[50], // background color
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                          padding: EdgeInsets.symmetric(
                              horizontal: 24, vertical: 24),
                        ),
                      ),
                    ),
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  List<Widget> _buildIngredientsList(Meals meal) {
    List<Widget> ingredients = [];
    for (int i = 1; i <= 20; i++) {
      String? ingredient = meal.toJson()['strIngredient$i'];
      String? measure = meal.toJson()['strMeasure$i'];
      if (ingredient != null && ingredient.isNotEmpty) {
        ingredients.add(
          Text(
            "$ingredient - ${measure ?? ''}",
            style: TextStyle(fontSize: 16),
          ),
        );
      }
    }
    return ingredients;
  }

  Future<void> _launchedUrl(String url) async {
    final Uri _url = Uri.parse(url);
    if (!await launchUrl(_url)) {
      throw Exception('Could not launch $_url');
    }
  }
}
