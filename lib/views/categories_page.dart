import 'package:flutter/material.dart';
import 'meals_page.dart';
import 'package:latihan_responsi_plug_e/api/api_data_source.dart';
import 'package:latihan_responsi_plug_e/models/MealCategoriesModel.dart';

class CategoriesPage extends StatefulWidget {
  const CategoriesPage({super.key});

  @override
  State<CategoriesPage> createState() => _CategoriesPageState();
}

class _CategoriesPageState extends State<CategoriesPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Meal Categories',
          style: TextStyle(
            color: Colors.white,
          ),
        ),
        centerTitle: true,
        backgroundColor: Colors.brown[700],
      ),
      body: _buildListCategories(),
    );
  }

  Widget _buildListCategories() {
    return Container(
      child: FutureBuilder(
        future: ApiDataSource.instance.loadCategories(),
        builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
          if (snapshot.hasError) {
            return _buildErrorSection();
          }
          if (snapshot.hasData) {
            MealCategoriesModel categoriesModel =
                MealCategoriesModel.fromJson(snapshot.data);
            return _buildSuccessSection(categoriesModel);
          }
          return _buildLoadingSection();
        },
      ),
    );
  }

  Widget _buildErrorSection() {
    return Text("Error");
  }

  Widget _buildLoadingSection() {
    return Center(
      child: CircularProgressIndicator(),
    );
  }

  Widget _buildSuccessSection(MealCategoriesModel data) {
    return ListView.builder(
      itemCount: data.categories!.length,
      itemBuilder: (BuildContext context, index) {
        return _buildItem(data.categories![index]);
      },
    );
  }

  Widget _buildItem(Categories categoriesData) {
    return InkWell(
      onTap: () => Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) =>
                MealsPage(strCategory: categoriesData.strCategory!),
          )),
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            children: [
              Container(
                width: 150,
                child: Image.network(categoriesData.strCategoryThumb!),
              ),
              SizedBox(height: 15),
              Text(
                categoriesData.strCategory!,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                categoriesData.strCategoryDescription!,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
