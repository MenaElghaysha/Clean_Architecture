import 'package:dartz/dartz.dart';
import 'package:post_app/features/posts/domain/repos/post_repo.dart';

import '../../../../core/error/failure.dart';
import '../entities/post.dart';

class GetAllPostsUsecase{
  final PostRepo repo;
  GetAllPostsUsecase(this.repo);

  Future<Either<Failure,List<Post>>> call() async{
    return await repo.getAllPosts();
  }

}