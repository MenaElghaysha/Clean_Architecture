import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:post_app/features/posts/presentation/pages/post_detail_page.dart';

import '../../../domain/entities/post.dart';

class PostListWidget extends StatelessWidget {
  final List<Post> posts;

  PostListWidget({super.key, required this.posts});

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return ListView.separated(
        itemBuilder: (context, index) {
          return ListTile(
            leading: Text(posts[index].id.toString()),
            title: Text(
              posts[index].title,
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            subtitle: Text(
              posts[index].body,
              style: TextStyle(
                fontSize: 16,
              ),
            ),
            contentPadding: EdgeInsets.symmetric(horizontal: 10),
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => PostDetailPage(post: posts[index]),
                  ));
            },
          );
        },
        separatorBuilder: (context, index) {
          return Divider(
            thickness: 1,
          );
        },
        itemCount: posts.length);
  }
}
