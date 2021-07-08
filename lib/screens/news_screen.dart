import 'package:flutter/material.dart';
import 'package:news_app/network/dio_helper.dart';
import 'package:news_app/statemanagement/brain.dart';
import 'package:provider/provider.dart';

class NewsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<Brain>(
      create: (ctx) => Brain(),
      child: Consumer<Brain>(
        builder: (ctx, Data, child) => Scaffold(
          appBar: AppBar(
            title: Text('News App'),
            actions: [
              IconButton(
                onPressed: () {},
                icon: Icon(
                  Icons.search,
                  color: Colors.deepOrange,
                ),
              ),
            ],
          ),
          bottomNavigationBar: BottomNavigationBar(
            currentIndex: Data.currentIndex,
            items: Data.bottomItems,
            onTap: Data.changeBottomNavigatonBar,
          ),
          body: Data.screens[Data.currentIndex],
          floatingActionButton: FloatingActionButton(
            onPressed: () async {},
            child: Icon(Icons.exposure_plus_1_sharp),
          ),
        ),
      ),
    );
  }
}
