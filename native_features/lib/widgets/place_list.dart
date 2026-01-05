import 'package:flutter/material.dart';
import 'package:native_features/data/dummy_data.dart';
import 'package:native_features/model/place.dart';
import 'package:native_features/screen/place_screen.dart';

class PlaceList extends StatefulWidget {
  const PlaceList({super.key});

  @override
  State<PlaceList> createState() => _PlaceListState();
}

class _PlaceListState extends State<PlaceList> {
  final List<Place> place = dummyPlaces;

  @override
  Widget build(BuildContext context) {
    if (place.isEmpty) {
      return Center(
        child: Text(
          'No places added yet',
          style: Theme.of(
            context,
          ).textTheme.bodyMedium!.copyWith(fontSize: 15, color: Colors.white),
        ),
      );
    }
    return ListView.builder(
      itemCount: place.length,
      itemBuilder: (context, index) {
        return Padding(
          padding: const EdgeInsets.only(
            left: 10,
            right: 10,
            bottom: 5,
            top: 5,
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: InkWell(
              focusColor: Theme.of(context).splashColor,
              onTap: () => Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => PlaceScreen(
                    name: place[index].title,
                    id: place[index].id,
                  ),
                ),
              ),
              child: Dismissible(
                key: ValueKey(place[index].id),
                direction: DismissDirection.endToStart,

                background: Container(
                  decoration: BoxDecoration(color: Colors.redAccent),
                ),

                secondaryBackground: Container(
                  decoration: BoxDecoration(color: Colors.redAccent),
                  alignment: Alignment.centerRight,
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: const Icon(Icons.delete, color: Colors.white),
                ),

                onDismissed: (direction) {
                  setState(() {
                    place.removeAt(index);
                  });
                },

                child: Container(
                  height: 80,
                  width: MediaQuery.sizeOf(context).width,
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: Theme.of(context).colorScheme.background,
                  ),
                  child: Text(
                    place[index].title,
                    style: Theme.of(context).textTheme.titleLarge!.copyWith(
                      fontSize: 20,
                      color: Theme.of(context).colorScheme.primary,
                    ),
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
