import 'package:flutter/material.dart';
import 'package:movie_app/models/movie.dart';
import 'package:movie_app/providers/movies_provider.dart';
import 'package:provider/provider.dart';

class MovieSearchDelegate extends SearchDelegate {
  @override
  String? get searchFieldLabel => 'Buscar película';

  @override
  List<Widget>? buildActions(BuildContext context) {
    return [IconButton(onPressed: () => query = '', icon: Icon(Icons.clear))];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
        onPressed: () {
          close(context, null);
        },
        icon: Icon(Icons.arrow_back));
  }

  @override
  Widget buildResults(BuildContext context) {
    return Text("Results");
  }

  Widget _emptyData() {
    return Container(
      child: Center(
          child: Icon(
        Icons.movie_creation_outlined,
        color: Colors.black38,
        size: 130,
      )),
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    if (query.isEmpty) {
      return _emptyData();
    }

    final movieProvider = Provider.of<MoviesProvider>(context, listen: false);

    return FutureBuilder(
      future: movieProvider.searchMovies(query),
      builder: (_, AsyncSnapshot<List<Movie>> snapshot) {
        if (!snapshot.hasData) return _emptyData();

        final movie = snapshot.data!;

        return ListView.builder(
            itemCount: movie.length,
            itemBuilder: (_, int index) => _MovieSuggestions(movie[index],'${movie[index].title}-index'));
      },
    );
  }
}

class _MovieSuggestions extends StatelessWidget {
  final Movie movie;
  final String heroId;
  const _MovieSuggestions(this.movie, this.heroId);

  @override
  Widget build(BuildContext context) {
    movie.heroId = heroId;
    return ListTile(
      leading: Hero(
        tag: movie.heroId!,
        child: FadeInImage(
          placeholder: AssetImage('lib/assets/no-image.jpg'),
          image: NetworkImage(movie.fullPosterImag),
          fit: BoxFit.contain,
          width: 50,
        ),
      ),
      title: Text(movie.title),
      subtitle: Text(movie.originalTitle),
      onTap: () {
        Navigator.pushNamed(context, 'details', arguments: movie.heroId!);
      },
    );
  }
}
