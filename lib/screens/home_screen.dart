import 'package:flutter/material.dart';
import 'package:movie_app/providers/movies_provider.dart';
import 'package:movie_app/widgets/widgets.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final moviesProvider = Provider.of<MoviesProvider>(context);
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text("Peliculas en cine"),
          elevation: 0,
          actions: [
            IconButton(onPressed: () {}, icon: Icon(Icons.search_outlined)),
          ],
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              //Tarjetas inicio
              CardSwiper(movies: moviesProvider.onDisplayMovies,),
              MovieSlider()
            ],
            // Slider de peliculas
          ),
        ));
  }
}
