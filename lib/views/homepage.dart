import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_news_app/helper/data.dart';
import 'package:flutter_news_app/helper/news.dart';
import 'package:flutter_news_app/models/article.dart';
import 'package:flutter_news_app/models/category_model.dart';
import 'package:flutter_news_app/views/article_view.dart';
import 'package:flutter_news_app/views/category_news.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<CategoryModel> categories = new List<CategoryModel>();
  List<Article> articles = new List<Article>();
  bool _loading = true;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    categories = getCategories();
    getNews();
  }

  void getNews() async {
    News newsClass = News();
    await newsClass.fetchNews();
    articles = newsClass.news;
    setState(() {
      _loading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          mainAxisAlignment:
              MainAxisAlignment.center, //To center the object in the row
          children: <Widget>[
            Text(
              "News",
              style: TextStyle(color: Colors.blue),
            ),
            Text(
              "App",
              style: TextStyle(color: Colors.black),
            )
          ],
        ),
        centerTitle: true,
        elevation: 0.0,
      ),
      body: _loading
          ? Center(child: Container(child: CircularProgressIndicator()))
          : SingleChildScrollView(
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 16),
                child: Column(
                  children: <Widget>[
                    ///Categories
                    Container(
                      height: 70,
                      child: ListView.builder(
                          itemCount: categories.length,
                          shrinkWrap: true,
                          scrollDirection: Axis.horizontal,
                          itemBuilder: (context, index) {
                            //return the CategoryTile for the categories with category data
                            return CategoryTile(
                              imageUrl: categories[index].imageUrl,
                              categoryName: categories[index].categoryName,
                            );
                          }),
                    ),

                    ///News Article
                    Container(
                      child: Column(
                        children: <Widget>[
                          Container(
                              padding: EdgeInsets.only(top: 1),
                              child: ListView.builder(
                                itemCount: articles.length,
                                shrinkWrap: true,
                                physics: ClampingScrollPhysics(),
                                itemBuilder: (context, index) {
                                  return NewsTile(
                                      imageUrl: articles[index].urlToImage,
                                      title: articles[index].title,
                                      desc: articles[index].description,
                                      url: articles[index].url);
                                },
                              )),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
    );
  }
}

///Tiles for the Category Cards at the top of the App
class CategoryTile extends StatelessWidget {
  final String imageUrl, categoryName;

  CategoryTile({this.imageUrl, this.categoryName});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => CategoryNews(
                      category: categoryName.toString().toLowerCase(),
                    )));
      },
      child: Container(
        margin: EdgeInsets.only(right: 16),
        child: Stack(children: <Widget>[
          ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: CachedNetworkImage(
              imageUrl: imageUrl,
              width: 120,
              height: 60,
              fit: BoxFit.cover,
            ),
          ), // The Images are gotten directly from the network
          Container(
            //Container for Text in CategoryTile aligned in center
            alignment: Alignment.center,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(6),
              color: Colors.black26,
            ),
            width: 120,
            height: 60,
            child: Text(
              categoryName,
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 14,
                  fontWeight: FontWeight.w500),
            ),
          )
        ]),
      ),
    );
  }
}

///Tiles for the News Cards
class NewsTile extends StatelessWidget {
  final String imageUrl, title, desc, url;

  NewsTile(
      {@required this.imageUrl,
      @required this.title,
      @required this.desc,
      @required this.url});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => ArticleView(
                      newsUrl: url,
                    )));
      },
      child: Container(
        margin: EdgeInsets.only(bottom: 16),
        child: Column(
          children: <Widget>[
            ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: Image.network(imageUrl)),
            SizedBox(height: 8),
            Text(
              title,
              style: TextStyle(
                  fontSize: 18,
                  color: Colors.black87,
                  fontWeight: FontWeight.w500),
            ),
            SizedBox(height: 8),
            Text(desc, style: TextStyle(color: Colors.black54))
          ],
        ),
      ),
    );
  }
}
