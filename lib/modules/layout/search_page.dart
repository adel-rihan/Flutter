import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop/shared/components/classes/components.dart';
import 'package:shop/shared/components/classes/formatters.dart';
import 'package:shop/shared/components/controls/custom_input_field.dart';
import 'package:shop/shared/cubit/cubit.dart';
import 'package:shop/shared/cubit/states.dart';

class SearchPage extends StatelessWidget {
  const SearchPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => SearchCubit(),
      child: BlocConsumer<SearchCubit, SearchStates>(
        listener: (context, state) {},
        builder: (context, state) {
          SearchCubit cubit = SearchCubit.get(context);

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
                  onPressed: () => cubit.getSearch(context),
                  icon: const Icon(Icons.search),
                ),
                onSubmit: (value) => cubit.getSearch(context),
              ),
            ),
            body: SafeArea(
              child: ConditionalBuilder(
                condition: !cubit.searching && cubit.searchModel != null && cubit.searchModel!.products.isNotEmpty,
                builder: (context) => Scrollbar(
                  child: SingleChildScrollView(
                    child: ListView.separated(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemBuilder: (context, index) => productItemList(
                        context,
                        model: cubit.searchModel!.products[index],
                        favorite: () {
                          cubit.setFavorite(context, model: cubit.searchModel!.products[index]);
                        },
                        onTap: () => cubit.openProduct(context, model: cubit.searchModel!.products[index]),
                      ),
                      separatorBuilder: (BuildContext context, int index) => itemSeparator(),
                      itemCount: cubit.searchModel!.products.length,
                    ),
                  ),
                ),
                fallback: (context) => ConditionalBuilder(
                  condition: !cubit.searching,
                  builder: (context) => Container(),
                  fallback: (context) => const Center(child: CircularProgressIndicator()),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
