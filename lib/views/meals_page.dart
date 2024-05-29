import 'package:flutter/material.dart';
import 'package:latihan_responsi_plug_e/models/MealsModel.dart';
import 'package:latihan_responsi_plug_e/api/api_data_source.dart';
import 'package:latihan_responsi_plug_e/views/meal_details_page.dart';

class MealsPage extends StatelessWidget {
  final String strCategory;
  const MealsPage({super.key, required this.strCategory});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("$strCategory Meals"),
        centerTitle: true,
      ),
      body: _buildListMeals(strCategory),
    );
  }

  Widget _buildListMeals(String strCategory) {
    return FutureBuilder(
      future: ApiDataSource.instance.loadMeals(strCategory),
      builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
        if (snapshot.hasError) {
          return _buildErrorSection();
        }
        if (snapshot.connectionState == ConnectionState.waiting) {
          return _buildLoadingSection();
        }
        if (snapshot.hasData) {
          MealsModel mealsModel = MealsModel.fromJson(snapshot.data);
          return _buildSuccessSection(mealsModel);
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

  Widget _buildSuccessSection(MealsModel mealsModel) {
    if (mealsModel.meals == null || mealsModel.meals!.isEmpty) {
      return Center(child: Text("No meals available"));
    }

    return GridView.builder(
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 3 / 4,
      ),
      itemBuilder: (context, index) {
        Meals meal = mealsModel.meals![index];
        return InkWell(
          onTap: () => Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => MealDetailsPage(idMeal: meal.idMeal!),
              )),
          child: Card(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(
                  child: Container(
                    width: double.infinity,
                    child: Image.network(
                      meal.strMealThumb!,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    meal.strMeal!,
                    style: TextStyle(fontSize: 18),
                    textAlign: TextAlign.center,
                  ),
                ),
              ],
            ),
          ),
        );
      },
      itemCount: mealsModel.meals!.length,
    );
  }
}
