import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:mobile/api/api.dart';

import 'bloc/new_tweet_bloc.dart';

class NewTweetPage extends StatelessWidget {
  const NewTweetPage({super.key});

  static Route<void> route({required NetworkApi networkApi, required String tweetId}) {
    return MaterialPageRoute(
      fullscreenDialog: true,
      builder: (context) => BlocProvider(
        create: (_) => NewTweetBloc(
          api: networkApi,
          tweetId: tweetId,
        ),
        child: const NewTweetPage(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          Padding(
            padding: const EdgeInsets.fromLTRB(0, 8, 16, 8),
            child: TextButton(
              onPressed: () {
                context.read<NewTweetBloc>().add(NewTweetSubmitted());
              },
              style: ButtonStyle(
                padding: MaterialStateProperty.all(const EdgeInsets.symmetric(vertical: 5, horizontal: 10)),
              ),
              child: const Text("Tweeter", style: TextStyle(color: Colors.white)),
            ),
          ),
        ],
      ),
      body: const NewTweetView(),
    );
  }
}

class NewTweetView extends StatelessWidget {
  const NewTweetView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<NewTweetBloc, NewTweetState>(
      builder: (context, state) {
        return Column(
          mainAxisSize: MainAxisSize.max,
          children: [
            // Top (image & profile)
            Row(
              children: [
                // Left
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                  child: Image.network(
                    "https://cdn.discordapp.com/avatars/304694488394235924/53455de4a44b1f37cacc185591231d9a.webp",
                    width: 50,
                    height: 50,
                  ),
                ),
                // Right
                Row(
                  children: [
                    const Text("0ddlyoko"),
                    Padding(
                      padding: const EdgeInsets.only(left: 15),
                      child: Row(
                        children: const [
                          Text("Not Hidden", style: TextStyle(color: Colors.blue)),
                          Icon(
                            Icons.arrow_drop_down,
                            color: Colors.blue,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
            Column(
              children: [
                // Title
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 15),
                    child: TextFormField(
                      autofocus: true,
                      obscureText: false,
                      decoration: const InputDecoration(
                        hintText: "Title",
                        contentPadding: EdgeInsetsDirectional.fromSTEB(16, 0, 16, 12),
                      ),
                      textAlign: TextAlign.start,
                      maxLines: 1,
                      onChanged: (title) => context.read<NewTweetBloc>().add(NewTweetTitleChanged(title)),
                    ),
                  ),
                ),
                // Text
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 15),
                    child: TextFormField(
                      obscureText: false,
                      decoration: const InputDecoration(
                        hintText: "Your tweet",
                        contentPadding: EdgeInsetsDirectional.fromSTEB(16, 0, 16, 12),
                      ),
                      textAlign: TextAlign.start,
                      maxLines: 7,
                      onChanged: (desc) => context.read<NewTweetBloc>().add(NewTweetDescriptionChanged(desc)),
                    ),
                  ),
                ),
              ],
            ),
          ],
        );
      },
    );
  }
}
