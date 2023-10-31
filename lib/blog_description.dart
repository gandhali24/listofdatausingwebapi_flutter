// detail screen
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:listofdata_flutter/blog.dart';

class BlogDescription extends StatelessWidget {

//const BlogDescription({super.key});
//  final BlogModel blog;
  //const BlogDescription({Key? key, required this.blog}):super(key: key);
  const BlogDescription({Key? key}):super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Text('Blog Description'),
      ),
      body: Column(
        children: [
          Image.network('blog.image_url'),
          Text('blog.title')
        ],
      ),
    );
  }
}


// class DetailScreen