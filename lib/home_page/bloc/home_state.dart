
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

abstract class BaseState extends Equatable {
  @override
  bool get stringify => true;
}

class InitState extends BaseState {
  @override
  List<Object> get props => [];
}

class DataFromSocketState extends BaseState {
  final Color color;

  DataFromSocketState(this.color);

  @override
  List<Object> get props => [color];
}

class DataFromRequestState extends BaseState {
  final double number;

  DataFromRequestState(this.number);

  @override
  List<Object> get props => [number];
}
