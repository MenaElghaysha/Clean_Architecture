import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:post_app/features/posts/presentation/widgets/Post_detail_page/update_post_btn_widget.dart';
import '../../../domain/entities/post.dart';
import 'delete_post_btn_widget.dart';

class PostDetailWidget extends StatelessWidget {
  final Post post;

  PostDetailWidget({super.key, required this.post});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(8),
      child: Column(
        children: [
          Text(
            post.title,
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          Divider(
            height: 50,
          ),
          Text(
            post.body,
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
          Divider(
            height: 50,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              UpdatePostBtnWidget(post: post),
              DeletePostBtnWidget(postId: post.id!),
            ],
          )
        ],
      ),
    );
  }

}
