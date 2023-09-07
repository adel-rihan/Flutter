import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_api/shared/cubit/cubit.dart';
import 'package:news_api/shared/cubit/states.dart';
import 'package:webview_flutter/webview_flutter.dart';

class WebViewPage extends StatelessWidget {
  const WebViewPage({super.key});

  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context)!.settings.arguments as Map;

    return BlocProvider(
      create: (context) => WebViewPageCubit(args)..loadLayout(context),
      child: BlocConsumer<WebViewPageCubit, WebViewPageStates>(
        listener: (context, state) {},
        builder: (context, state) {
          WebViewPageCubit cubit = WebViewPageCubit.get(context);

          return Scaffold(
            appBar: AppBar(
              title: Text(cubit.title),
              bottom: PreferredSize(
                preferredSize: const Size.fromHeight(5),
                child: Visibility(
                  visible: cubit.progressValue < 1,
                  child: SizedBox(
                    height: 5,
                    child: LinearProgressIndicator(
                      value: cubit.progressValue,
                    ),
                  ),
                ),
              ),
            ),
            body: WebViewWidget(controller: cubit.webviewController),
          );
        },
      ),
    );
  }
}
