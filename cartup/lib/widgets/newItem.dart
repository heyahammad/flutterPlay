import 'package:cartup/models/groceryItem.dart';
import 'package:flutter/material.dart';
import 'package:cartup/data/categories.dart';
import 'package:cartup/models/category.dart';
import 'package:http/http.dart' as http;

class NewItem extends StatefulWidget {
  const NewItem({super.key});

  @override
  State<NewItem> createState() => _NewItemState();
}

class _NewItemState extends State<NewItem> {
  final _keyForm = GlobalKey<FormState>();
  var _itemname = '';
  var _itemQuantity = 1;
  var _selectedCategory = categories[Categories.vegetables]!;

  void _save() {
    if (_keyForm.currentState!.validate()) {
      _keyForm.currentState!.save();
      Navigator.of(context).pop(
        GroceryItem(
          category: _selectedCategory,
          id: DateTime.now.toString(),
          name: _itemname,
          quantity: _itemQuantity.toDouble(),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Add New Item')),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Form(
          key: _keyForm,
          child: Column(
            children: [
              TextFormField(
                initialValue: _itemname,
                decoration: InputDecoration(labelText: 'Item Name'),
                validator: (value) {
                  if (value == null || value.isEmpty || value.length > 50) {
                    return 'Please enter a valid name (1-50 characters).';
                  }
                  return null;
                },
                onSaved: (value) {
                  _itemname = value!;
                },
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Expanded(
                    child: TextFormField(
                      initialValue: _itemQuantity.toString(),
                      decoration: InputDecoration(label: Text('Quantity')),
                      keyboardType: TextInputType.number,
                      keyboardAppearance: Brightness.dark,
                      validator: (value) {
                        if (value == null ||
                            value.isEmpty ||
                            int.tryParse(value) == null ||
                            int.parse(value) <= 0) {
                          return 'Please enter a valid quantity.';
                        }
                        return null;
                      },
                      onSaved: (value) {
                        _itemQuantity = int.tryParse(value!)!;
                      },
                    ),
                  ),
                  SizedBox(width: 10),
                  Expanded(
                    child: DropdownButtonFormField(
                      value: _selectedCategory,
                      items: [
                        for (final category in categories.entries)
                          DropdownMenuItem(
                            value: category.value,
                            child: Row(
                              children: [
                                Container(
                                  width: 16,
                                  height: 16,
                                  color: category.value.color,
                                ),
                                SizedBox(width: 6),
                                Text(category.value.name),
                              ],
                            ),
                          ),
                      ],
                      onChanged: (value) {
                        _selectedCategory = value!;
                      },
                    ),
                  ),
                ],
              ),
              SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  TextButton(
                    onPressed: () {
                      _keyForm.currentState!.reset();
                    },
                    child: Text('Reset'),
                  ), //reset button
                  SizedBox(width: 10),
                  ElevatedButton(
                    onPressed: () {
                      _save();
                    },
                    child: Text("Add Item"),
                  ), //add item button
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
