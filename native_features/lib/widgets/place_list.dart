import 'package:flutter/material.dart';

import 'package:native_features/model/place.dart';
import 'package:native_features/screen/place_screen.dart';

class PlaceList extends StatefulWidget {
  const PlaceList({super.key, required this.place});
  final List<Place> place;

  @override
  State<PlaceList> createState() => _PlaceListState();
}

class _PlaceListState extends State<PlaceList> {
  @override
  Widget build(BuildContext context) {
    if (widget.place.isEmpty) {
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
      itemCount: widget.place.length,
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
                    name: widget.place[index].title,
                    id: widget.place[index].id,
                    image: widget.place[index].image,
                    placeLocation: widget.place[index].placelocation,
                  ),
                ),
              ),
              child: Dismissible(
                key: ValueKey(widget.place[index].id),
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
                    widget.place.removeAt(index);
                  });
                },

                child: Container(
                  height: 80,
                  width: MediaQuery.sizeOf(context).width,
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: Theme.of(context).colorScheme.background,
                  ),
                  child: ListTile(
                    leading: CircleAvatar(
                      backgroundImage: FileImage(widget.place[index].image),
                    ),
                    title: Text(
                      widget.place[index].title,
                      style: Theme.of(context).textTheme.titleLarge!.copyWith(
                        fontSize: 20,
                        color: Theme.of(context).colorScheme.primary,
                      ),
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
