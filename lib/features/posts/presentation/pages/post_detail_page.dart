import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../domain/entities/post.dart';
import '../widgets/Post_detail_page/post_detail_widget.dart';

class PostDetailPage extends StatelessWidget {
  final Post post;

  PostDetailPage({required this.post});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(),
      body: _buildBody(),
    );
  }

  AppBar _buildAppBar() => AppBar(
        title: Text("Post Detail"),
      );

  Widget _buildBody() {
    return Center(
      child: Padding(
        padding: EdgeInsets.all(8),
        child: PostDetailWidget(post: post),
      ),
    );
  }
}
