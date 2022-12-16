import 'package:budget/model/blog.dart';
import 'package:budget/pages/view_blog.dart';
import 'package:budget/provider/auth_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class FinancialNews extends StatefulWidget {
  const FinancialNews({super.key});

  @override
  State<FinancialNews> createState() => _FinancialNewsState();
}

class _FinancialNewsState extends State<FinancialNews> {
  late Future<Blog> fetchBlog;
  @override
  void initState() {
    fetchBlog =
        Provider.of<FirebaseProvider>(context, listen: false).fetchBlogs();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<FirebaseProvider>(context).blogList;
    return Padding(
      padding: const EdgeInsets.all(18),
      child: FutureBuilder<Blog>(
          future: fetchBlog,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return ListView.separated(
                physics: const ScrollPhysics(),
                shrinkWrap: true,
                itemCount: provider.length,
                separatorBuilder: (context, index) => const Divider(),
                itemBuilder: ((context, index) => GestureDetector(
                      onTap: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: ((context) =>
                                ViewBlog(blog: provider[index])),
                          ),
                        );
                      },
                      child: SizedBox(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(
                              height: 250,
                              width: MediaQuery.of(context).size.width,
                              child: Image.network(
                                provider[index].imgUrl,
                              ),
                            ),
                            const SizedBox(
                              width: 10,
                              height: 30,
                            ),
                            SizedBox(
                              height: 150,
                              width: MediaQuery.of(context).size.width,
                              child: Wrap(
                                children: [
                                  ListTile(
                                    title: Wrap(
                                      children: [
                                        Text(
                                          provider[index].title,
                                          softWrap: true,
                                          overflow: TextOverflow.ellipsis,
                                          maxLines: 2,
                                          style: const TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ],
                                    ),
                                    subtitle: Text(
                                      provider[index].description,
                                      maxLines: 5,
                                      softWrap: true,
                                      overflow: TextOverflow.ellipsis,
                                      style: const TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.normal,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    )),
              );
            }
            return const Center(child: CircularProgressIndicator());
          }),
    );
  }
}
