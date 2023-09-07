import 'package:cached_network_image/cached_network_image.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:news_api/shared/cubit/states.dart';

BottomNavigationBarItem bottomNavItem({
  required String label,
  required IconData icon,
}) =>
    BottomNavigationBarItem(
      label: label,
      icon: Icon(icon),
    );

Widget articleItem(
  context, {
  required Map model,
  required Function(BuildContext, Map) onTap,
}) =>
    InkWell(
      onTap: () =>
          onTap(context, {'url': model['url'], 'title': model['title']}),
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Row(
          children: [
            SizedBox(
              width: 120,
              height: 120,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: model['urlToImage'] != null
                    ? CachedNetworkImage(
                        imageUrl: '${model['urlToImage']}',
                        imageBuilder: (context, imageProvider) => Image(
                          image: imageProvider,
                          fit: BoxFit.cover,
                        ),
                        placeholder: (context, url) =>
                            const Center(child: CircularProgressIndicator()),
                        errorWidget: (context, url, error) => Image.asset(
                          'assets/images/article_empty.jpg',
                          fit: BoxFit.cover,
                        ),
                      )
                    : Image.asset(
                        'assets/images/article_empty.jpg',
                        fit: BoxFit.cover,
                      ),
              ),
            ),
            const SizedBox(width: 10),
            Expanded(
              child: SizedBox(
                height: 120,
                child: Column(
                  // mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: Text(
                        '${model['title']}',
                        maxLines: 3,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                    Text(
                      '${model['publishedAt']}',
                      style: const TextStyle(
                        color: Colors.grey,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );

Widget articleItemSeparator() => Padding(
      padding: const EdgeInsetsDirectional.only(start: 20),
      child: Container(
        width: double.infinity,
        height: 1,
        color: Colors.grey.withOpacity(0.5),
      ),
    );

Widget emptyArticles() => Center(
      child: LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constraints) =>
            SingleChildScrollView(
          physics: const AlwaysScrollableScrollPhysics(),
          child: SizedBox(
            height: constraints.maxHeight,
            child: Column(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(Icons.article),
                const SizedBox(height: 10),
                Text(
                  'No articles found!',
                  style: TextStyle(
                    color: Colors.grey[600],
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );

Widget articlesBuilder({
  required dynamic state,
  required List<dynamic> articles,
  required Function(BuildContext, Map) onTap,
  bool search = false,
}) =>
    ConditionalBuilder(
      condition: search
          ? state is! LoadingSearchPageState
          : state is! LoadingHomeLayoutState,
      builder: (context) => ConditionalBuilder(
        condition: articles.isNotEmpty,
        builder: (context) => Scrollbar(
          child: ListView.separated(
            physics: const BouncingScrollPhysics(),
            itemBuilder: (context, index) => articleItem(
              context,
              model: articles[index],
              onTap: onTap,
            ),
            separatorBuilder: (context, index) => articleItemSeparator(),
            itemCount: articles.length,
          ),
        ),
        fallback: (context) => emptyArticles(),
      ),
      fallback: (context) => const Center(child: CircularProgressIndicator()),
    );
