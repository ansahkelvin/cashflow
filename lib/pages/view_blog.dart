import 'package:budget/model/blog.dart';
import 'package:flutter/material.dart';

class ViewBlog extends StatelessWidget {
  const ViewBlog({super.key, required this.blog});
  final Blog blog;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Read more"),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 18.0, vertical: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 250,
                width: MediaQuery.of(context).size.width,
                child: Image.network(
                  blog.imgUrl,
                ),
              ),
              const SizedBox(
                height: 30,
              ),
              Text(
                blog.title,
                softWrap: true,
                overflow: TextOverflow.ellipsis,
                maxLines: 2,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(
                height: 30,
              ),
              Text(
                blog.description,
                textAlign: TextAlign.justify,
                softWrap: true,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.normal,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
