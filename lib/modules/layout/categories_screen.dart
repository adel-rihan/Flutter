import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop/shared/components/classes/components.dart';
import 'package:shop/shared/cubit/cubit.dart';
import 'package:shop/shared/cubit/states.dart';

class CategoriesScreen extends StatelessWidget {
  const CategoriesScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit, ShopStates>(
      listener: (context, state) {},
      builder: (context, state) {
        ShopCubit cubit = ShopCubit.get(context);

        return ConditionalBuilder(
          condition: cubit.categoriesModel != null && cubit.categoriesModel!.categories.isNotEmpty,
          builder: (context) => Scrollbar(
            child: SingleChildScrollView(
              physics: const AlwaysScrollableScrollPhysics(),
              child: ListView.separated(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemBuilder: (context, index) => catergoryItem(
                  context,
                  model: cubit.categoriesModel!.categories[index],
                ),
                separatorBuilder: (BuildContext context, int index) => itemSeparator(),
                itemCount: cubit.categoriesModel!.categories.length,
              ),
            ),
          ),
          fallback: (context) => const Center(child: CircularProgressIndicator()),
        );
      },
    );
  }
}
