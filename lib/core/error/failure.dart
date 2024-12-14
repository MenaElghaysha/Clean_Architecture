import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

abstract class Failure extends Equatable{

}

class OfflineFailure extends Failure{
  @override
  List<Object?> get props => [];
}

class ServerFailure extends Failure{
  @override
  List<Object?> get props => [];
}

class EmptyCacheFailure extends Failure{
  @override
  List<Object?> get props => [];
}

