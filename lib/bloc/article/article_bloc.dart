import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:news_app/bloc/article/article_event.dart';
import 'package:news_app/bloc/article/article_state.dart';
import 'package:news_app/data/models/article_model.dart';
import 'package:news_app/data/repository/article_repository.dart';

class ArticleBloc extends Bloc<ArticleEvent, ArticleState> {

  ArticleRepository? repository;

  ArticleBloc({@required this.repository}) : 
    assert(repository != null),
    super(ArticleInitialState()){

     on<FetchHeadlineEvent>((event, emit) async{
         emit(ArticleLoadingState());
             try {
                List<Articles>? articles = await repository!.getHeadlines();
                emit(ArticleLoadedState(articles: articles));
              } catch (e) {
                emit(ArticleErrorState(message: e.toString()));
              }
     });

 

     on<FetchNewsEvent>((event, emit) async{
         emit(ArticleLoadingState());
             try {
                List<Articles>? articles = await repository!.getNews();
                emit(ArticleLoadedState(articles: articles));
              } catch (e) {
                emit(ArticleErrorState(message: e.toString()));
              }
     });

    
    }

}