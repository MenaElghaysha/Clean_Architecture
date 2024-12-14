import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

import '../../../../../core/error/failure.dart';
import '../../../../../core/strings/failures.dart';
import '../../../../../core/strings/messages.dart';
import '../../../domain/entities/post.dart';
import '../../../domain/usercases/add_post.dart';
import '../../../domain/usercases/delete_post.dart';
import '../../../domain/usercases/update_post.dart';

part 'add_delete_update_event.dart';

part 'add_delete_update_state.dart';

class AddDeleteUpdateBloc
    extends Bloc<AddDeleteUpdatePostEvent, AddDeleteUpdateState> {
  final AddPostUsecase addPost;
  final DeletePostUsecase deletePost;
  final UpdatePostUsecase updatePost;

  AddDeleteUpdateBloc(
      {required this.addPost,
      required this.deletePost,
      required this.updatePost})
      : super(AddDeleteUpdateInitial()) {
    on<AddDeleteUpdatePostEvent>((event, emit) async {
      if (event is AddPostEvent) {
        emit(LoadingAddDeleteUpdatePostState());
        final failureOrPost =
            await addPost(event.post); // pass the post of the event

        emit(
            _eitherDoneMessageOrErrorState(failureOrPost, ADD_SUCCESS_MESSAGE));
      } else if (event is UpdatePostEvent) {
        emit(LoadingAddDeleteUpdatePostState());
        final failureOrPost =
            await updatePost(event.post); // pass the post of the event

        emit(_eitherDoneMessageOrErrorState(
            failureOrPost, UPDATE_SUCCESS_MESSAGE));
      } else if (event is DeletePostEvent) {
        emit(LoadingAddDeleteUpdatePostState());
        final failureOrPost =
            await deletePost(event.postId); // pass the postId of the event
        emit(_eitherDoneMessageOrErrorState(
            failureOrPost, DELETE_SUCCESS_MESSAGE));
      }
    });
  }

  // AddDeleteUpdateState _eitherDoneMessageOrErrorState(
  //     Either<Failure, Unit> either, String message) {
  //   return either.fold(
  //         (failure) => ErrorAddDeleteUpdatePostState(
  //       message: _mapFailureToMessage(failure),
  //     ),
  //         (_) => MessageAddDeleteUpdatePostState(message: message),
  //   );
  // }

  AddDeleteUpdateState _eitherDoneMessageOrErrorState(
      Either<Failure, Unit> either, String message) {
    either.fold(
          (failure) => print("Failure occurred: ${failure.runtimeType}"),
          (_) => print("Operation successful: $message"),
    );
    return either.fold(
          (failure) => ErrorAddDeleteUpdatePostState(
        message: _mapFailureToMessage(failure),
      ),
          (_) => MessageAddDeleteUpdatePostState(message: message),
    );
  }


  String _mapFailureToMessage(Failure failure) {
    print("Failure Type: ${failure.runtimeType}");
    switch (failure.runtimeType) {
      case ServerFailure:
        return SERVER_FAILURE_MESSAGE;
      case EmptyCacheFailure:
        return EMPTY_CACHE_FAILURE_MESSAGE;
      case OfflineFailure:
        return OFFLINE_FAILURE_MESSAGE;
      default:
        return "Unexpected Error, Please try again later.";
    }
  }
}




