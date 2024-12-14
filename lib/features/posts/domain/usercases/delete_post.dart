import 'package:dartz/dartz.dart';
import 'package:post_app/features/posts/domain/repos/post_repo.dart';

import '../../../../core/error/failure.dart';
import '../entities/post.dart';

class DeletePostUsecase{
  final PostRepo repo ;

  DeletePostUsecase(this.repo);

  Future<Either<Failure,Unit>> call(int postId)async{
    return await repo.deletePost(postId);
  }
}