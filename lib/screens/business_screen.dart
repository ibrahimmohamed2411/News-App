import 'package:flutter/material.dart';
import 'package:news_app/components/custom_news_item.dart';
import 'package:news_app/statemanagement/brain.dart';
import 'package:provider/provider.dart';

class BusinessScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future:
          Provider.of<Brain>(context, listen: false).getData(Category.business),
      builder: (ctx, snapshot) {
        if (snapshot.hasError) {
          return Center(child: Text('Error'));
        }
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        }
        if (snapshot.hasData) {
          return Consumer<Brain>(
            builder: (ctx, Data, ch) => ListView.separated(
              itemBuilder: (ctx, index) => CustomNewsItem(
                date: Data.business[index]['publishedAt'],
                title: Data.business[index]['title'],
                urlToImage:
                    Data.business[index]['urlToImage'] ?? Brain.notFoundImage,
                url: Data.business[index]['url'],
              ),
              itemCount: Data.business.length,
              separatorBuilder: (BuildContext context, int index) => Divider(
                height: 5,
                color: Colors.grey,
              ),
            ),
          );
        }
        return Center(child: Text('UnKnown Error'));
      },
    );
  }
}
