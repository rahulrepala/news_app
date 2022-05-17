import 'package:equatable/equatable.dart';

abstract class ArticleEvent extends Equatable{}

class FetchHeadlineEvent extends ArticleEvent {
  @override
  // TODO: implement props
  List<Object> get props => <Object>[];
}

// class FetchHeadlineAuthors extends ArticleEvent {
//   @override
//   // TODO: implement props
//   List<Object> get props => <Object>[];
// }

class FetchNewsEvent extends ArticleEvent {
  @override
  // TODO: implement props
  List<Object> get props => <Object>[];
}

// class FetchNewsAuthors extends ArticleEvent {
//   @override
//   // TODO: implement props
//   List<Object> get props => <Object>[];
// }