import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:native_features/model/place.dart';
import 'package:native_features/provider/place_provider.dart';
import 'package:native_features/screen/place_add.dart';
import 'package:native_features/widgets/place_list.dart';

class PlacesScreen extends ConsumerStatefulWidget {
  const PlacesScreen({super.key});

  @override
  ConsumerState<PlacesScreen> createState() => _PlacesScreenState();
}

class _PlacesScreenState extends ConsumerState<PlacesScreen> {
  late Future<void> placefuture;

  @override
  void initState() {
    super.initState();
    placefuture = ref.read(userPlaceProvier.notifier).loadPlace();
  }

  @override
  Widget build(BuildContext context) {
    final places = ref.watch(userPlaceProvier);
    return Scaffold(
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.max,
          children: [
            Icon(Icons.settings, color: Theme.of(context).colorScheme.primary),
            SizedBox(width: 4),
            Text(
              'Native Features',
              style: Theme.of(context).textTheme.titleLarge!.copyWith(
                color: Theme.of(context).colorScheme.primary,
              ),
            ),
          ],
        ),
        actions: [
          IconButton(
            onPressed: () => Navigator.of(
              context,
            ).push(MaterialPageRoute(builder: (ctx) => PlaceAdd())),
            icon: Icon(
              Icons.add,
              color: Theme.of(context).colorScheme.primary,
              size: 40,
            ),
          ),
        ],
      ),
      backgroundColor: Theme.of(context).colorScheme.surface,
      body: FutureBuilder(
        future: placefuture,
        builder: (context, snapshot) =>
            snapshot.connectionState == ConnectionState.waiting
            ? Center(
                child: CircularProgressIndicator(
                  color: Theme.of(context).colorScheme.primary,
                ),
              )
            : PlaceList(place: places),
      ),
    );
  }
}
