import 'package:flutter/material.dart';
import 'package:cartup/data/dummydata.dart';

class YourGroceries extends StatelessWidget {
  const YourGroceries({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: ListView.builder(
        itemCount: groceryItems.length,
        itemBuilder: (ctx, index) => ListTile(
          title: Text(groceryItems[index].name),
          leading: Container(
            height: 24,
            width: 24,
            color: groceryItems[index].category.color,
          ),
          trailing: Text('${groceryItems[index].quantity}'),
        ),
      ),
    );
  }
}
