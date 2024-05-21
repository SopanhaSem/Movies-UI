import 'package:flutter/material.dart';
import 'package:flutter_image_slideshow/flutter_image_slideshow.dart';
import 'package:testintelij/src/model/movies.dart';
import 'package:testintelij/src/screen/cardscreen.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List<Movies> listMovies = moviesModel;

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 4,
      child: Scaffold(
        body: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(
                width: double.infinity,
                height: 350,
                child: ImageSlideshow(
                  width: double.infinity,
                  initialPage: 0,
                  indicatorColor: Colors.red,
                  indicatorBackgroundColor: Colors.white,
                  onPageChanged: (value) {
                    print('Page changed: $value');
                  },
                  autoPlayInterval: 3000,
                  isLoop: true,
                  children: [
                    Image.asset(
                      'assets/slideshow/e1.jpg',
                      fit: BoxFit.contain,
                    ),
                    Image.asset(
                      'assets/slideshow/e2.jpg',
                      fit: BoxFit.contain,
                    ),
                    Image.asset(
                      'assets/slideshow/e4.jpg',
                      fit: BoxFit.contain,
                    ),
                  ],
                ),
              ),
               SizedBox(
                height: 50,
                child: TabBar(
                  tabs: const [
                    Tab(text: 'All'),
                    Tab(text: 'Action'),
                    Tab(text: 'Comedy'),
                    Tab(text: 'Romance'),
                  ],
                  indicator: BoxDecoration(
                    color: Colors.red,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  labelColor: Colors.white,
                  unselectedLabelColor: Colors.white,
                  labelStyle: const TextStyle(fontWeight: FontWeight.bold),
                  unselectedLabelStyle: const TextStyle(fontWeight: FontWeight.normal),
                ),
              ),
              SizedBox(
                height: 900, // Adjust height as needed
                child: TabBarView(
                  children: [
                    _moviesListAll(),
                    _moviesList(category: "Action"),
                    _moviesList(category: "Comedy"),
                    _moviesList(category: "Romance"),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _moviesListAll() {
    return Column(
      children: [
        _moviesSection(title: "Action", movies: listMovies.where((movie) => movie.type == "Action").toList()),
        _moviesSection(title: "Comedy", movies: listMovies.where((movie) => movie.type == "Comedy").toList()),
        _moviesSection(title: "Romance", movies: listMovies.where((movie) => movie.type == "Romance").toList()),
      ],
    );
  }

  Widget _moviesSection({required String title, required List<Movies> movies}) {
    return Column(
      children: [
        _moviesContents(title: title),
        SizedBox(
          width: double.infinity,
          height: 230,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: ListView.builder(
              itemCount: movies.length,
              scrollDirection: Axis.horizontal,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.only(right: 20),
                  child: _moviesCard(movies: movies[index]),
                );
              },
            ),
          ),
        ),
      ],
    );
  }

  Widget _moviesList({required String category}) {
    List<Movies> filteredMovies = listMovies.where((movie) => movie.type == category).toList();

    return Column(
      children: [
        _moviesContents(title: category),
        SizedBox(
          width: double.infinity,
          height: 230,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: ListView.builder(
              itemCount: filteredMovies.length,
              scrollDirection: Axis.horizontal,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.only(right: 20),
                  child: _moviesCard(movies: filteredMovies[index]),
                );
              },
            ),
          ),
        ),
      ],
    );
  }

  Widget _moviesContents({required String title}) {
    return Padding(
      padding: const EdgeInsets.all(8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: const TextStyle(
              fontSize: 25,
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
          TextButton(
            onPressed: () {},
            child: const Text("See All"),
          ),
        ],
      ),
    );
  }

  Widget _moviesCard({required Movies movies}) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => DetailCardScreen(movie: movies),
          ),
        );
      },
      child: Hero(
        tag: movies.title!, // Unique tag for each movie
        child: Stack(
          children: [
            Container(
              width: 150,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                image: DecorationImage(
                  image: AssetImage(movies.poster.toString()),
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

}
