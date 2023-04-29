import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class MovieSearchPage extends StatefulWidget {
  const MovieSearchPage({Key? key}) : super(key: key);

  @override
  _MovieSearchPageState createState() => _MovieSearchPageState();
}

class _MovieSearchPageState extends State<MovieSearchPage> {
  TextEditingController _searchController = TextEditingController();

  late List movies;
  Future getMovies() async {
    String url = "http://www.omdbapi.com/?apikey=b246e7bc&s=harry potter";
    http.Response response = await http.get(Uri.parse(url));
    setState(() {
      movies = jsonDecode(response.body)['Search'];
    });
  }

  @override
  void initState() {
    super.initState();
    getMovies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Movie Search'),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Padding(
            padding: EdgeInsets.all(16),
            child: TextField(
              controller: _searchController,
              decoration: InputDecoration(
                hintText: 'Search movies...',
                prefixIcon: Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),
          ),
          Expanded(
            child: GridView.count(
              padding: EdgeInsets.all(16),
              crossAxisCount: 2,
              crossAxisSpacing: 16,
              mainAxisSpacing: 16,
              children: List.generate(
                10,
                (index) => Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Expanded(
                        child: Container(
                          decoration: BoxDecoration(
                            image: DecorationImage(
                              image: AssetImage('assets/poster.jpg'),
                              fit: BoxFit.cover,
                            ),
                            borderRadius: BorderRadius.vertical(
                              top: Radius.circular(10),
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.all(8),
                        child: Text(
                          'Movie Title',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
