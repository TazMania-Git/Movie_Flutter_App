import 'package:flutter/material.dart';
import 'package:movie_app/models/models.dart';
import 'package:movie_app/widgets/widgets.dart';

class DetailScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final Movie movie = ModalRoute.of(context)!.settings.arguments as Movie;
    // print(movie.title);

    return Scaffold(
        body: CustomScrollView(
      slivers: [
        _CustomAppBar(
          movie,
        ),
        SliverList(
            delegate: SliverChildListDelegate([
          _PosterAndTittle(
            movie,
          ),
          _Overview(
            movie,
          ),
          CastingCards()
        ]))
      ],
    ));
  }
}

class _CustomAppBar extends StatelessWidget {
  final Movie theMovie;

  const _CustomAppBar(this.theMovie);

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      backgroundColor: Colors.indigo,
      expandedHeight: 200,
      floating: false,
      pinned: true,
      flexibleSpace: FlexibleSpaceBar(
        titlePadding: EdgeInsets.all(0),
        centerTitle: true,
        title: Container(
            color: Colors.black12,
            width: double.infinity,
            alignment: Alignment.bottomCenter,
            padding: EdgeInsets.only(bottom: 5),
            child: Text(
              theMovie.title,
              style: TextStyle(fontSize: 16),
            )),
        background: FadeInImage(
          placeholder: AssetImage('lib/assets/loading.gif'),
          // image: NetworkImage('https://via.placeholder.com/500x300'),
          image: NetworkImage(theMovie.fullBackdropPath),
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}

class _PosterAndTittle extends StatelessWidget {
  final Movie theMovie;

  const _PosterAndTittle(this.theMovie);

  @override
  Widget build(BuildContext context) {
    final TextTheme textTheme = Theme.of(context).textTheme;
    return Container(
      margin: EdgeInsets.only(top: 20),
      padding: EdgeInsets.symmetric(horizontal: 20),
      child: Row(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: FadeInImage(
              placeholder: AssetImage('lib/assets/no-image.jpg'),
              // image: NetworkImage('https://via.placeholder.com/200x300'),
              image: NetworkImage(theMovie.fullPosterImag),
              height: 150,
            ),
          ),
          SizedBox(
            width: 20,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                theMovie.title,
                style: textTheme.headline5,
                overflow: TextOverflow.ellipsis,
                maxLines: 2,
              ),
              Text(
                theMovie.originalTitle,
                style: textTheme.subtitle1,
                overflow: TextOverflow.ellipsis,
                maxLines: 1,
              ),
              Row(
                children: [
                  Icon(
                    Icons.star_outline,
                    size: 20,
                    color: Colors.grey,
                  ),
                  SizedBox(
                    width: 5,
                  ),
                  Text(
                    theMovie.voteAverage.toString(),
                    style: textTheme.caption,
                  )
                ],
              ),
            ],
          )
        ],
      ),
    );
  }
}

class _Overview extends StatelessWidget {
  final Movie theMovie;

  const _Overview(this.theMovie);

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: EdgeInsets.symmetric(horizontal: 30, vertical: 10),
        child: Text(
          theMovie.overview,
          textAlign: TextAlign.justify,
          style: Theme.of(context).textTheme.subtitle1,
        ));
  }
}
