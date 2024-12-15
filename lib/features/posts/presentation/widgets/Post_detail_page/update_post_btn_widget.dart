import 'package:flutter/material.dart';
import 'package:http/http.dart';

import '../../../domain/entities/post.dart';
import '../../pages/post_add_update_page.dart';

class UpdatePostBtnWidget extends StatelessWidget{

  final Post post;

  UpdatePostBtnWidget({required this.post});

  @override
  Widget build(BuildContext context) {
    return  ElevatedButton.icon(
      onPressed: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (_) => PostAddUpdatePage(
                  isUpdatePost: true,
                  post: post,
                )));
      },
      label: Text("Edit"),
      icon: Icon(
        Icons.edit,
        color: Colors.white,
      ),
    );
  }

}