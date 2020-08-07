abstract class BaseEvent {}

class SocketDataReceived extends BaseEvent {
  SocketDataReceived(this.value);

  final int value;
}

class NumberRequested extends BaseEvent {}
