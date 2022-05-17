
import 'package:flutter/material.dart';
import 'package:news_app/bloc/article/article_bloc.dart';
import 'package:news_app/bloc/article/article_event.dart';
import 'package:news_app/bloc/article/article_state.dart';
import 'package:news_app/data/models/article_model.dart';
import 'package:news_app/ui/news_view.dart';
import 'package:news_app/utils/news_card.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class Headlines extends StatefulWidget {
  const Headlines({ Key? key }) : super(key: key);

  @override
  _HeadlinesState createState() => _HeadlinesState();
}

 List selectedAuthor=[];
 List author=[];
 
class _HeadlinesState extends State<Headlines> {


  late ArticleBloc articleBloc;
 
  TextEditingController search=TextEditingController();
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  @override
  void initState() {
   
    articleBloc = BlocProvider.of<ArticleBloc>(this.context);
    articleBloc.add(FetchHeadlineEvent());
    super.initState();
  }




  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      endDrawer: Drawer(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: ListView(
            children: [
              Padding(
                padding: const EdgeInsets.only(left:12.0),
                child: Text('Filter by Author',style: TextStyle(fontSize: 20),),
              ),
        
           Container(
            height: MediaQuery.of(context).size.height-50,
             child: BlocListener<ArticleBloc, ArticleState>(
               listener: (context, state) {
                 if (state is ArticleErrorState) {
                   ScaffoldMessenger.of(context).showSnackBar(
                     SnackBar(content: Text(state.message??'')));
                  
                 }
               },
               child: BlocBuilder<ArticleBloc, ArticleState>(
                 builder: (context, state) {
               
                   if (state is ArticleInitialState) {
          
                     return buildLoading();
                   } else if (state is ArticleLoadingState) {
                     
                     return buildLoading();
                   } else if (state is ArticleLoadedState) {
                    
                     return ListView.builder(
                        shrinkWrap: true,
                        itemCount: state.articles?.length,
                        physics: NeverScrollableScrollPhysics(),
                        itemBuilder: (context,index){
                          if(index==0)author=[];
                         
                            if(state.articles![index].author!=null && state.articles![index].author!='' && !author.contains(state.articles![index].author)){
                              author.add(state.articles![index].author);
                              return CheckboxListTile(
                            value: selectedAuthor.contains(state.articles![index].author), 
                            onChanged: (val){
                              if(!selectedAuthor.contains(state.articles![index].author)){
                                  selectedAuthor.add(state.articles![index].author);
                              }else{
                                selectedAuthor.remove(state.articles![index].author);
                              }
                              setState(() {
                                
                              });
                          
                    },
                    title: Text(state.articles![index].author??''),
                  );
                               
                            }else{
                              return Container();
                            }                    
                          
              
                });
                   } else if (state is ArticleErrorState) {
                     return buildErrorUi(state.message??'');
                   } else{
                     return Container();
                   }
                 },
               ),
             ),
           ),
            

            ],
          ),
        ),
      ),
     body: Container(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Container(
              height: 60,
              child: Row(
                children: [
                    SizedBox(
                      width: MediaQuery.of(context).size.width-65,
                      child: TextField(
                        controller: search,
                        decoration: InputDecoration(
                           border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(8),
                            ),
                          suffixIcon:Icon(Icons.search),
                        ),
                        onChanged: (e){
                          setState(() {
                            
                          });
                        },
                      ),
                    ),
                    Spacer(),
                    IconButton(onPressed: ()=>_scaffoldKey.currentState!.openEndDrawer(), icon: Icon(Icons.filter_alt_outlined,size: 35,))
                ],
              ),
            ),
            Container(
                height: MediaQuery.of(context).size.height-280,
                child: BlocListener<ArticleBloc, ArticleState>(
                  listener: (context, state) {
                    if (state is ArticleErrorState) {
                       ScaffoldMessenger.of(context).showSnackBar(
                     SnackBar(content: Text(state.message??'')));
                      
                    }
                  },
                  child: BlocBuilder<ArticleBloc, ArticleState>(
                    builder: (context, state) {
                      if (state is ArticleInitialState) {
                        return buildLoading();
                      } else if (state is ArticleLoadingState) {
                        return buildLoading();
                      } else if (state is ArticleLoadedState) {
                        return buildArticleList(state.articles??[],context,search);
                      } else if (state is ArticleErrorState) {
                        return buildErrorUi(state.message??'');
                      } else{
                        return Container();
                      }
                    },
                  ),
                ),
              ),
            
            
            
          ],
        ),
      ),
    ),
    );
  
  }
}
 Widget buildLoading() {
    return Center(
      child: CircularProgressIndicator(),
    );
  }

  Widget buildErrorUi(String message) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Text(
          message,
          style: TextStyle(color: Colors.red),
        ),
      ),
    );
  }

  

  Widget buildArticleList(List<Articles> articles,BuildContext context,TextEditingController search) {
    return ListView.builder(
      itemCount: articles.length,
      itemBuilder: (ctx, pos) {
        
        return 
                selectedAuthor.length>0? 
                  selectedAuthor.contains(articles[pos].author.toString())?
                  NewsCard(
                      title: articles[pos].title??'',
                      img: articles[pos].urlToImage??'', 
                      viewUrl: articles[pos].url??'',
                      article: articles[pos],
                      type: 'headlines',
                    ):Container()
                  //search
                  :
        articles[pos].title.toString().contains(search.text)?NewsCard(
            title: articles[pos].title??'',
            img: articles[pos].urlToImage??'', 
            viewUrl: articles[pos].url??'',
            article: articles[pos],
            type: 'headlines',
         ):Container();
      },
    );
  }