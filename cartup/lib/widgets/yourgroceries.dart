import 'dart:convert';

import 'package:cartup/data/categories.dart';
import 'package:cartup/models/groceryItem.dart';
import 'package:cartup/widgets/newItem.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class YourGroceries extends StatefulWidget {
  const YourGroceries({super.key});

  @override
  State<YourGroceries> createState() => _YourGroceriesState();
}

class _YourGroceriesState extends State<YourGroceries> {
  List<GroceryItem> _groceryItems = [];
  List<GroceryItem> _loadedItems = [];

  bool _isLoading = true;
  String error = '';

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _loadItems();
  }

  final _url = Uri.https(
    'trial-faisal-default-rtdb.asia-southeast1.firebasedatabase.app',
    '/groceryItems.json',
  );

  void _loadItems() async {
    final response = await http.get(_url);

    if (response.statusCode >= 400) {
      error = 'Something went wrong!';
      setState(() {
        _isLoading = false;
      });
      return;
    }
    if (response.statusCode == 200 && response.body == 'null') {
      error = 'No items added yet!';
      setState(() {
        _isLoading = false;
      });
      return;
    }

    try {
      final loadeddata = jsonDecode(response.body) as Map<String, dynamic>;

      for (final item in loadeddata.entries) {
        final category = categories.entries.firstWhere((cat) {
          return cat.value.name == item.value['category'];
        });

        _loadedItems.add(
          GroceryItem(
            id: item.key,
            name: item.value['name'],
            quantity: double.parse(item.value['quantity']),
            category: category.value,
          ),
        );
        setState(() {
          _isLoading = false;
          _groceryItems = _loadedItems;
        });
      }
    } catch (e) {
      error = e.toString();
    }
  }

  void _addNewItem() async {
    final newItem = await Navigator.of(
      context,
    ).push(MaterialPageRoute(builder: (ctx) => NewItem()));

    if (newItem != null) {
      setState(() {
        _groceryItems.add(newItem); // Just add the one new item!
      });
    }
  }

  void _removeItem(int index) {
    http.delete(
      _url.replace(path: '/groceryItems/${_groceryItems[index].id}.json'),
    );
    setState(() {
      _groceryItems.removeAt(index);
    });
    if (_groceryItems.isEmpty) {
      error = 'No items added yet!';
    }
  }

  Widget _showItem() {
    if (_isLoading) {
      return Center(child: CircularProgressIndicator());
    } else if (error.isNotEmpty && _groceryItems.isEmpty) {
      return Center(child: Text(error));
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
              _removeItem(index);
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('CartUp'),
        actions: [IconButton(onPressed: _addNewItem, icon: Icon(Icons.add))],
      ),
      body: _showItem(),
    );
  }
}
