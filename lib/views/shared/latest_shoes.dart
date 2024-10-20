import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:online_shop/models/sneaker_model.dart';
import 'package:online_shop/views/shared/stagger_tile.dart';

class LatestShoes extends StatelessWidget {
  const LatestShoes({
    super.key,
    required Future<List<Sneakers>> male,
  }) : _male = male;

  final Future<List<Sneakers>> _male;

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Sneakers>>(
        future: _male,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const CircularProgressIndicator();
          } else if (snapshot.hasError) {
            return Text("Error ${snapshot.error}");
          } else {
            final male = snapshot.data;
            return StaggeredGrid.count(
              crossAxisCount: 2,
              crossAxisSpacing: 20,
              mainAxisSpacing: 16,
              children: List.generate(male!.length, (index) {
                final shoe = snapshot.data![index];
                return StaggerTile(
                    imageUrl: shoe.imageUrl[1],
                    name: shoe.name,
                    price: "\$${shoe.price}");
              }),
            );
          }
        });
  }
}
