import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:mobile/api/api.dart';
import 'package:mobile/models/tweet/tweet.dart';
import 'package:mobile/screens/tweet/tweet.dart';


class CommentView extends StatelessWidget {
  const CommentView({super.key, required this.tweet});

  final Tweet tweet;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        // Image on the left
        Column(
          children: [
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
              child: Image.network(
                "https://cdn.discordapp.com/avatars/304694488394235924/53455de4a44b1f37cacc185591231d9a.webp",
                width: 50,
                height: 50,
              ),
            ),
          ],
        ),
        Expanded(
          child: Container(
            padding: const EdgeInsets.all(10),
            child: Column(
              children: [
                Row(
                  children: [
                    Text(tweet.author.name),
                    const Text(" · ", style: TextStyle(color: Colors.grey)),
                    Text("2 h", style: TextStyle(color: Colors.grey)),
                  ],
                ),
                InkWell(
                  child: Container(
                    padding: const EdgeInsets.all(5),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Container(
                          margin: const EdgeInsets.only(top: 10),
                          child: Text(
                            tweet.title,
                            style: const TextStyle(fontSize: 18),
                          ),
                        ),
                        Container(
                          margin: const EdgeInsets.only(top: 5),
                          child: Text(tweet.text),
                        )
                      ],
                    ),
                  ),
                  onTap: () => Navigator.of(context).push(TweetPage.route(
                    networkApi: context.read<NetworkApi>(),
                    tweetId: tweet.id,
                  )),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}