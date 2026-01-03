import 'package:cartup/widgets/newItem.dart';
import 'package:flutter/material.dart';
import 'package:cartup/data/dummydata.dart';

class YourGroceries extends StatefulWidget {
  const YourGroceries({super.key});

  @override
  State<YourGroceries> createState() => _YourGroceriesState();
}

class _YourGroceriesState extends State<YourGroceries> {
  @override
  Widget build(BuildContext context) {
    void _addNewItem() {
      Navigator.of(
        context,
      ).push(MaterialPageRoute(builder: (ctx) => NewItem()));
    }

    return Scaffold(
      appBar: AppBar(
        title: Text('CartUp'),
        actions: [IconButton(onPressed: _addNewItem, icon: Icon(Icons.add))],
      ),
      body: Container(
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
      ),
    );
  }
}
