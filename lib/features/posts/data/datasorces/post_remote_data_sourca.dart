import 'dart:convert';
import 'package:dartz/dartz.dart';
import 'package:post_app/core/error/exception.dart';
import 'package:post_app/features/posts/data/models/post_model.dart';
import 'package:http/http.dart' as http;

abstract class PostRemoteDataSourca {
  Future<List<PostModel>> getAllPosts();

  Future<Unit> deletePost(int postId);

  Future<Unit> addPost(PostModel postModel);

  Future<Unit> updatePost(PostModel postModel);
}

const Base_URl = "https://jsonplaceholder.typicode.com";

class PostRemoteDataSourceImpl implements PostRemoteDataSourca {
  final http.Client client;

  PostRemoteDataSourceImpl({required this.client});

  @override
  Future<List<PostModel>> getAllPosts() async {
    final response = await client.get(Uri.parse(Base_URl + "/posts/"),
        headers: {"Content-Type": "application/json"});

    if (response.statusCode == 200) {
      final List decodedJson = json.decode(response.body) as List;
      final List<PostModel> postModels = decodedJson
          .map<PostModel>((jsonPostModel) => PostModel.fromJson(jsonPostModel))
          .toList();

      return postModels;
    } else {
      throw ServerException();
    }
  }

  @override
  Future<Unit> addPost(PostModel postModel) async {
    final body = {"title": postModel.title, "body": postModel.body};

    final response = await client.post(
      Uri.parse(Base_URl + "/posts/"), body: body,
      // headers: {"Content-Type": "application/json"}
    );
    if (response.statusCode == 201) {
      return Future.value(unit);
    } else {
      throw ServerException();
    }
  }

  @override
  Future<Unit> deletePost(int postId) async {
    final response = await client.delete(
        Uri.parse(Base_URl + "/posts/${postId.toString()}"),
        headers: {"Content-Type": "application/json"});

    if (response.statusCode == 200) {
      return Future.value(unit);
    } else {
      throw ServerException();
    }
  }

  @override
  Future<Unit> updatePost(PostModel postModel) async {
    final postId = postModel.id.toString();

    final body = {'title': postModel.title, 'body': postModel.body};

    final response =
        await client.patch(Uri.parse(Base_URl + '/posts/${postId.toString()}'),body: body);
    if(response.statusCode == 200){
      return Future.value(unit);
    }else{
      throw ServerException();
    }
  }
}
