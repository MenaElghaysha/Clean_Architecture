import 'package:dartz/dartz.dart';
import 'package:post_app/core/error/exception.dart';
import 'package:post_app/core/error/failure.dart';
import 'package:post_app/features/posts/data/datasorces/post_local_data_sourca.dart';
import 'package:post_app/features/posts/data/datasorces/post_remote_data_sourca.dart';
import 'package:post_app/features/posts/data/models/post_model.dart';
import 'package:post_app/features/posts/domain/entities/post.dart';
import 'package:post_app/features/posts/domain/repos/post_repo.dart';

import '../../../../core/network/network_info.dart';

typedef Future<Unit> DeleteOrUpdateOrAddPost();

class PostsRepoImpl implements PostRepo {
  final PostRemoteDataSourca remoteDataSource;
  final PostLocalDataSourca localDataSource;
  final NetworkInfo networkInfo;

  PostsRepoImpl(
      {required this.networkInfo,
      required this.remoteDataSource,
      required this.localDataSource});

  @override
  Future<Either<Failure, List<Post>>> getAllPosts() async {
    if (await networkInfo.isConnected) {
      try {
        final remotePosts = await remoteDataSource.getAllPosts();
        localDataSource.cachePosts(remotePosts);
        return right(remotePosts);
      } on ServerException {
        return Left(ServerFailure());
      }
    } else {
      try {
        final localPosts = await localDataSource.getCachedPosts();
        return Right(localPosts);
      } on EmptyCacheException {
        return Left(EmptyCacheFailure());
      }
    }
  }

  @override
  Future<Either<Failure, Unit>> addPost(Post post) async {
    final PostModel postModel =
        PostModel( title: post.title, body: post.title);
    return await _getMessage(() {
      return remoteDataSource.addPost(postModel);
    });
  }

  @override
  Future<Either<Failure, Unit>> updatePost(Post post) async {
    final PostModel postModel =
        PostModel(id: post.id, title: post.title, body: post.title);

    return await _getMessage(() {
      return remoteDataSource.updatePost(postModel);
    });
  }

  @override
  Future<Either<Failure, Unit>> deletePost(int postId) async {
    // if (await networkInfo.isConnected) {
    //   try {
    //     await remoteDataSource.deletePost(postId);
    //     return right(unit);
    //   } on ServerException {
    //     return Left(ServerFailure());
    //   }
    // } else {
    //   return Left(OfflineFailure());
    // }

    return await _getMessage(() {
      return remoteDataSource.deletePost(postId);
    });
  }

  Future<Either<Failure, Unit>> _getMessage(
      DeleteOrUpdateOrAddPost deleteOrUpdateOrAddPost) async {
    final isConnected = await networkInfo.isConnected;
    print("Network status: $isConnected");
    if (isConnected) {
      try {
        await deleteOrUpdateOrAddPost();
        return right(unit);
      } on ServerException {
        print("Server exception occurred");
        return Left(ServerFailure());
      }
    } else {
      print("Offline detected");
      return Left(OfflineFailure());
    }
  }

}
