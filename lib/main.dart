import 'package:flutter/material.dart';
import 'package:diosamples/repo.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';

void main() => runApp(
      MaterialApp(
        title: 'simple cash',
        home: HomeScreen(),
        debugShowCheckedModeBanner: false,
      ),
    );

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String result = 'click on fab';
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    return ModalProgressHUD(
      inAsyncCall: isLoading,
      child: Scaffold(
        body: Center(child: Text(result)),
        appBar: AppBar(title: Text('Dio demo')),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            setState(() {
              isLoading = true;
              Repo().getRandomDate().then((data) {
                setState(() {
                  result = data;
                  isLoading = false;
                });
              });
            });
          },
          child: Icon(Icons.cached),
        ),
      ),
    );
  }
}
