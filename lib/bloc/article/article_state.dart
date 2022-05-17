
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:news_app/data/models/article_model.dart';

abstract class ArticleState extends Equatable {}

class ArticleInitialState extends ArticleState {
  @override
 
  List<Object> get props => [];
}

class ArticleLoadingState extends ArticleState {
  @override
  
  List<Object> get props => [];
}

class ArticleLoadedState extends ArticleState {

  List<Articles>? articles;

  ArticleLoadedState({@required this.articles});

  @override
  List<Object> get props => [articles??[]];
}

class AuthorLoadedState extends ArticleState {

  List<String>? authors;

  AuthorLoadedState({@required this.authors});

  @override
  List<Object> get props => [authors??[]];
}

class ArticleErrorState extends ArticleState {

  String? message;

  ArticleErrorState({@required this.message});

  @override
  List<Object> get props => [message??''];
}
