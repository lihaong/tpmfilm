import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class SearchPage extends StatefulWidget {
  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  late List _movies;
  late String _searchQuery;
  late bool _isLoading;

  Future<void> _searchMovies(String query) async {
    setState(() {
      _isLoading = true;
      _searchQuery = query;
    });

    String url = "http://www.omdbapi.com/?apikey=b246e7bc&s=$query";
    http.Response response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      setState(() {
        _movies = jsonDecode(response.body)['Search'];
        _isLoading = false;
      });
    } else {
      throw Exception("Failed to search movies");
    }
  }

  @override
  void initState() {
    super.initState();
    _movies = [];
    _searchQuery = "";
    _isLoading = false;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Movie Search"),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              decoration: InputDecoration(
                hintText: "Search movies",
                suffixIcon: IconButton(
                  icon: Icon(Icons.search),
                  onPressed: () {
                    _searchMovies(_searchQuery);
                  },
                ),
              ),
              onChanged: (value) {
                _searchQuery = value.toLowerCase().trimRight();
              },
            ),
          ),
          Expanded(
            child: _isLoading
                ? Center(child: CircularProgressIndicator())
                : ListView.builder(
                    itemCount: _movies.length,
                    itemBuilder: (BuildContext context, int index) {
                      return ListTile(
                        leading: Image.network(_movies[index]['Poster']),
                        title: Text(_movies[index]['Title']),
                        subtitle: Text(_movies[index]['Year']),
                        onTap: () {
                          // Navigator.push(
                          // context,
                          // MaterialPageRoute(
                          // builder: (context) =>
                          // MovieDetailPage(_movies[index]['imdbID']),
                          // ),
                          // );
                        },
                      );
                    },
                  ),
          ),
        ],
      ),
    );
  }
}
