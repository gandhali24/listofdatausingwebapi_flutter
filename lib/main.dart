import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:listofdata_flutter/blog_description.dart';
import 'package:listofdata_flutter/blog_model.dart';
import 'package:listofdata_flutter/hive_functions.dart';
import 'package:http/http.dart' as http;


void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.green,
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
 // var jsonList;
  late List<dynamic>jsonList=[];
  late List<bool> isFavourite;
  Color _iconColor = Colors.white;
  bool isLoading = true;


  @override
  void initState() {
    fetchBlogs();
  }

  void fetchBlogs() async {
    final String url = 'https://intent-kit-16.hasura.app/api/rest/blogs';
    final String adminSecret = '32qR4KmXOIpsGPQKMqEJHGJS27G5s7HdSKO3gdtQd2kv5e852SiYwWNfxkZOBuQ6';

    try {
      final response = await http.get(Uri.parse(url), headers: {
        'x-hasura-admin-secret': adminSecret,
      });

      if (response.statusCode == 200) {
        // Request successful, handle the response data here
        print('Response data: ${response.body}');


        setState(() {

          Map data = jsonDecode(response.body);
          // print(data);
          // print(data['title']);
          isLoading = false;

        jsonList=  data['blogs'] as List<dynamic>;
         // jsonList=data as List;

        });
        if (jsonList != null) {
          HiveFunctions.addAllUser(

              jsonList

          );

          // To refresh the Data stored in Hive after updation

          // getHiveData();

         // myHiveData = HiveFunctions.getAllUsers();
       }
      } else {
        // Request failed
        print('Request failed with status code: ${response.statusCode}');
        print('Response data: ${response.body}');
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text("Sending Message"),
        ));
      }
    } catch (e) {
      // Handle any errors that occurred during the request
      print('Error: $e');
    }
  }

  void main() {
    fetchBlogs();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Text(
          'Blogs and Articles',
        ),
        centerTitle: false,
        elevation: 0,


      ),

      body: ListView.builder(
          itemCount: jsonList == null ? 0 : jsonList.length,
          itemBuilder: (BuildContext context, int index) {
            return Card(
                color: Colors.black,

                child: ListTile(

                    // leading: Icon(Icons.favorite),
                    // iconColor: Colors.white,


                    title: Image.network(
                      jsonList[index]['image_url'],
                      fit: BoxFit.fill,
                      width: 200,
                      height: 200,

                    ),

                    leading: new IconButton(
                      icon: Icon(Icons.favorite, color:_iconColor),

                      onPressed: () {
                        setState(() {
                          if(  _iconColor == Colors.white){
                            _iconColor = Colors.red;
                          }else {
                            _iconColor = Colors.white;
                          }
                        });
                      },),

                    subtitle: Text(
                        jsonList[index]['title'],


                        style: TextStyle(fontSize: 18.0)),

                    textColor: Colors.white,

                    onTap: () {
                      Navigator.of(context).push(
                          MaterialPageRoute(
                             // builder: (context) => BlogDescription(blog: jsonList[index],))
                          builder: (context) => BlogDescription())

                      );
                    }


                ));
          }),

    );
  }


}


