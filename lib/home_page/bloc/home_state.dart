import 'package:equatable/equatable.dart';

abstract class BaseState extends Equatable {
  @override
  bool get stringify => true;

  @override
  List<Object> get props => [];
}

class InitState extends BaseState {}

class DataFromSocketState extends BaseState {
  final int data;

  DataFromSocketState(this.data);

  @override
  List<Object> get props => [data];
}

class DataFromRequestState extends BaseState {
  final int number;

  DataFromRequestState(this.number);

  @override
  List<Object> get props => [number];
}
