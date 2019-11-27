import 'package:redux_sample/Redux/Actions.dart';

class Name_bloc {
  String name;
  Name_bloc(this.name);
}

//pure fun
Name_bloc reducerName(Name_bloc prev, action) {
  if (action is EditAction) {
    return Name_bloc(action.name);
  }
}
