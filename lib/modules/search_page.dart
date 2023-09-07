import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_api/shared/components/classes/components.dart';
import 'package:news_api/shared/components/classes/formatters.dart';
import 'package:news_api/shared/components/controls/custom_input_field.dart';
import 'package:news_api/shared/cubit/cubit.dart';
import 'package:news_api/shared/cubit/states.dart';

class SearchPage extends StatelessWidget {
  const SearchPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => SearchPageCubit(),
      child: BlocConsumer<SearchPageCubit, SearchPageStates>(
        listener: (context, state) {},
        builder: (context, state) {
          SearchPageCubit cubit = SearchPageCubit.get(context);

          return Scaffold(
            appBar: AppBar(
              title: CustomInputField(
                controller: cubit.searchInput,
                labelText: 'search..',
                hint: true,
                inputFormatters: [nameFormatter],
                textType: TextInputType.text,
                maxLength: 25,
                suffixIcon: IconButton(
                  onPressed: cubit.getSearch,
                  icon: const Icon(Icons.search),
                ),
                onChange: (value) {
                  cubit.getSearch();
                },
              ),
            ),
            body: SafeArea(
              child: articlesBuilder(
                state: state,
                articles: cubit.searchArticles,
                search: true,
              ),
            ),
          );
        },
      ),
    );
  }
}
