import 'dart:io';

import 'package:flutter/material.dart';
import 'package:news_app/ui/favourite_news.dart';
import 'package:news_app/ui/headlines.dart';
import 'package:news_app/ui/news.dart';

class LandingPage extends StatefulWidget {

  @override
  _LandingPageState createState() => _LandingPageState();
}

class _LandingPageState extends State<LandingPage> {

  int _currentItem = 0;
  final _listWidgets = [
    Headlines(),
    News(),
    FavouriteNews()
  ];

  bool connected=false;


@override
  void initState() {
    _load();
    super.initState();
  }

  void _load() async{
  try {
            final result = await InternetAddress.lookup('google.com');
            if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
                connected = true;
            } else {
                connected = false;
            }
        } on SocketException catch(_) {
            connected = false;
        }

        setState(() {
          
        });


  }

  @override
  Widget build(BuildContext context) {
    return connected? Scaffold(
      appBar: AppBar(
        title: Text('News App',style: TextStyle(fontWeight: FontWeight.bold),),
      ),
      body: _listWidgets[_currentItem],
    bottomNavigationBar: BottomNavigationBar(
          items: <BottomNavigationBarItem>[
            BottomNavigationBarItem(
                icon: Icon(Icons.chrome_reader_mode_outlined),
                 label: 'Headlines'),
             BottomNavigationBarItem(
                icon: Icon(Icons.chrome_reader_mode),
                 label: 'News'),     
            BottomNavigationBarItem(
                icon: Icon(Icons.favorite_border),
                label: 'Favorit',
                activeIcon: Icon(Icons.favorite)
                ),
          ],
          currentIndex: _currentItem,
          onTap: _onItemTapped,
          fixedColor: Colors.cyan,
          backgroundColor: Colors.white12,
        ),
    ):Scaffold(
      body: SafeArea(
        child: Container(
           child: Column(
             crossAxisAlignment: CrossAxisAlignment.center,
             mainAxisAlignment: MainAxisAlignment.center,
             children: [
               Center(child: Text('There is no internet connection switch it on and check')),
               ElevatedButton(onPressed: (){
                 _load();
                 print('here');
               }, child: Text('Check Now'))
             ],
           ),
        ),
      ),
    );
  }
  

  _onItemTapped(int index) {
    setState(() {
      _currentItem = index;
    });
  }
}