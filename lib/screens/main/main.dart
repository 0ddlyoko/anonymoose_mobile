import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobile/api/api.dart';

import 'package:mobile/screens/auth/auth.dart';
import 'package:mobile/screens/tweet/tweet.dart';
import 'package:mobile/widgets/loader_widget.dart';

import 'bloc/main_bloc.dart';

class MainPageBloc extends StatelessWidget {
  const MainPageBloc({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Anonymoose"),
      ),
      body: BlocProvider(
        create: (context) => AppBloc(
          api: context.read<NetworkApi>(),
        ),
        child: const MainPage(),
      ),
    );
  }
}

class MainPage extends StatelessWidget {
  const MainPage({super.key});

  @override
  Widget build(BuildContext context) {

    return BlocListener<AppBloc, AppState>(
      listenWhen: (previous, current) => previous.status != current.status,
      listener: (context, state) {
        switch (state.status) {
          case AppStatus.logged:
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text("Welcome ${state.name}"),
              ),
            );
            break;
          case AppStatus.error:
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state.errorMessage),
              ),
            );
            break;
          default:
            break;
        }
      },
      child: BlocBuilder<AppBloc, AppState>(
        buildWhen: (previous, current) => previous.status != current.status,
        builder: (context, state) {
          switch (state.status) {
            case AppStatus.notLogged:
              return const NotLoggedPage();
            case AppStatus.loading:
              print("loading");
              return const LoaderWidget();
            case AppStatus.logged:
              return const TestPage();
            case AppStatus.error:
              return const NotLoggedPage();
          }
        },
      ),
    );
  }
}

class NotLoggedPage extends StatelessWidget {
  const NotLoggedPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text("It looks like you are not connected"),
          TextButton(
            onPressed: () => Navigator.of(context).push(AuthPage.route(
            callback: (tokenData) {
              final idToken = tokenData['id_token'];
              // final accessToken = tokenData['access_token'];
              // final refreshToken = tokenData['refresh_token'];
              context.read<AppBloc>().add(UserLogged(idToken));
            },
            )),
            child: const Text("Please Login"),
          ),
        ],
      )
    );
  }
}

class TestPage extends StatelessWidget {
  const TestPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text(
            'You have pushed the button this many times:',
          ),
          Text('1', style: Theme.of(context).textTheme.headline4),
          TextButton(
            onPressed: () => Navigator.of(context).push(TweetPage.route(
                networkApi: context.read<NetworkApi>(),
                tweetId: "449a0d6f-2f63-4d3f-8638-d5a011af6657",
            )),
            child: const Text("CLICKS"),
          ),
        ],
      ),
    );
  }
}
