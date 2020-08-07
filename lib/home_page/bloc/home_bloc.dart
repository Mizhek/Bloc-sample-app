import 'dart:async';
import 'dart:math';
import 'dart:ui';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rxdart/rxdart.dart';

import 'bloc.dart';
import 'home_event.dart';
import 'home_state.dart';

class MyBloc extends Bloc<BaseEvent, BaseState> {
  MyBloc(initialState) : super(initialState) {
    _subscribeToSocket();
  }

  StreamSubscription _subscription;
  void _subscribeToSocket() {
    _unsubscribeFromSocket();
    _subscription = socket.listen((data) => add(SocketDataReceived(data)));
  }

  void _unsubscribeFromSocket() {
    _subscription?.cancel();
  }

  @override
  Future<void> close() {
    _unsubscribeFromSocket();
    return super.close();
  }

  @override
  void onTransition(Transition<BaseEvent, BaseState> transition) {
    print(transition);
    super.onTransition(transition);
  }

  @override
  Stream<Transition<BaseEvent, BaseState>> transformEvents(
      Stream<BaseEvent> events, transitionFn) {
    return events.flatMap(transitionFn);
  }

  @override
  Stream<BaseState> mapEventToState(BaseEvent event) async* {
    if (event is NumberRequested) {
      yield DataFromRequestState(await request());
      return;
    }
    if (event is SocketDataReceived) {
      yield DataFromSocketState(event.value);
    }
  }
}

Stream<int> get socket => Stream.periodic(const Duration(seconds: 1), (x) => x);

final random = Random.secure();

Future<int> request() => Future.delayed(
      const Duration(milliseconds: 300),
      () => random.nextInt(500),
    );
