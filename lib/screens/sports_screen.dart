import 'package:flutter/material.dart';
import 'package:news_app/components/custom_news_item.dart';
import 'package:news_app/statemanagement/brain.dart';
import 'package:provider/provider.dart';

class SportsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<Brain>(context, listen: false);
    return FutureBuilder(
      future:
          Provider.of<Brain>(context, listen: false).getData(Category.sports),
      builder: (ctx, snapshot) {
        if (snapshot.hasError) {
          return Center(child: Text('Error'));
        }
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        }
        if (snapshot.hasData) {
          return ListView.separated(
            itemBuilder: (ctx, index) => CustomNewsItem(
              url: provider.business[index]['url'],
              date: provider.sports[index]['publishedAt'],
              title: provider.sports[index]['title'],
              urlToImage:
                  provider.sports[index]['urlToImage'] ?? Brain.notFoundImage,
            ),
            itemCount: provider.sports.length,
            separatorBuilder: (BuildContext context, int index) => Divider(
              height: 5,
              color: Colors.grey,
            ),
          );
        }
        return Center(child: Text('UnKnown Error'));
      },
    );
  }
}
