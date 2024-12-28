import 'package:flutter/material.dart';
import 'mainpage.dart';
void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) => MaterialApp(
    debugShowCheckedModeBanner: false,
    theme: ThemeData(
      appBarTheme: const AppBarTheme(color: Colors.blue),
    ),
    home: MainPage(),
  );
}


 
//  In the code above, we have a simple Flutter app that fetches the title of a webpage using the  http  package and the  html  package. 
//  The  getWebsiteData  method sends an HTTP GET request to the Amazon website and extracts the page title using the  html  package. 
//  The  initState  method calls the  getWebsiteData  method when the app starts. 
//  The  build  method displays the title of the webpage in the app. 
//  Run the app and you should see the title of the Amazon webpage displayed in the app. 
//  Conclusion 
//  In this tutorial, we have seen how to scrape a website in Flutter using the  http  package and the  html  package. 
//  We have also seen how to extract data from a webpage and display it in a Flutter app. 
//  You can use the same approach to scrape other websites and extract different types of data. 
//  Happy coding! 
//  Peer Review Contributions by:  Lalit Kumar 