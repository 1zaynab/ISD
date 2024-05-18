/*
import 'package:flutter/material.dart';
import 'article.dart';
import 'tweet_service.dart';

class HomePage extends StatefulWidget {
  final String title;
  final APIService apiService;

  HomePage({required this.title, required this.apiService});

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late Future<List<Article>> _tweetsFuture;

  @override
  void initState() {
    super.initState();
    _tweetsFuture = widget.apiService.getTweets();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        actions: [
          IconButton(
            icon:  const Icon(
              Icons.search,
            ),
            onPressed: () {
              Navigator.pushNamed(context, '/search'); // Navigate to the notifications page
            },
          ),
        ],
      ),
      body: Center(
        child: FutureBuilder<List<Article>>(
          future: _tweetsFuture,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const CircularProgressIndicator();
            } else if (snapshot.hasError) {
              return Text('Error: ${snapshot.error}');
            } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
              return Text('No tweets found');
            } else {
              return ListView.builder(
                itemCount: snapshot.data!.length,
                itemBuilder: (context, index) {
                  final tweet = snapshot.data![index];
                  return ListTile(
                    title: Text(tweet.name),
                    subtitle: Text(tweet.timestamp),
                  );
                },
              );
            }
          },
        ),
      ),
    );
  }
}*//*




import 'package:flutter/material.dart';
import 'package:retrievee/classes/article_detail_page.dart';
//import 'package:retrievee/show_article.dart';
import '../classes/article.dart';
import '../screens/custom_carousel_slider.dart';
import '../tweet_service.dart';

class HomePage extends StatefulWidget {
  final String title;
  final APIService apiService;

  HomePage({required this.title, required this.apiService});

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late Future<List<Article>> _tweetsFuture;
  */
/*bool _isSaved = false;
  bool _isLiked = false;*//*


  @override
  void initState() {
    super.initState();
    _tweetsFuture = widget.apiService.getTweets();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder<List<Article>>(
        future: _tweetsFuture,
        builder: (context, snapshot) {
          if (snapshot.hasData) {return SingleChildScrollView( // Wrap content in SingleChildScrollView
            child: Column(
              children: [
                CustomCarouselSlider(articles: snapshot.data!), // Add carousel here
                ListView.builder(
                  shrinkWrap: true, // Wrap list content
                  physics: const NeverScrollableScrollPhysics(), // Disable list scrolling
                  itemCount: snapshot.data!.length,
                  itemBuilder: (context, index) {
                    final article = snapshot.data![index];
                    return ListTile(
                      title: Text(article.username),
                      subtitle: Text(article.timestamp),
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => ArticleDetailPage(article: article),
                          ),
                        );
                      },
                    );
                  },
                ),
              ],
            ),
          );
          } else if (snapshot.hasError) {
            return Center(
              child: Text('Error: ${snapshot.error}'),
            );
          } else {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
    );
  }
}*/



import 'package:flutter/material.dart';
import 'package:retrievee/classes/article.dart';
import 'package:retrievee/classes/article_detail_page.dart';
import 'package:retrievee/screens/custom_carousel_slider.dart';
import 'package:retrievee/tweet_service.dart';

class HomePage extends StatefulWidget {
  final String title;
  final APIService apiService;

  HomePage({required this.title, required this.apiService});

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late Future<List<Article>> _tweetsFuture;
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _loadTweets();
  }

  Future<void> _loadTweets() async {
    setState(() {
      _isLoading = true;
    });
    _tweetsFuture = widget.apiService.getTweets();
    setState(() {
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: RefreshIndicator(
        onRefresh: _loadTweets,
        child: FutureBuilder<List<Article>>(
          future: _tweetsFuture,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else if (snapshot.hasError) {
              return Center(
                child: Text('Error: ${snapshot.error}'),
              );
            } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
              return const Center(
                child: Text('No tweets found'),
              );
            } else {
              return SingleChildScrollView(
                child: Column(
                  children: [
                    CustomCarouselSlider(articles: snapshot.data!),
                    ListView.builder(

                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: snapshot.data!.length,
                      itemBuilder: (context, index) {
                        final article = snapshot.data![index];

                        return ListTile(
                          title: Text(article.username),
                          subtitle: Text(article.timestamp),
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => ArticleDetailPage(article: article),
                              ),
                            );
                          },
                        );
                      },
                    ),
                  ],
                ),
              );
            }
          },
        ),
      ),
    );
  }
}
