import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:mobile/api/api.dart';
import 'package:mobile/widgets/loader_widget.dart';

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

    return BlocListener<NewTweetBloc, NewTweetState>(
      listenWhen: (previous, current) => previous.status != current.status,
      listener: (context, state) {
        switch (state.status) {
          case NewTweetStatus.error:
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text("An error has occurred, please try again"),
              ),
            );
            return;
          case NewTweetStatus.success:
            // Close this
            NavigatorState nav = Navigator.of(context);
            if (nav.canPop()) {
              nav.pop();
            } else {
              SystemNavigator.pop();
            }
            return;
          default:
        }
      },
      child: Scaffold(
        appBar: AppBar(
          actions: [
            Padding(
              padding: const EdgeInsets.fromLTRB(0, 8, 16, 8),
              child: TextButton(
                onPressed: () {
                  final NewTweetBloc bloc = context.read<NewTweetBloc>();
                  if (bloc.state.status != NewTweetStatus.creating) {
                    return;
                  }
                  if (bloc.state.title.isEmpty || bloc.state.description.isEmpty) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text("Please enter a title and a description"),
                      ),
                    );
                    return;
                  }
                  bloc.add(NewTweetSubmitted());
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
      ),
    );
  }
}

class NewTweetView extends StatelessWidget {
  const NewTweetView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<NewTweetBloc, NewTweetState>(
      buildWhen: (previous, current) => previous.status != current.status,
      builder: (context, state) {
        switch (state.status) {
          case NewTweetStatus.error:
          case NewTweetStatus.creating:
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
                  children: const [
                    // Title
                    _NewTweetTitleView(),
                    // Text
                    _NewTweetDescriptionView(),
                  ],
                ),
              ],
            );
          case NewTweetStatus.sending:
          case NewTweetStatus.success:
            return const LoaderWidget();
        }
      },
    );
  }
}

class _NewTweetTitleView extends StatelessWidget {
  const _NewTweetTitleView();

  @override
  Widget build(BuildContext context) {

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 15),
        child: BlocBuilder<NewTweetBloc, NewTweetState>(
          buildWhen: (previous, current) => previous.title != current.title,
          builder: (context, state) {
            return TextFormField(
              autofocus: true,
              obscureText: false,
              decoration: const InputDecoration(
                hintText: "Title",
                contentPadding: EdgeInsetsDirectional.fromSTEB(16, 0, 16, 12),
              ),
              textAlign: TextAlign.start,
              maxLines: 1,
              onChanged: (title) => context.read<NewTweetBloc>().add(NewTweetTitleChanged(title)),
            );
          },
        ),
      ),
    );
  }
}

class _NewTweetDescriptionView extends StatelessWidget {
  const _NewTweetDescriptionView();

  @override
  Widget build(BuildContext context) {

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 15),
        child: BlocBuilder<NewTweetBloc, NewTweetState>(
          buildWhen: (previous, current) => previous.description != current.description,
          builder: (context, state) {
            return TextFormField(
              autofocus: true,
              obscureText: false,
              decoration: const InputDecoration(
                hintText: "Description",
                contentPadding: EdgeInsetsDirectional.fromSTEB(16, 0, 16, 12),
              ),
              textAlign: TextAlign.start,
              maxLines: 7,
              onChanged: (desc) => context.read<NewTweetBloc>().add(NewTweetDescriptionChanged(desc)),
            );
          },
        ),
      ),
    );
  }
}
