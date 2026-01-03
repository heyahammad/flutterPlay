import 'package:cartup/models/groceryItem.dart';
import 'package:cartup/widgets/newItem.dart';
import 'package:flutter/material.dart';

class YourGroceries extends StatefulWidget {
  const YourGroceries({super.key});

  @override
  State<YourGroceries> createState() => _YourGroceriesState();
}

class _YourGroceriesState extends State<YourGroceries> {
  final List<GroceryItem> _groceryItems = [];
  @override
  Widget build(BuildContext context) {
    void _addNewItem() async {
      final newItem = await Navigator.of(
        context,
      ).push(MaterialPageRoute(builder: (ctx) => NewItem()));

      if (newItem != null) {
        setState(() {
          _groceryItems.add(newItem);
        });
      }
    }

    Widget _showItem() {
      if (_groceryItems.isEmpty) {
        return Center(child: Text('No items added yet!'));
      } else {
        return Container(
          child: ListView.builder(
            itemCount: _groceryItems.length,
            itemBuilder: (ctx, index) => Dismissible(
              background: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  color: Colors.red,
                ),
                margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                padding: EdgeInsets.only(right: 20),
                alignment: Alignment.centerRight,
                child: Icon(Icons.delete, color: Colors.white, size: 40),
              ),
              direction: DismissDirection.endToStart,
              key: ValueKey(_groceryItems[index].id),
              onDismissed: (ctx) {
                setState(() {
                  _groceryItems.removeAt(index);
                });
              },
              child: ListTile(
                title: Text(_groceryItems[index].name),
                leading: Container(
                  height: 24,
                  width: 24,
                  color: _groceryItems[index].category.color,
                ),
                trailing: Text(
                  '${_groceryItems[index].quantity}',
                  style: TextStyle(fontSize: 16),
                ),
              ),
            ),
          ),
        );
      }
    }

    return Scaffold(
      appBar: AppBar(
        title: Text('CartUp'),
        actions: [IconButton(onPressed: _addNewItem, icon: Icon(Icons.add))],
      ),
      body: _showItem(),
    );
  }
}
