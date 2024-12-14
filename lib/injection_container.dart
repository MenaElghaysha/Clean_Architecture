import 'package:get_it/get_it.dart';
import 'package:http/http.dart' as http;
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:post_app/core/network/network_info.dart';
import 'package:post_app/features/posts/data/datasorces/post_remote_data_sourca.dart';
import 'package:post_app/features/posts/data/repos/posts_repo_impl.dart';
import 'package:post_app/features/posts/domain/repos/post_repo.dart';
import 'package:post_app/features/posts/domain/usercases/add_post.dart';
import 'package:post_app/features/posts/domain/usercases/delete_post.dart';
import 'package:post_app/features/posts/domain/usercases/get_all_posts.dart';
import 'package:post_app/features/posts/domain/usercases/update_post.dart';
import 'package:post_app/features/posts/presentation/bloc/add_delete_update_post/add_delete_update_bloc.dart';
import 'package:post_app/features/posts/presentation/bloc/posts/posts_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'features/posts/data/datasorces/post_local_data_sourca.dart';

final sl = GetIt.instance;

Future<void> init() async {
  //! Features - posts

  // Bloc
  sl.registerFactory(
    () => PostsBloc(getAllPosts: sl.call()),
  );
  sl.registerFactory(
    () =>
        AddDeleteUpdateBloc(addPost: sl(), deletePost: sl(), updatePost: sl()),
  );

  // Usecases

  sl.registerLazySingleton(
    () => GetAllPostsUsecase(sl()),
  );
  sl.registerLazySingleton(
    () => AddPostUsecase(sl()),
  );
  sl.registerLazySingleton(
    () => UpdatePostUsecase(sl()),
  );
  sl.registerLazySingleton(
    () => DeletePostUsecase(sl()),
  );
  // Repos

  sl.registerLazySingleton<PostRepo>(
    () => PostsRepoImpl(
        networkInfo: sl(), remoteDataSource: sl(), localDataSource: sl()),
  );

  // Datasources

  sl.registerLazySingleton<PostRemoteDataSourca>(
    () => PostRemoteDataSourceImpl(client: sl()),
  );
  sl.registerLazySingleton<PostLocalDataSourca>(
    () => PostLocalDataSourceImpl(sharedPreferences: sl()),
  );
  //! Core
  sl.registerLazySingleton<NetworkInfo>(
    () => NetworkInfoImpl(connectionChecker: sl()),
  );

  //! External (shared prefrences - http)
  final sharedPreferences = await SharedPreferences.getInstance();
  sl.registerLazySingleton(
    () => sharedPreferences,
  );
  sl.registerLazySingleton(
    () => http.Client(),
  );
  sl.registerLazySingleton(
    () => InternetConnectionChecker(),
  );
}
