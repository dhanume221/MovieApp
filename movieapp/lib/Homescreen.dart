import 'package:flutter/material.dart';
import 'package:movieapp/MovieApi.dart';
import 'package:movieapp/movieclass.dart';

class HomeScreenMovie extends StatefulWidget {
  @override
  _MovieListState createState() => _MovieListState();
}

class _MovieListState extends State<HomeScreenMovie> {
  late Future<List<MovieApp>> futureMovies;
  String searchQuery = "";

  @override
  void initState() {
    super.initState();
    futureMovies = fetchMovies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Movies',style: TextStyle(color: Colors.white),),
        backgroundColor: const Color.fromARGB(255, 3, 86, 90),
      ),
      backgroundColor: const Color.fromARGB(255, 108, 187, 252),
      body: Column(
        children: [
          // Search Bar
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              decoration: InputDecoration(
                labelText: 'Search Movies',
                border: OutlineInputBorder(),
              ),
              onChanged: (value) {
                setState(() {
                  searchQuery = value;
                });
              },
            ),
          ),
          // Movie List
          Expanded(
            child: FutureBuilder<List<MovieApp>>(
              future: futureMovies,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(child: CircularProgressIndicator());
                } else if (snapshot.hasError) {
                  return Center(child: Text('Error: ${snapshot.error}'));
                } else {
                  List<MovieApp> movies = snapshot.data!;
                  List<MovieApp> favoriteMovies = movies.where((movie) => movie.isFavorite).toList();
                  List<MovieApp> displayedMovies = movies.where((movie) {
                    return movie.title.toLowerCase().contains(searchQuery.toLowerCase());
                  }).toList();

                  return Column(
                    children: [
                      // Favorite Movies Section
                      if (favoriteMovies.isNotEmpty) ...[
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            'Favorite Movies',
                            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                          ),
                        ),
                        ListView.builder(
                          shrinkWrap: true,
                          itemCount: favoriteMovies.length,
                          itemBuilder: (context, index) {
                            final movie = favoriteMovies[index];
                            return ListTile(
                              title: Text(movie.title),
                            );
                          },
                        ),
                      ],
                      // All Movies Section
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          'All Movies',
                          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                        ),
                      ),
                      Expanded(
                        child: ListView.builder(
                          itemCount: displayedMovies.length,
                          itemBuilder: (context, index) {
                            final movie = displayedMovies[index];
                            return ListTile(
                              title: Text(movie.title),
                              trailing: IconButton(
                                icon: Icon(
                                  movie.isFavorite ? Icons.favorite : Icons.favorite_border,
                                  color: movie.isFavorite ? Colors.red : null,
                                ),
                                onPressed: () {
                                  setState(() {
                                    movie.isFavorite = !movie.isFavorite;
                                  });
                                },
                              ),
                            );
                          },
                        ),
                      ),
                    ],
                  );
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}
