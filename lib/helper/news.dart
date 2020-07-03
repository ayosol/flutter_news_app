import 'dart:convert';

import 'package:flutter_news_app/models/article.dart';
import 'package:http/http.dart' as http;

class News {
  List<Article> news = [];

  Future<void> fetchNews() async {
    String url =
        "https://newsapi.org/v2/top-headlines?country=de&category=business&apiKey=f20381f7e7394deea008a15bddb819fa";
    var response = await http.get(url);
    var jsonData = jsonDecode(response.body);

    //Check if status is ok ad loop through all the articles from api
    if (jsonData['status'] == "ok") {
      jsonData["articles"].forEach((element) {
        //Check if the urlToImage and description is not null so as not to break code and also display image
        if (element["urlToImage"] != null && element["description"] != null) {
          Article article = Article(
              title: element["title"],
              author: element["author"],
              description: element["description"],
              url: element["url"],
              urlToImage: element["urlToImage"],
              publishedAt: element["publishedAt"],
              content: element["content"]);

          news.add(article);
        }
      });
    }
  }
}

class NewsCategory {
  List<Article> news = [];

  Future<void> fetchCategory(String category) async {
    String url =
        "https://newsapi.org/v2/top-headlines?country=us&category=$category&apiKey=f20381f7e7394deea008a15bddb819fa";
    var response = await http.get(url);
    var jsonData = jsonDecode(response.body);

    //Check if status is ok ad loop through all the articles from api
    if (jsonData['status'] == "ok") {
      jsonData["articles"].forEach((element) {
        //Check if the urlToImage and description is not null so as not to break code and also display image
        if (element["urlToImage"] != null && element["description"] != null) {
          Article article = Article(
              title: element["title"],
              author: element["author"],
              description: element["description"],
              url: element["url"],
              urlToImage: element["urlToImage"],
              publishedAt: element["publishedAt"],
              content: element["content"]);

          news.add(article);
        }
      });
    }
  }
}
