import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'bloc/bloc.dart';

class HomePage extends StatefulWidget {
  HomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int requestNumber;
  int socketData;

  final bloc = MyBloc(InitState());

  final states = <String>[];

  @override
  void dispose() {
    bloc.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: BlocBuilder<MyBloc, BaseState>(
        cubit: bloc,
        builder: (BuildContext context, state) {
          states.insert(0, state.toString());
          print('Building state: $state');

          if (state is DataFromRequestState) {
            requestNumber = state.number;
          }
          if (state is DataFromSocketState) {
            socketData = state.data;
          }
          return Container(
            width: double.infinity,
            height: double.infinity,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text(
                  'Number from request:',
                ),
                Text(
                  '$requestNumber',
                  style: Theme.of(context).textTheme.headline4,
                ),
                Expanded(
                  child: states.isEmpty
                      ? SizedBox()
                      : ListView.builder(
                          itemCount: states.length,
                          itemBuilder: (BuildContext context, int index) {
                            return Text('${states[index]}');
                          }),
                ),
                Row(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    RaisedButton(
                      child: Text('Add event'),
                      onPressed: () {
                        bloc.add(NumberRequested());
                      },
                    ),
                  ],
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
