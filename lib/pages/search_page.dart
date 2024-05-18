/*
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:democodes/classes/article.dart';
class SearchPage extends StatefulWidget {
  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  final TextEditingController _searchController = TextEditingController();
  List<Article> _newsList = [];

  // Future<void> _fetchNews(String query) async {
  //   if (query.isEmpty) return; // Handle empty query
  //
  //   String apiUrl = 'http://10.0.2.2:8000/hashtag_tweets?hashtag=$query&max_tweets=2';
  //
  //   try {
  //     var response = await http.get(Uri.parse(apiUrl));
  //     if (response.statusCode == 200) {
  //       // Decode the JSON data
  //       Map<String, dynamic> responseData = jsonDecode(response.body);
  //       // print(responseData["Name"]);
  //
  //       // Check if the decoded data contains a key called "Name"
  //       if (responseData.containsKey("Name")) {
  //         print("========================================================IF");
  //         // Retrieve the list of tweets
  //         print(responseData["Name"]);
  //         List<dynamic> tweetsData = responseData["Name"];
  //         print(tweetsData);
  //
  //         // Convert the list of tweets to a list of News objects
  //         List<News> newsList = tweetsData.map((tweet) => News.fromJson(tweet)).toList();
  //
  //         // Update the _newsList variable with the list of News objects
  //         setState(() {
  //           _newsList = newsList;
  //         });
  //       } else {
  //         // Handle error when "tweets" key is not present
  //         print('Error: Tweets key not found in response');
  //       }
  //     } else {
  //       // Handle API error
  //       print('Error: ${response.statusCode}');
  //       // You can display an error message to the user here
  //     }
  //   } catch (e) {
  //     // Handle network error
  //     print('Error: $e');
  //     // You can display an error message to the user here
  //   }
  // }
  Future<void> _fetchNews(String query) async {
    if (query.isEmpty) return; // Handle empty query

    String apiUrl = 'http://10.0.2.2:8000/hashtag_tweets?hashtag=$query&max_tweets=2';

    try {
      var response = await http.get(Uri.parse(apiUrl));
      if (response.statusCode == 200) {
        // Decode the JSON data
        Map<String, dynamic> responseData = jsonDecode(response.body);

        // Transform the structured data into a list of individual tweet objects
        List<Map<String, dynamic>> tweetsData = [];
        int tweetCount = responseData["Name"]?.length ?? 0;
        for (int i = 0; i < tweetCount; i++) {
          Map<String, dynamic> tweetData = {
            "Name": responseData["Name"][i],
            "Username": responseData["Username"][i],
            "Timestamp": responseData["Timestamp"][i],
            "Verified": responseData["Verified"][i],
            "Content": responseData["Content"][i],
            "Comments": responseData["Comments"][i],
            "Retweets": responseData["Retweets"][i],
            "Likes": responseData["Likes"][i],
            "Analytics": responseData["Analytics"][i],
            "Profile Image": responseData["Profile Image"][i],
            "Tweet Link": responseData["Tweet Link"][i],
            "Tweet ID": responseData["Tweet ID"][i],
          };
          tweetsData.add(tweetData);
        }

        // Convert the list of tweets to a list of News objects
        List<Article> newsList = tweetsData.map((tweet) => Article.fromJson(tweet)).toList();

        // Update the _newsList variable with the list of News objects
        setState(() {
          _newsList = newsList;
        });
      } else {
        // Handle API error
        print('Error: ${response.statusCode}');
      }
    } catch (e) {
      // Handle network error
      print('Error: $e');
    }
  }

  Widget _buildNewsList() {
    return ListView.builder(
      itemCount: _newsList.length,
      itemBuilder: (BuildContext context, int index) {
        Article news = _newsList[index];
        return ListTile(
          leading: CircleAvatar(
            backgroundImage: NetworkImage(news.profileImage),
          ),
          title: Text(news.name),
          subtitle: Row(
            children: [
              // hon fike tghayre bl design wl esem w kaza
              //msln .username 3am jibo mn class News:
              // fine zid text hl2 badal esem 7ot l content li ketbo heda
              // fhemte kelshi? : yes:) ok 7a sakker lakan, if you need any help ehke shaaben ana 3al sama3
              //  allah yaatik l aafyi ; anytime
              Text(news.username),
              // make the content only 1 and a half line if possible
              // Text(news.username),
              const SizedBox(width: 8.0),
              Text(
                news.timestamp,
                //i possible make the time on the third line
                style: const TextStyle(fontSize: 12.0, color: Colors.grey),
              ),
            ],
          ),
          contentPadding: const EdgeInsets.symmetric(vertical: 8.0),
          trailing: const Icon(Icons.more_vert),
          onTap: () {
            // Handle on tapping a news item (optional)
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Local News Search'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _searchController,
                    decoration: const InputDecoration(
                      labelText: 'Enter your search query (e.g., #localnews)',
                    ),
                  ),
                ),
                const SizedBox(width: 8.0),
                ElevatedButton(
                  onPressed: () {
                    String query = _searchController.text;
                    _fetchNews(query);
                  },
                  child: const Text('Search'),
                ),
              ],
            ),
            const SizedBox(height: 16.0),
            Expanded(
              child: _newsList.isEmpty
                  ? const Center(child: Text('Search for local news'))
                  : _buildNewsList(),
            ),
          ],
        ),
      ),
    );
  }
}*/


import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../classes/article.dart';

class SearchPage extends StatefulWidget {
  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  final TextEditingController _searchController = TextEditingController();
  List<Article> _newsList = [];

  Future<void> _fetchNews(String query) async {
    if (query.isEmpty) return; // Handle empty query

    String apiUrl = 'http://10.0.2.2:8000/hashtag_tweets?hashtag=$query&max_tweets=2';

    try {
      var response = await http.get(Uri.parse(apiUrl));
      if (response.statusCode == 200) {
        // Decode the JSON data
        Map<String, dynamic> responseData = jsonDecode(response.body);

        // Print the response data for debugging
        print('Response Data: $responseData');

        // Transform the structured data into a list of individual tweet objects
        List<Map<String, dynamic>> tweetsData = [];
        int tweetCount = responseData["Name"]?.length ?? 0;
        for (int i = 0; i < tweetCount; i++) {
          Map<String, dynamic> tweetData = {
            "Name": responseData["Name"][i],
            "Username": responseData["Username"][i],
            "Timestamp": responseData["Timestamp"][i],
            "Verified": responseData["Verified"][i],
            "Content": responseData["Content"][i],
            "Comments": responseData["Comments"][i],
            "Retweets": responseData["Retweets"][i],
            "Likes": responseData["Likes"][i],
            "Analytics": responseData["Analytics"][i],
            "Profile Image": responseData["Profile Image"][i],
            "Tweet Link": responseData["Tweet Link"][i],
            "Tweet Image": responseData["Tweet Image"][i],
          };
          tweetsData.add(tweetData);
        }

        // Print the tweets data for debugging
        print('Tweets Data: $tweetsData');

        // Convert the list of tweets to a list of Article objects
        List<Article> newsList = tweetsData.map((tweet) => Article.fromJson(tweet)).toList();

        // Update the _newsList variable with the list of Article objects
        setState(() {
          _newsList = newsList;
        });
      } else {
        // Handle API error
        print('Error: ${response.statusCode}');
      }
    } catch (e) {
      // Handle network error
      print('Error: $e');
    }
  }

  Widget _buildNewsList() {
    return ListView.builder(
      itemCount: _newsList.length,
      itemBuilder: (BuildContext context, int index) {
        Article news = _newsList[index];
        return ListTile(
          leading: CircleAvatar(
            backgroundImage: NetworkImage(news.profileImage),
          ),
          title: Text(news.name),
          subtitle: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(news.username),
              Text(
                news.timestamp,
                style: const TextStyle(fontSize: 12.0, color: Colors.grey),
              ),
              // Add content if needed
              Text(news.content, maxLines: 1, overflow: TextOverflow.ellipsis),
            ],
          ),
          contentPadding: const EdgeInsets.symmetric(vertical: 8.0),
          trailing: const Icon(Icons.more_vert),
          onTap: () {
            // Handle on tapping a news item (optional)
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Local News Search'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _searchController,
                    decoration: const InputDecoration(
                      labelText: 'Enter your search query (e.g., #localnews)',
                    ),
                  ),
                ),
                const SizedBox(width: 8.0),
                ElevatedButton(
                  onPressed: () {
                    String query = _searchController.text;
                    _fetchNews(query);
                  },
                  child: const Text('Search'),
                ),
              ],
            ),
            const SizedBox(height: 16.0),
            Expanded(
              child: _newsList.isEmpty
                  ? const Center(child: Text('Search for local news'))
                  : _buildNewsList(),
            ),
          ],
        ),
      ),
    );
  }
}

