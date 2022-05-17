import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:news_app/bloc/article/article_bloc.dart';
import 'package:news_app/data/repository/article_repository.dart';
import 'package:news_app/ui/landing_page.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

Future main() async{
   await dotenv.load(fileName: ".env");
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({ Key? key }) : super(key: key);

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {

  Map<int, Color> color =
{
50:Color.fromRGBO(136,14,79, .1),
100:Color.fromRGBO(136,14,79, .2),
200:Color.fromRGBO(136,14,79, .3),
300:Color.fromRGBO(136,14,79, .4),
400:Color.fromRGBO(136,14,79, .5),
500:Color.fromRGBO(136,14,79, .6),
600:Color.fromRGBO(136,14,79, .7),
700:Color.fromRGBO(136,14,79, .8),
800:Color.fromRGBO(136,14,79, .9),
900:Color.fromRGBO(136,14,79, 1),
};


late MaterialColor colorCustom;

@override
  void initState() {
    colorCustom = MaterialColor(0xFF880E4F, color);
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'News App',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
          brightness: Brightness.dark,
      ),
       routes: {
              "/landing": (_) => LandingPage(),
            },
      home: BlocProvider(
       create: (context) => ArticleBloc(repository: ArticleRepositoryImpl()),
       child: LandingPage(),
     )
    );
  }
}