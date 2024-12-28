import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:html/dom.dart' as dom;
import 'articles.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  String title = 'Web Scraping';
  List<Article> articles = [];

  @override
  void initState() {
    super.initState();
    // Call the asynchronous method to fetch data when the app starts.
    getWebsiteData();
  }

  Future<void> getWebsiteData() async {
    final url = Uri.parse('https://www.amazon.com/s?k=iphone');
    
    try {
      final response = await http.get(url, headers: {
      'User-Agent': 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/91.0.4472.124 Safari/537.36',
      'Accept-Language': 'en-US,en;q=0.9',
      'Accept-Encoding': 'gzip, deflate, br',
      'Connection': 'keep-alive',
      'Upgrade-Insecure-Requests': '1',
      'Cache-Control': 'max-age=0',
      // 'Referer': 'https://www.amazon.com/', // Add a referer header
    });

      if (response.statusCode == 200) {
        // Parse the response body to extract the page title
        dom.Document html = dom.Document.html(response.body);
        final titles = html
        .querySelectorAll('a > h2 > span')
        .map((element) => element.innerHtml.trim())
        .toList();

        final imgs = html
        .querySelectorAll('span > a > div > img')
        .map((element) => element.attributes['src']!)
        .toList();

        // Use setState to update the UI after data is fetched
        setState(() {
          articles = List.generate(titles.length, (index) => Article(
            title: titles[index],
            img: imgs[index],
          ),
          );
        });
        
        
      } else {
        // Handle the case where the HTTP request fails
        throw Exception('Failed to load website: ${response.statusCode}');
      }
    } catch (e) {
      // Catch any errors, such as network issues or HTML parsing errors
      debugPrint('Error fetching website: $e');
      setState(() {
        title = 'Error: Unable to fetch data';
      });
    }
  }

  @override
  Widget build(BuildContext context) => Scaffold(
    appBar: AppBar(
      title: const Text('Web Scraping'),
      centerTitle: true,
    ),
    backgroundColor: Colors.yellowAccent,
    body: ListView.separated(
      padding: const EdgeInsets.all(12),
      itemCount: articles.length,
      itemBuilder: (context, index) {
      final article = articles[index];
      return ListTile(
        title: Text(article.title),
        tileColor: Colors.grey,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        leading: Image.network(
        article.img,
        width: 50,
        ),
        
      );
    },
    separatorBuilder: (context, index) => const Divider(
      color: Colors.black,
    ),
    ),
  );
}