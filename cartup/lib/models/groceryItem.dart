import 'package:cartup/models/category.dart';

class GroceryItem {
  final String id;
  final String name;
  final double quantity;
  final Category category;

  const GroceryItem({
    required this.category,
    required this.id,
    required this.name,
    required this.quantity,
  });
}
