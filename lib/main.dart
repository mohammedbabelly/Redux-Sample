import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';
import 'package:redux_sample/Redux/Actions.dart';
import 'package:redux_sample/Redux/Counter.dart';
import 'package:redux_sample/Redux/Name.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Redux Demo',
      theme: ThemeData.dark(),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  TextEditingController nameCon;
  Store<Counter_bloc> store = Store(reducer, initialState: Counter_bloc(0));
  Store<Name_bloc> store_name =
      Store(reducerName, initialState: Name_bloc('..'));

  @override
  Widget build(BuildContext context) {
    return StoreProvider(
      store: store,
      child: StoreProvider(
        store: store_name,
        child: Scaffold(
            appBar: AppBar(
              title: Text('Redux smaple'),
            ),
            body: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  StoreConnector<Name_bloc, String>(
                    converter: (store_name) => store_name.state.name,
                    builder: (context, data) => Text(data),
                  ),
                  Text(
                    'You have pushed the button this many times:',
                  ),
                  StoreConnector<Counter_bloc, int>(
                      converter: (store) => store.state.counter,
                      builder: (context, data) => Text(
                            data.toString(),
                            style: Theme.of(context).textTheme.display1,
                          )),
                  StoreConnector<Name_bloc, dynamic>(
                      converter: (store_name) {
                        return (name) => store_name.dispatch(EditAction(name));
                      },
                      builder: (context, call) => TextField(
                            controller: nameCon,
                            onChanged: (name) => call(name),
                          ))
                ],
              ),
            ),
            floatingActionButton: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
                StoreConnector<Counter_bloc, dynamic>(
                    converter: (store) {
                      return (cnt) => store.dispatch(IncrementCount(cnt));
                    },
                    builder: (context, call) => FloatingActionButton(
                          onPressed: () => call(2),
                          child: Text('+2'),
                        )),
                StoreConnector<Counter_bloc, dynamic>(
                    converter: (store) {
                      return (cnt) => store.dispatch(DecrementCount(cnt));
                    },
                    builder: (context, call) => FloatingActionButton(
                          onPressed: () => call(1),
                          child: Text('-1'),
                        )),
              ],
            )),
      ),
    );
  }
}
