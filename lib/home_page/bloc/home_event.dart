
abstract class BaseEvent {
  final bool withDelay;

  BaseEvent(this.withDelay);
}

class SocketEvent extends BaseEvent {
  SocketEvent(bool withDelay) : super(withDelay);
}

class NumberRequestEvent extends BaseEvent {
  NumberRequestEvent(bool withDelay) : super(withDelay);
}
