import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop/shared/components/classes/components.dart';
import 'package:shop/shared/cubit/cubit.dart';
import 'package:shop/shared/cubit/states.dart';

class FavoritesScreen extends StatelessWidget {
  const FavoritesScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit, ShopStates>(
      listener: (context, state) {},
      builder: (context, state) {
        ShopCubit cubit = ShopCubit.get(context);

        return ConditionalBuilder(
          condition: cubit.productsModel != null && cubit.productsModel!.favorites.isNotEmpty,
          builder: (context) => Scrollbar(
            child: SingleChildScrollView(
              physics: const AlwaysScrollableScrollPhysics(),
              child: ListView.separated(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemBuilder: (context, index) => productItemList(
                  context,
                  model: cubit.productsModel!.favorites[index],
                  favorite: () {
                    cubit.setFavorite(context, model: cubit.productsModel!.favorites[index]);
                  },
                  onTap: () => cubit.openProduct(context, model: cubit.productsModel!.favorites[index]),
                ),
                separatorBuilder: (BuildContext context, int index) => itemSeparator(),
                itemCount: cubit.productsModel!.favorites.length,
              ),
            ),
          ),
          fallback: (context) => ConditionalBuilder(
            condition: cubit.productsModel != null && cubit.productsModel!.favorites.isEmpty,
            builder: (context) => Container(),
            fallback: (context) => const Center(child: CircularProgressIndicator()),
          ),
        );
      },
    );
  }
}
