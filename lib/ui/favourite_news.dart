
import 'package:flutter/material.dart';
import 'package:news_app/data/models/article_model.dart';
import 'package:news_app/database/repository.dart';
import 'package:news_app/utils/news_card.dart';

class FavouriteNews extends StatefulWidget {
  const FavouriteNews({ Key? key }) : super(key: key);

  @override
  _FavouriteNewsState createState() => _FavouriteNewsState();
}

class _FavouriteNewsState extends State<FavouriteNews> {

  List<Articles> articles=[];
  final Repository _repository=Repository();
  bool fetched=false;
   
  @override
  void initState() {
     _load();
    super.initState();
  }

  void _load() async{
   
   var ac=  await _repository.getAllData('Articles');
   for(int i=0;i<ac.length;i++){
      articles.add(Articles().articleToObject(ac[i]));
   }  
   print(ac);
   fetched=true;
  
    setState(() {
      
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child:fetched?( articles.length>0? ListView.builder(
          itemCount: articles.length,
          itemBuilder: (context,index){
          return NewsCard(
            title: articles[index].title,
            img: articles[index].urlToImage, 
            viewUrl: articles[index].url,
            article: articles[index],
            type: 'fav',
            );
         }):Container(child: Center(child: Text('Your favorites are empty')),)):Container(child: Center(child: Text('Loading..')),),
      ),
    );
  }
}