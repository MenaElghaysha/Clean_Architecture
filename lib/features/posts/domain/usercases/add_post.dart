import 'package:dartz/dartz.dart';
import 'package:post_app/features/posts/domain/entities/post.dart';
import 'package:post_app/features/posts/domain/repos/post_repo.dart';

import '../../../../core/error/failure.dart';

class AddPostUsecase {
  final PostRepo repo;

  AddPostUsecase(this.repo);

  Future<Either<Failure, Unit>> call(Post post) async {
    return await repo.addPost(post);
  }
}
