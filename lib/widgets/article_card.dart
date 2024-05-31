import 'package:flutter/material.dart';
import 'package:news_app/models/article_data_model.dart';

class CustomArticleCard extends StatelessWidget {
  final Articles article;

  const CustomArticleCard({Key? key, required this.article}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        boxShadow: const [
          BoxShadow(
            blurRadius: 1,
            color: Colors.grey,
            offset: Offset(0, 2),
            spreadRadius: 1,
          ),
        ],
      ),
      margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 100,
            height: 100,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.only(
                topLeft: const Radius.circular(10),
                bottomLeft: const Radius.circular(10),
              ),
              image: DecorationImage(
                image: NetworkImage(article.urlToImage ?? ''),
                fit: BoxFit.cover,
              ),
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                article.title ?? "No Data",
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
                maxLines: 3,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
