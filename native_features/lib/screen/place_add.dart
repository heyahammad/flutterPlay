import 'package:flutter/material.dart';

class PlaceAdd extends StatefulWidget {
  const PlaceAdd({super.key});

  @override
  State<PlaceAdd> createState() => _PlaceAddState();
}

class _PlaceAddState extends State<PlaceAdd> {
  final _keyform = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Add Place',
          style: Theme.of(context).textTheme.titleLarge!.copyWith(
            color: Theme.of(context).colorScheme.primary,
          ),
        ),
      ),
      body: Form(
        key: _keyform,
        child: Container(
          margin: EdgeInsets.all(20),
          child: Column(
            children: [
              TextFormField(
                decoration: InputDecoration(label: Text('Enter a place name')),
                validator: (value) {
                  if (value == null || value.isEmpty || value.length >= 50) {
                    return 'Please enter a place name (1-50)';
                  }
                  return null;
                },
              ),
              SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  TextButton(onPressed: () {}, child: Text('Reset')),
                  ElevatedButton(onPressed: () {}, child: Text('Add Place')),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
