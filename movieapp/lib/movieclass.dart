class MovieApp {
  final String title;
  bool isFavorite;

  MovieApp({required this.title, this.isFavorite = false});

  factory MovieApp.fromJson(Map<String, dynamic> json) {
    return MovieApp(
      title: json['Title'],
    );
  }
}
