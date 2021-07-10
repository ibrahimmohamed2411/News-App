import 'dart:io';

import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:news_app/network/remote/dio_helper.dart';
import 'package:news_app/statemanagement/brain.dart';
import 'package:provider/provider.dart';

class NewsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<Brain>(
      builder: (ctx, Data, child) => Scaffold(
        appBar: AppBar(
          title: Text('News App'),
          titleSpacing: 20,
          actions: [
            IconButton(
              onPressed: () {},
              icon: Icon(
                Icons.search,
                color: Theme.of(context).iconTheme.color,
              ),
            ),
            IconButton(
              onPressed: () async {
                AwesomeDialog(
                  dismissOnTouchOutside: false,
                  context: context,
                  dialogType: DialogType.WARNING,
                  animType: AnimType.SCALE,
                  title: 'Restart Required !',
                  desc: 'Press yes to save changes and restart the app',
                  btnCancelOnPress: () {},
                  btnOkOnPress: () {
                    Provider.of<Brain>(context, listen: false).changeTheme();
                    exit(0);
                  },
                )..show();
              },
              icon: Icon(
                Provider.of<Brain>(context).isDark
                    ? Icons.dark_mode
                    : Icons.brightness_4,
                color: Theme.of(context).iconTheme.color,
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
      ),
    );
  }
}
