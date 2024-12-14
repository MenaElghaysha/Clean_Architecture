import 'package:dartz/dartz.dart';

import '../../../../core/error/failure.dart';
import '../entities/post.dart';

abstract class PostRepo{
 Future<Either<Failure,List<Post>>> getAllPosts();
 Future<Either<Failure,Unit>> deletePost(int id);
 Future<Either<Failure,Unit>> updatePost(Post post);
 Future<Either<Failure,Unit>> addPost(Post post);
}
