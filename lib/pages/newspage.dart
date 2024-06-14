import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../provider/news_provider.dart';

class NewsPage extends StatefulWidget {
  @override
  _NewsPageState createState() => _NewsPageState();
}

class _NewsPageState extends State<NewsPage> {
  List articles = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    fetchNews();
  }

  fetchNews() async {
    final response = await http.get(Uri.parse('https://newsapi.org/v2/top-headlines?country=us&apiKey=4fa611c03d0545e09a55f335b45328ae'));

    if (response.statusCode == 200) {
      final Map result = json.decode(response.body);
      setState(() {
        articles = result['articles'];
        isLoading = false;
      });
    } else {
      throw Exception('Failed to load news');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('News'),
        actions: [
          IconButton(
            icon: Icon(Icons.bookmark),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => SavedArticlesPage()),
              );
            },
          ),
        ],
      ),
      body: isLoading
          ? Center(child: CircularProgressIndicator())
          : ListView.builder(
        itemCount: articles.length,
        itemBuilder: (context, index) {
          return NewsCard(article: articles[index]);
        },
      ),
    );
  }
}

class NewsCard extends StatelessWidget {
  final article;

  NewsCard({@required this.article});

  @override
  Widget build(BuildContext context) {
    var savedArticlesProvider = Provider.of<NewsProvider>(context, listen: false);

    return Card(
      margin: EdgeInsets.all(10.0),
      child: InkWell(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => NewsDetailPage(article: article),
            ),
          );
        },
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (article['urlToImage'] != null)
              Image.network(article['urlToImage']),
            Padding(
              padding: EdgeInsets.all(10.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    article['title'],
                    style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 10.0),
                  Text(
                    article['description'] ?? 'No description available',
                    style: TextStyle(color: Colors.grey[700]),
                  ),
                  SizedBox(height: 10.0),
                  IconButton(
                    icon: Icon(Icons.bookmark),
                    onPressed: () {
                      savedArticlesProvider.addArticle(article);
                      ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text('Article saved!'))
                      );
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class NewsDetailPage extends StatelessWidget {
  final article;

  NewsDetailPage({@required this.article});

  @override
  Widget build(BuildContext context) {
    var savedArticlesProvider = Provider.of<NewsProvider>(context, listen: false);

    return Scaffold(
      appBar: AppBar(
        title: Text(article['title']),
        actions: [
          IconButton(
            icon: Icon(Icons.bookmark),
            onPressed: () {
              savedArticlesProvider.addArticle(article);
              ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('Article saved!'))
              );
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (article['urlToImage'] != null)
                Image.network(article['urlToImage']),
              SizedBox(height: 16.0),
              Text(
                article['title'],
                style: TextStyle(fontSize: 24.0, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 8.0),
              Text(
                article['description'] ?? 'No description available',
                style: TextStyle(fontSize: 16.0, color: Colors.grey[700]),
              ),
              SizedBox(height: 16.0),
              Text(article['content'] ?? 'No content available'),
            ],
          ),
        ),
      ),
    );
  }
}

class SavedArticlesPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var savedArticlesProvider = Provider.of<NewsProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text('Saved Articles'),
      ),
      body: ListView.builder(
        itemCount: savedArticlesProvider.savedArticles.length,
        itemBuilder: (context, index) {
          return NewsCard(article: savedArticlesProvider.savedArticles[index]);
        },
      ),
    );
  }
}
