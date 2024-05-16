import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:news_app/models/article_data_model.dart';

class NewsRepository {
  Future<ArticleModel> fetchNews({int page = 1}) async {
    try {
      var client = http.Client();
      var response = await client.get(Uri.parse(
          "https://newsapi.org/v2/everything?domains=techcrunch.com,thenextweb.com&apiKey=5260af115dd94db3afc09af726da14a0&page=$page"));
      if (response.statusCode == 200) {
        return ArticleModel.fromJson(json.decode(response.body));
      } else {
        throw Exception('Failed to load news');
      }
    } catch (e) {
      throw Exception('Failed to load news');
    }
  }
}
