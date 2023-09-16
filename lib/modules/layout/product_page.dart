import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop/models/products_model.dart';
import 'package:shop/shared/components/classes/constants.dart';
import 'package:shop/shared/cubit/cubit.dart';
import 'package:shop/shared/cubit/states.dart';
import 'package:shop/styles/colors.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class ProductPage extends StatelessWidget {
  final ProductModel model;

  const ProductPage({Key? key, required this.model}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ProductCubit(model: model)..loadyLayout(),
      child: BlocConsumer<ProductCubit, ProductStates>(
        listener: (context, state) {},
        builder: (context, state) {
          ProductCubit cubit = ProductCubit.get(context);

          return Scaffold(
            appBar: AppBar(
              title: const Text('Salla'),
            ),
            body: SafeArea(
              child: Expanded(
                child: Scrollbar(
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        const SizedBox(height: 20),
                        Padding(
                          padding: const EdgeInsetsDirectional.symmetric(horizontal: 20),
                          child: Text(model.name),
                        ),
                        const SizedBox(height: 20),
                        Column(
                          children: [
                            Container(
                              height: 350,
                              color: Colors.white,
                              child: Stack(
                                alignment: AlignmentDirectional.topStart,
                                children: [
                                  Stack(
                                    alignment: AlignmentDirectional.bottomEnd,
                                    children: [
                                      Padding(
                                        padding: const EdgeInsetsDirectional.symmetric(horizontal: 10),
                                        child: PageView.builder(
                                          controller: cubit.pageController,
                                          itemBuilder: (context, index) => CachedNetworkImage(
                                            imageUrl: cubit.imagesList[index].toString(),
                                            height: 350,
                                            imageBuilder: (context, imageProvider) => Image(image: imageProvider),
                                            placeholder: (context, url) =>
                                                const Center(child: CircularProgressIndicator()),
                                            errorWidget: (context, url, error) => Container(color: bgColor(context)),
                                          ),
                                          itemCount: cubit.imagesList.length,
                                          onPageChanged: cubit.changeIndex,
                                        ),
                                      ),
                                      IconButton(
                                        onPressed: () => cubit.setFavorite(context, model: model), // favorite
                                        icon: model.inFavorites
                                            ? const Icon(Icons.favorite, color: Colors.red)
                                            : const Icon(Icons.favorite_border),
                                        style: ButtonStyle(backgroundColor: MaterialStatePropertyAll(bgColor(context))),
                                      ),
                                    ],
                                  ),
                                  if (model.discount > 0)
                                    Padding(
                                      padding: const EdgeInsets.all(5),
                                      child: CircleAvatar(
                                        backgroundColor: Colors.red[900],
                                        radius: 25,
                                        child: Text(
                                          '${model.discount.toStringAsFixed(0)}%\noff',
                                          textAlign: TextAlign.center,
                                          style: const TextStyle(
                                            color: Colors.white,
                                            fontSize: 13,
                                          ),
                                        ),
                                      ),
                                    ),
                                ],
                              ),
                            ),
                            const SizedBox(height: 20),
                            SmoothPageIndicator(
                              controller: cubit.pageController,
                              count: cubit.imagesList.length,
                              effect: ExpandingDotsEffect(
                                dotColor: Colors.grey,
                                activeDotColor: selectedColor(context),
                                // spacing: 8,
                                expansionFactor: 1.01,
                                dotHeight: 10,
                                dotWidth: 10,
                              ),
                            ),
                          ],
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20),
                          child: Column(
                            children: [
                              if (model.discount > 0)
                                SizedBox(
                                  width: double.infinity,
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      const SizedBox(height: 20),
                                      Container(
                                        padding: const EdgeInsetsDirectional.symmetric(horizontal: 5),
                                        decoration: BoxDecoration(
                                          color: Colors.red[700],
                                          borderRadius: BorderRadius.circular(2),
                                        ),
                                        child: const Text(
                                          'Deal',
                                          style: TextStyle(
                                            color: Colors.white,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  if (model.discount > 0)
                                    Row(
                                      children: [
                                        Text(
                                          '-${decimalFormatZeros(model.discount)}%',
                                          style: TextStyle(
                                            color: Colors.red[600],
                                            fontSize: 30,
                                          ),
                                        ),
                                        const SizedBox(width: 10),
                                      ],
                                    ),
                                  const Padding(
                                    padding: EdgeInsetsDirectional.only(top: 8),
                                    child: Text(
                                      'EGP',
                                      style: TextStyle(fontSize: 11),
                                    ),
                                  ),
                                  Text(
                                    decimalFormatZeros(model.price),
                                    style: const TextStyle(fontSize: 30),
                                  ),
                                ],
                              ),
                              if (model.discount > 0)
                                Row(
                                  children: [
                                    const Text(
                                      'List Price: ',
                                      style: TextStyle(
                                        fontSize: 12,
                                        color: Colors.grey,
                                      ),
                                    ),
                                    Text(
                                      'EGP${decimalFormatZeros(model.oldPrice)}',
                                      style: const TextStyle(
                                        fontSize: 12,
                                        color: Colors.grey,
                                        decoration: TextDecoration.lineThrough,
                                      ),
                                    ),
                                  ],
                                ),
                              const SizedBox(height: 20),
                              Text(model.description.trim()),
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
