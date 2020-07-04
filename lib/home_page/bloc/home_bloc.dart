import 'dart:math';
import 'dart:ui';

import 'package:flutter_bloc/flutter_bloc.dart';

import 'home_event.dart';
import 'home_state.dart';

class MyBloc extends Bloc<BaseEvent, BaseState> {
  MyBloc(initialState) : super(initialState);

  @override
  Stream<BaseState> mapEventToState(BaseEvent event) async* {
    if (event.withDelay) {
      print('delaying...');
      await Future.delayed(Duration(milliseconds: 50));
    }

    switch (event.runtimeType) {
      case NumberRequestEvent:
        yield await _fakeRestRequest(event);
        break;
      case SocketEvent:
        yield DataFromSocketState(Color.fromRGBO(
          Random().nextInt(256),
          Random().nextInt(256),
          Random().nextInt(256),
          1.0,
        ));
        break;
    }
  }

  Future<BaseState> _fakeRestRequest(BaseEvent event) =>
      Future.delayed(Duration(milliseconds: 300)).then((value) {
        add(SocketEvent(event.withDelay));
        return DataFromRequestState(Random().nextInt(500).toDouble());
      });
}
