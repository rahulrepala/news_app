# news_app
an app for showing latest news using apis from the website- https://newsapi.org/

used two apis-
1. eveything api (https://newsapi.org/docs/endpoints/everything) for showing all news
2. headlines api (https://newsapi.org/docs/endpoints/top-headlines) for showing top-headlines

Features-

checks internet connection.

filter option - we can choose only articles written by particular author

search option - shows news with particular title which is entered in search textfield

favourites - we can save news to to view it later. there is a seperate tab you can see saved articles over there.

How favourites work -

you need to click on ❤️ symbol it will be saved to your local db. 
if you are again clicking the ❤️ symbol it says it is already saved.
now you can see your saved news in your favourites tab

Internet Connection-

Checks wether app is connected to internet or not. 
if it is not connected to internet it asks for switchiting it on. 
after switching on internet click 'Check Now' button to check connectivity. 
if connection is proper it will load the app.


Technologies used-

Sqflite - for storing locally

flutter_bloc - for statemanagement

flutter_dotenv - for storing environment variables.

webview_flutter - for showing the whole article.




