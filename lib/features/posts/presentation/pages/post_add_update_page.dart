import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:post_app/core/widgets/loading_widget.dart';
import 'package:post_app/features/posts/presentation/bloc/add_delete_update_post/add_delete_update_bloc.dart';
import 'package:post_app/features/posts/presentation/pages/posts_page.dart';

import '../../../../core/util/snackbar_message.dart';
import '../../domain/entities/post.dart';
import '../widgets/post_and_update_page/form_widget.dart';

class PostAddUpdatePage extends StatelessWidget {
  final Post? post;
  final bool isUpdatePost;

  PostAddUpdatePage({super.key, this.post, required this.isUpdatePost});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(),
      body: _buildBuildBody(),
    );
  }

  dynamic _buildBuildBody() {
    return SingleChildScrollView(
      child: Center(
        child: Padding(
          padding: EdgeInsets.all(8),
          child: BlocConsumer<AddDeleteUpdateBloc, AddDeleteUpdateState>(
            // Navigate and snackbar
            listener: (context, state) {
              if (state is MessageAddDeleteUpdatePostState) {
                SnackBarMessage().showSuccessSnackBar(
                    message: state.message, context: context);
                Navigator.of(context).pushAndRemoveUntil(
                    MaterialPageRoute(builder: (_) => PostsPage()),
                    (route) => false);
              } else if (state is ErrorAddDeleteUpdatePostState) {
                print("Error SnackBar called: ${state.message}");
                SnackBarMessage().showErrorSnackBar(
                    message: state.message, context: context);
              }
            },
            // return widgets
            builder: (context, state) {
              if (state is LoadingAddDeleteUpdatePostState) {
                return LoadingWidget();
              }
              return FormWidget(
                  isUpdatePost: isUpdatePost, post: isUpdatePost ? post : null);
              ;
            },
          ),
        ),
      ),
    );
  }

  AppBar _buildAppBar() => AppBar(
        title: Text(
          isUpdatePost ? "Edit Post" : "Add Post",
        ),
      );
}
