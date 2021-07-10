import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:news_app/components/custom_news_item.dart';
import 'package:news_app/statemanagement/brain.dart';
import 'package:provider/provider.dart';

class SearchScreen extends StatelessWidget {
  var searchController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: TextFormField(
                validator: (String? value) {
                  if (value!.isEmpty) return;
                },
                controller: searchController,
                decoration: InputDecoration(
                  labelText: 'Search',
                  contentPadding: EdgeInsets.all(8),
                  prefixIcon: Icon(Icons.search),
                ),
                keyboardType: TextInputType.text,
                onChanged: (value) async {
                  await Provider.of<Brain>(context, listen: false)
                      .getSearch(value);
                },
              ),
            ),
            Expanded(
              child: Consumer<Brain>(
                builder: (ctx, Data, child) => ListView.builder(
                  itemCount: Data.search.length,
                  itemBuilder: (ctx, index) => CustomNewsItem(
                      url: Data.search[index]['url'],
                      date: Data.search[index]['publishedAt'],
                      title: Data.search[index]['title'],
                      urlToImage: Data.search[index]['urlToImage']),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
