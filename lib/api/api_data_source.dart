import 'base_network.dart';

class ApiDataSource {
  static ApiDataSource instance = ApiDataSource();
  Future<Map<String, dynamic>> loadCategories() {
    return BaseNetwork.get("categories.php");
  }

  Future<Map<String, dynamic>> loadMeals(String strCategory) {
    String category = strCategory.toString();
    return BaseNetwork.get("filter.php?c=$category");
  }

  Future<Map<String, dynamic>> loadMealDetails(String idMeal) {
    String id = idMeal.toString();
    return BaseNetwork.get("lookup.php?i=$id");
  }
}
