import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:newsprovider/src/models/category_model.dart';
import 'package:newsprovider/src/models/news_models.dart';
import 'package:http/http.dart' as http;

const _URL_NEWS = 'https://newsapi.org/v2';
const _APIKEY = 'c743ec07acaa49de8ecd6210d65754d3';

class NewsService with ChangeNotifier {

  List<Article> headlines = [];
  String _selectedCategory = 'business';

  List<Category> categories = [
    Category(FontAwesomeIcons.building, 'business'),
    Category(FontAwesomeIcons.tv, 'entertainment'),
    Category(FontAwesomeIcons.addressCard, 'general'),
    Category(FontAwesomeIcons.headSideVirus, 'health'),
    Category(FontAwesomeIcons.vials, 'science'),
    Category(FontAwesomeIcons.volleyball, 'sports'),
    Category(FontAwesomeIcons.memory, 'technology'),
  ];

  Map<String, List<Article>> categoryArticle = {};

  NewsService() {
    getTopHeadline();
    categories.forEach((element) {
      categoryArticle[element.name] = [];
    });
  }

  String get selectedCategory => _selectedCategory;
  set selectedCategory( String valor ) {
    _selectedCategory = valor;
    getArticlesByCategory(valor);
    notifyListeners();
  }

  List<Article>? get getArticleSelected => categoryArticle[selectedCategory];

  getTopHeadline() async {

    const url = '$_URL_NEWS/top-headlines?apiKey=$_APIKEY&country=mx';
    final resp = await http.get(Uri.parse(url));

    final newsResponse = newsResponseFromJson( resp.body );

    headlines.addAll(newsResponse.articles);
    notifyListeners();
  }

  getArticlesByCategory( String category ) async {
    
    if ( categoryArticle[category]!.length > 0 ) {
      return categoryArticle[category];
    }

    final url = '$_URL_NEWS/top-headlines?apiKey=$_APIKEY&country=mx&category=$category';
    final resp = await http.get(Uri.parse(url));

    final newsResponse = newsResponseFromJson( resp.body );
    categoryArticle[category]?.addAll(newsResponse.articles);

    notifyListeners();
  }

}