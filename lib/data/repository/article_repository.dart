import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:news_app/data/models/article_model.dart';


abstract class ArticleRepository {
  Future<List<Articles>> getNews();
  Future<List<Articles>> getHeadlines();
}

class ArticleRepositoryImpl implements ArticleRepository {
  String baseUrl =dotenv.env['BASE_URL']??'';
  String apiKey =dotenv.env['API_KEY']??'';

  @override
  Future<List<Articles>> getNews() async {

    var newsUrl = baseUrl+'everything?q=bitcoin&apiKey='+apiKey;
    
    var response = await http.get(Uri.parse(newsUrl));
    if (response.statusCode == 200) {
      var data = json.decode(response.body);
      List<Articles>? articles = ApiResultModel.fromJson(data).articles;
      return articles!;
    } else {
      throw Exception();
    }
  }

  @override
  Future<List<Articles>> getHeadlines() async {

    var headlinesUrl = baseUrl+'top-headlines?country=us&apiKey='+apiKey;
    
    var response = await http.get(Uri.parse(headlinesUrl));
    if (response.statusCode == 200) {
      var data = json.decode(response.body);
      List<Articles>? articles = ApiResultModel.fromJson(data).articles;
      return articles!;
    } else {
      throw Exception();
    }
  }

}