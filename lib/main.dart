import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobile/SimpleBlocObserver.dart';
import 'package:mobile/screens/main/main.dart';
import 'api/api.dart';

void main() {
  BlocObserver observer = SimpleBlocObserver();

  // Initialise Network
  final dio = Dio();
  final networkApi = NetworkApi(dio);

  runApp(MyApp(networkApi: networkApi));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key, required this.networkApi});

  final NetworkApi networkApi;

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return RepositoryProvider.value(
      value: networkApi,
      child: MaterialApp(
        title: 'Anonymoose',
        theme: ThemeData(
          // This is the theme of your application.
          //
          // Try running your application with "flutter run". You'll see the
          // application has a blue toolbar. Then, without quitting the app, try
          // changing the primarySwatch below to Colors.green and then invoke
          // "hot reload" (press "r" in the console where you ran "flutter run",
          // or simply save your changes to "hot reload" in a Flutter IDE).
          // Notice that the counter didn't reset back to zero; the application
          // is not restarted.
          primarySwatch: Colors.blue,
        ),
        home: const MainPageBloc(),
      ),
    );
  }
}
