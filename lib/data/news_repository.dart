import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:news_app/models/article_data_model.dart';

class NewsRepository {
  Future<ArticleModel> fetchNews(
      {required int page, final int pageSize = 10}) async {
    try {
      var client = http.Client();

      var response = await client.get(Uri.parse(
          'https://newsapi.org/v2/everything?domains=techcrunch.com,thenextweb.com&apiKey=5260af115dd94db3afc09af726da14a0&page=$page&pageSize=$pageSize'));

      if (response.statusCode == 200) {
        return ArticleModel.fromJson(json.decode(response.body));
      } else if (response.statusCode == 404) {
        throw Exception('Data Not Found');
      } else if (response.body.contains('rateLimited')) {
        final Map<String, dynamic> res = jsonDecode(response.body);
        String errorMessage = res['message'];
        throw Exception(errorMessage);
      } else {
        throw Exception('Failed to load news');
      }
    } catch (e) {
      throw Exception('Failed to load news');
    }
  }
}
