import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class MovieSearchPage extends StatefulWidget {
  const MovieSearchPage({Key? key}) : super(key: key);

  @override
  _MovieSearchPageState createState() => _MovieSearchPageState();
}

class _MovieSearchPageState extends State<MovieSearchPage> {
  TextEditingController searchController = TextEditingController();

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
      backgroundColor: Color(0xFF1f1545),
      appBar: AppBar(
        backgroundColor: Color(0xFF1f1545),
        elevation: 0.0,
        title: Text('Movie Search App'),
        centerTitle: true,
      ),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Search for a Movie",
              style: TextStyle(
                color: Colors.white,
                fontSize: 22.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(
              height: 20,
            ),
            TextField(
              style: TextStyle(color: Colors.white),
              decoration: InputDecoration(
                  filled: true,
                  fillColor: Color(0xff302360),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: BorderSide.none,
                  ),
                  hintText: "eg: Harry Potter",
                  hintStyle: TextStyle(color: Colors.grey),
                  prefixIcon: Icon(Icons.search),
                  prefixIconColor: Colors.white),
            )
          ],
        ),
      ),
    );
  }
}
