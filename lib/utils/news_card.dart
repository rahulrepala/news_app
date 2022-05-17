import 'package:flutter/material.dart';
import 'package:news_app/database/repository.dart';
import 'package:news_app/ui/news_view.dart';
import 'package:cached_network_image/cached_network_image.dart';

import 'package:news_app/data/models/article_model.dart';

class NewsCard extends StatelessWidget {
  final String? title;
  final String? img;
  final String? viewUrl;
  final Articles? article;
  final String? type;

  const NewsCard({@required this.title,@required this.img,@required this.viewUrl,@required this.article,@required this.type});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        if(this.viewUrl!=null && this.viewUrl!=''){
          Navigator.push(context, MaterialPageRoute(builder: (context)=>NewsView(this.viewUrl??'')));
        }
      },
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
             children: [
              Container(
                height: 140,
                child: CachedNetworkImage(
                     imageUrl: this.img??'',
                     imageBuilder: (context, imageProvider) => Container(
                       decoration: BoxDecoration(
                        image: DecorationImage(
                        image: imageProvider,
                        fit: BoxFit.cover,
                     ),
                   ),
                 ),
                placeholder: (context, url) => SizedBox(
                  height: 25,
                  width: 25,
                  child: CircularProgressIndicator()),
                errorWidget: (context, url, error) => Icon(Icons.error),
              ),),
              SizedBox(height: 12,),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    width: MediaQuery.of(context).size.width*0.7,
                    child: Text(title??'')),
                 IconButton(onPressed: () async{
                   // if it is not in fav then only below will execute
                   
                  if(type!='fav'){
 
                   final Repository _repository=Repository();
                   bool n= await _repository.articleExists('Articles', this.article!.publishedAt??'');
                   print(n);
                   if(!n){
                     dynamic result= await _repository.insertData('Articles', this.article!.toJson());
                      if(result==0){
                        ScaffoldMessenger.of(context).showSnackBar(
                             SnackBar(content: Text('Something went wrong')));
                      }else{
                         ScaffoldMessenger.of(context).showSnackBar(
                             SnackBar(content: Text('Added to favourites')));
                      }
                   }else{
                    
           
                     ScaffoldMessenger.of(context).showSnackBar(
                             SnackBar(content: Text('Already in your favourites')));

                   }
                   
                   }
                 }, icon: Icon(type!='fav'?Icons.favorite_border:Icons.favorite))
                ],
              ),
             ],
          ),
        ),
      ),
    );
  }
}