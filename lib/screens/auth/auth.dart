import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:mobile/api/api.dart';
import 'package:mobile/constants.dart';
import 'package:mobile/widgets/loader_widget.dart';
import 'package:webview_flutter/webview_flutter.dart';

import 'bloc/auth_bloc.dart';

class AuthPage extends StatelessWidget {
  // Inspired by https://github.com/furaiev/amazon-cognito-identity-dart-2/#usage
  // Use case 19
  const AuthPage({super.key});

  static Route<void> route({required NetworkApi networkApi, required Function callback}) {
    return MaterialPageRoute(
      fullscreenDialog: true,
      builder: (context) => BlocProvider(
        create: (_) => AuthBloc(
          api: networkApi,
          callback: callback,
       ),
       child: BlocListener<AuthBloc, AuthState>(
         // listenWhen: (previous, current) => previous.status != current.status && current.status == AuthStatus.success,
         listener: (context, state) {
           // Close this
           print("CLOSING");
           Navigator.of(context).pop();
         },
         child: const AuthPage(),
       ),
     ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthBloc, AuthState>(
      builder: (context, state) {
        if (state.status == AuthStatus.invalidToken)
          print("ERROR: invalidToken 1");
        switch (state.status) {
          case AuthStatus.initial:
          case AuthStatus.invalidToken:
            return WebView(
              initialUrl: authUrl,
              userAgent: 'Mozilla/5.0 (Linux; Android 6.0; Nexus 5 Build/MRA58N) '
                  'AppleWebKit/537.36 (KHTML, like Gecko) Chrome/62.0.3202.94 Mobile Safari/537.36',
              javascriptMode: JavascriptMode.unrestricted,
              onWebViewCreated: (controller) {
                print("onWebViewCreated");
              },
              navigationDelegate: (request) {
                if (request.url.startsWith(redirectUrlWithCode)) {
                  String code = request.url.substring(redirectUrlWithCode.length);
                  print("GOT CODE ! $code");
                  context.read<AuthBloc>().add(AuthGotCode(code));
                  return NavigationDecision.prevent;
                }
                return NavigationDecision.navigate;
              },
            );
          case AuthStatus.loading:
          case AuthStatus.success:
            return const LoaderWidget();
        }
      },
    );
  }
}
