import 'package:flutter/cupertino.dart';
import 'Actions.dart';

@immutable
class Counter_bloc {
  final counter;
  Counter_bloc(this.counter);
}

//pure reducer function
Counter_bloc reducer(Counter_bloc prev, action) {
  if (action is IncrementCount) {
    return Counter_bloc(prev.counter + action.cnt);
  } else if (action is DecrementCount) {
    return Counter_bloc(prev.counter - action.cnt);
  } else
    return prev;
}
