import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop/shared/components/classes/components.dart';
import 'package:shop/shared/cubit/cubit.dart';
import 'package:shop/shared/cubit/states.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit, ShopStates>(
      listener: (context, state) {},
      builder: (context, state) {
        ShopCubit cubit = ShopCubit.get(context);

        return ConditionalBuilder(
          condition: cubit.homeModel != null &&
              cubit.categoriesModel != null &&
              cubit.homeModel!.products.isNotEmpty &&
              cubit.categoriesModel!.categories.isNotEmpty,
          builder: (context) => Scrollbar(
            child: SingleChildScrollView(
              physics: const AlwaysScrollableScrollPhysics(),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CarouselSlider(
                    items: cubit.homeModel!.banners
                        .map(
                          (e) => CachedNetworkImage(
                            imageUrl: e.image,
                            imageBuilder: (context, imageProvider) => Image(
                              image: imageProvider,
                              fit: BoxFit.cover,
                            ),
                            placeholder: (context, url) => const Center(child: CircularProgressIndicator()),
                            errorWidget: (context, url, error) => Container(color: Colors.white),
                          ),
                        )
                        .toList(),
                    options: CarouselOptions(
                      height: 250,
                      initialPage: 0,
                      viewportFraction: 1,
                      enableInfiniteScroll: true,
                      autoPlay: true,
                      autoPlayInterval: const Duration(seconds: 3),
                      autoPlayAnimationDuration: const Duration(seconds: 1),
                      autoPlayCurve: Curves.fastOutSlowIn,
                      scrollDirection: Axis.horizontal,
                    ),
                  ),
                  const SizedBox(height: 20),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Categories',
                          style: TextStyle(fontSize: 24.0, fontWeight: FontWeight.w800),
                        ),
                        const SizedBox(height: 10.0),
                        SizedBox(
                          height: 110,
                          child: ListView.separated(
                            shrinkWrap: false,
                            physics: const BouncingScrollPhysics(),
                            scrollDirection: Axis.horizontal,
                            itemBuilder: (context, index) => catergoryItemHome(
                              context,
                              model: cubit.categoriesModel!.categories[index],
                            ),
                            separatorBuilder: (context, index) => const SizedBox(width: 20),
                            itemCount: cubit.categoriesModel!.categories.length,
                          ),
                        ),
                        const SizedBox(height: 20.0),
                        const Text(
                          'New Products',
                          style: TextStyle(fontSize: 24.0, fontWeight: FontWeight.w800),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 10),
                  GridView(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      mainAxisSpacing: 1,
                      crossAxisSpacing: 1,
                      mainAxisExtent: 300,
                    ),
                    children: List.generate(
                      cubit.homeModel!.products.length,
                      (index) => productItem(
                        context,
                        model: cubit.homeModel!.products[index],
                        favorite: () {
                          cubit.setFavorite(context, model: cubit.homeModel!.products[index]);
                        },
                        onTap: () => cubit.openProduct(context, model: cubit.homeModel!.products[index]),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          fallback: (context) => const Center(child: CircularProgressIndicator()),
        );
      },
    );
  }
}
