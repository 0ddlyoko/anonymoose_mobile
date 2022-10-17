import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:mobile/api/api.dart';
import 'package:mobile/models/tweet/tweet.dart';
import 'package:mobile/widgets/empty_widget.dart';
import 'package:mobile/widgets/loader_widget.dart';

import '../../widgets/single_tweet.dart';
import 'bloc/tweet_bloc.dart';
import 'new/new_tweet.dart';

class TweetPage extends StatelessWidget {
  const TweetPage({super.key});

  static Route<void> route({required NetworkApi networkApi, required String tweetId}) {
    return MaterialPageRoute(
      fullscreenDialog: false,
      builder: (context) => BlocProvider(
        create: (_) => TweetBloc(
          api: networkApi,
          tweetId: tweetId,
        )..add(TweetLoadEvent()),
        child: const TweetPage(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<TweetBloc, TweetState>(
      listenWhen: (previous, current) => previous.status != current.status && current.status == TweetStatus.error,
      listener: (context, state) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text("An error has occured, please try again later"),
          ),
        );
      },
      child: BlocBuilder<TweetBloc, TweetState>(
        builder: (context, state) {
          bool loaded = state.status == TweetStatus.loadComments || state.status == TweetStatus.success;
          Tweet? tweet = state.tweet;
          return Scaffold(
              appBar: AppBar(
                title: loaded ? Text("Tweet - ${tweet?.title}") : const Text("Tweet"),
              ),
              body: loaded ? const TweetView() : const LoaderWidget(),
              floatingActionButton: FloatingActionButton(
                onPressed: () => Navigator.of(context).push(NewTweetPage.route(
                  networkApi: context.read<NetworkApi>(),
                  tweetId: state.tweetId,
                )),
                tooltip: 'Comment',
                child: const Icon(Icons.add),
              )
          );
        },
      ),
    );
  }
}

class TweetView extends StatelessWidget {
  const TweetView({super.key});

  @override
  Widget build(BuildContext context) {
    return CupertinoScrollbar(
      child: ListView(
        children: const [
          TopTweetView(),
          Divider(indent: 20, endIndent: 20),
          IconTweetView(),
          Divider(indent: 20, endIndent: 20),
          CommentsView(),
        ],
      ),
    );
  }
}

class TopTweetView extends StatelessWidget {
  const TopTweetView({super.key});

  @override
  Widget build(BuildContext context) {
    final tweet = context.select((TweetBloc tweetBloc) => tweetBloc.state.tweet)!;

    return Row(
      children: [
        // Image on the left
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
          child: Image.network(
            "https://cdn.discordapp.com/avatars/304694488394235924/53455de4a44b1f37cacc185591231d9a.webp",
            width: 50,
            height: 50,
          ),
        ),
        Expanded(
          child: Container(
            padding: const EdgeInsets.all(10),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Text(tweet.author.name),
                    Text("19 septembre 2022 - 20:42", style: TextStyle(color: Colors.grey)),
                  ],
                ),
                Container(
                  margin: const EdgeInsets.all(5),
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
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

class IconTweetView extends StatelessWidget {
  const IconTweetView({super.key});

  @override
  Widget build(BuildContext context) {
    final number = context.select((TweetBloc tweetBloc) => tweetBloc.state.tweet?.comments?.size);
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Row(
          children: [
            const Icon(
              Icons.comment,
            ),
            Container(
              margin: const EdgeInsets.only(left: 5),
              child: Text(number.toString()),
            ),
          ],
        ),
      ],
    );
  }
}

class CommentsView extends StatelessWidget {
  const CommentsView({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        BlocBuilder<TweetBloc, TweetState>(
          builder: (context, state) {
            switch (state.status) {
              case TweetStatus.initial:
              case TweetStatus.loadComments:
                return const LoaderWidget();
              case TweetStatus.error:
                return const Text("ERROR");
              case TweetStatus.success:
                if (state.children.isEmpty) {
                  return const EmptyWidget();
                }
                return ListView.separated(
                  separatorBuilder: (ctx, idx) => const Divider(),
                  itemCount: state.children.length,
                  itemBuilder: (context, index) {
                    return CommentView(tweet: state.children[index ~/ 2]);
                  },
                  // physics: const ClampingScrollPhysics(),
                  shrinkWrap: true,
                );
            }
          },
        ),
      ],
    );
  }
}
