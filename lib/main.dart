import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobile/SimpleBlocObserver.dart';
import 'package:mobile/screens/auth/auth.dart';
import 'package:mobile/screens/tweet/tweet.dart';
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
      child: const MyAppView(),
    );
  }
}

class MyAppView extends StatelessWidget {
  const MyAppView({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
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
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  @override
  Widget build(BuildContext context) {
    // Route<void> route = TweetPage.route(
    //   networkApi: context.read<NetworkApi>(),
    //   tweetId: "449a0d6f-2f63-4d3f-8638-d5a011af6657",
    // );
    // Route<void> route2 = AuthPage.route(
    //   networkApi: context.read<NetworkApi>(),
    // );


    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              'You have pushed the button this many times:',
            ),
            Text(
              '$_counter',
              style: Theme.of(context).textTheme.headline4,
            ),
            TextButton(
              onPressed: () => Navigator.of(context).push(AuthPage.route(
                networkApi: context.read<NetworkApi>(),
                callback: (tokenData) {
                  print("tokenData: ");
                  final idToken = tokenData['id_token'];
                  final accessToken = tokenData['access_token'];
                  final refreshToken = tokenData['refresh_token'];
                  print(tokenData);
                  print("idToken: $idToken");
                  print("accessToken: $accessToken");
                  print("refreshToken: $refreshToken");
                },
              )),
              child: const Text("CLICKS"),
            ),
          ],
        ),
      ),
    );
  }
}
