import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:movieapp/movieclass.dart';

Future<List<MovieApp>> fetchMovies() async { 

  final response = await http.get(Uri.parse('https://www.themoviedb.org/documentation/api')); 
  if (response.statusCode == 200) { List jsonResponse = json.decode(response.body); 
  return jsonResponse.map((movie) => MovieApp.fromJson(movie)).toList(); }
   else { throw Exception('No Data'); }

}

