import 'dart:convert';
import 'package:dartz/dartz.dart';
import 'package:post_app/core/error/exception.dart';
import 'package:post_app/features/posts/data/models/post_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

abstract class PostLocalDataSourca {
  Future<List<PostModel>> getCachedPosts();

  Future<Unit> cachePosts(List<PostModel> postModels);
}

const CACHED_POSTS = 'CACHED_POSTS';

class PostLocalDataSourceImpl implements PostLocalDataSourca {
  final SharedPreferences sharedPreferences;

  PostLocalDataSourceImpl({required this.sharedPreferences});

  @override
  Future<Unit> cachePosts(List<PostModel> postModels) {
    List postModelsToJson = postModels
        .map<Map<String, dynamic>>((postModel) => postModel.toJson())
        .toList();
    sharedPreferences.setString(CACHED_POSTS, json.encode(postModelsToJson));
    return Future.value(unit);
  }

  @override
  Future<List<PostModel>> getCachedPosts() {
    final jsonString = sharedPreferences.getString(CACHED_POSTS);
    if (jsonString != null) {
      List decodeJsonData = json.decode(jsonString);
      List<PostModel> jsonToPostModels = decodeJsonData
          .map<PostModel>((jsonPostModel) => PostModel.fromJson(jsonPostModel))
          .toList();
      return Future.value(jsonToPostModels);
    } else {
      throw EmptyCacheException();
    }
  }
}
