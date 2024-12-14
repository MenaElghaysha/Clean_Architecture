import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart';
import 'package:post_app/features/posts/presentation/bloc/add_delete_update_post/add_delete_update_bloc.dart';
import 'package:post_app/features/posts/presentation/widgets/post_and_update_page/form_submit_btn.dart';
import 'package:post_app/features/posts/presentation/widgets/post_and_update_page/text_form_feild_widget.dart';

import '../../../domain/entities/post.dart';

class FormWidget extends StatefulWidget {
  final bool isUpdatePost;

  final Post? post;

  FormWidget({required this.isUpdatePost, this.post});

  @override
  State<FormWidget> createState() => _FormWidgetState();
}

class _FormWidgetState extends State<FormWidget> {
  final _formKey = GlobalKey<FormState>();

  TextEditingController _titleController = TextEditingController();
  TextEditingController _bodyController = TextEditingController();

  @override
  void initState() {
    if (widget.isUpdatePost) {
      _titleController.text = widget.post!.title;
      _bodyController.text = widget.post!.body;
    }
    super.initState();
  }

  // void validateFormThenUpdateOrAddPost() {
  //   final isValid = _formKey.currentState!.validate();
  //   final post = Post(
  //       id: widget.isUpdatePost ? widget.post!.id : null,
  //       title: _titleController.text,
  //       body: _bodyController.text);
  //
  //   if (widget.isUpdatePost) {
  //     BlocProvider.of<AddDeleteUpdateBloc>(context)
  //         .add(UpdatePostEvent(post: post));
  //   }else{
  //     BlocProvider.of<AddDeleteUpdateBloc>(context)
  //         .add(AddPostEvent(post: post));
  //   }
  // }


  void validateFormThenUpdateOrAddPost() {
    final isValid = _formKey.currentState!.validate();
    if (!isValid) {
      print("Form validation failed.");
      return;
    }

    final post = Post(
        id: widget.isUpdatePost ? widget.post!.id : null,
        title: _titleController.text,
        body: _bodyController.text);

    if (widget.isUpdatePost) {
      BlocProvider.of<AddDeleteUpdateBloc>(context)
          .add(UpdatePostEvent(post: post));
    } else {
      BlocProvider.of<AddDeleteUpdateBloc>(context)
          .add(AddPostEvent(post: post));
    }
  }


  @override
  Widget build(BuildContext context) {
    return Form(
        key: _formKey,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            TextFormFieldWidget(controller: _titleController, multiLines: false, name: 'Title'),
            TextFormFieldWidget(controller: _bodyController, multiLines: true, name: 'Body'),
            FormSubmitBtn(onPressed:validateFormThenUpdateOrAddPost , isUpdatePost:widget.isUpdatePost)
          ],
        ));
  }
}
