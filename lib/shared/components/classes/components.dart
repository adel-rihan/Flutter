import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:shop/models/boarding_model.dart';
import 'package:shop/models/categories_model.dart';
import 'package:shop/models/products_model.dart';
import 'package:shop/shared/components/classes/constants.dart';
import 'package:shop/styles/colors.dart';

Widget onBoardingItem({
  required BoardingModel model,
}) =>
    Padding(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Image(
            image: AssetImage(model.image),
            fit: BoxFit.fitWidth,
          ),
          const SizedBox(height: 30),
          Text(
            model.title,
            style: const TextStyle(fontSize: 24),
          ),
          const SizedBox(height: 15),
          Text(
            model.body,
            style: const TextStyle(fontSize: 14),
          ),
        ],
      ),
    );

Widget productItem(
  context, {
  required ProductModel model,
  required void Function()? favorite,
  required void Function()? onTap,
}) =>
    GestureDetector(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsetsDirectional.all(7),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              color: Colors.white,
              child: Stack(
                alignment: AlignmentDirectional.bottomStart,
                children: [
                  Stack(
                    alignment: AlignmentDirectional.topEnd,
                    children: [
                      Center(
                        child: CachedNetworkImage(
                          imageUrl: model.image,
                          height: 200,
                          imageBuilder: (context, imageProvider) => Image(image: imageProvider),
                          placeholder: (context, url) => const Center(child: CircularProgressIndicator()),
                          errorWidget: (context, url, error) => Container(color: bgColor(context)),
                        ),
                      ),
                      IconButton(
                        onPressed: favorite,
                        icon: model.inFavorites
                            ? const Icon(Icons.favorite, color: Colors.red)
                            : const Icon(Icons.favorite_border),
                        style: ButtonStyle(backgroundColor: MaterialStatePropertyAll(bgColor(context))),
                      ),
                    ],
                  ),
                  if (model.discount > 0)
                    Container(
                      color: Colors.red[900],
                      padding: const EdgeInsetsDirectional.symmetric(horizontal: 5),
                      child: Text(
                        'Discount ${decimalFormatZeros(model.discount)}%'.toUpperCase(),
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 11,
                        ),
                      ),
                    ),
                ],
              ),
            ),
            const SizedBox(height: 5),
            Text(
              model.name,
              overflow: TextOverflow.ellipsis,
              maxLines: 2,
              style: const TextStyle(height: 1.1),
            ),
            const Spacer(),
            Row(
              children: [
                Text(
                  '${decimalFormatZeros(model.price)} EGP',
                  overflow: TextOverflow.ellipsis,
                  maxLines: 2,
                  style: TextStyle(
                    fontSize: 12,
                    color: textFGColorPrimary(context),
                  ),
                ),
                if (model.discount > 0)
                  Row(
                    children: [
                      const SizedBox(width: 5),
                      Text(
                        '${decimalFormatZeros(model.oldPrice)} EGP',
                        overflow: TextOverflow.ellipsis,
                        maxLines: 2,
                        style: const TextStyle(
                          fontSize: 12,
                          color: Colors.grey,
                          decoration: TextDecoration.lineThrough,
                        ),
                      ),
                    ],
                  ),
              ],
            ),
          ],
        ),
      ),
    );

Widget catergoryItemHome(
  context, {
  required CategoryModel model,
}) =>
    SizedBox(
      width: 70,
      child: Column(
        children: [
          CachedNetworkImage(
            height: 70,
            width: 70,
            imageUrl: model.image,
            imageBuilder: (context, imageProvider) => Image(
              image: imageProvider,
              fit: BoxFit.cover,
            ),
            placeholder: (context, url) => const Center(child: CircularProgressIndicator()),
            errorWidget: (context, url, error) => Container(color: bgColor(context)),
          ),
          const SizedBox(width: 20),
          Text(
            model.name,
            style: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.bold,
            ),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
        ],
      ),
    );

Widget catergoryItem(
  context, {
  required CategoryModel model,
}) =>
    Padding(
      padding: const EdgeInsets.all(20),
      child: Row(
        children: [
          CachedNetworkImage(
            height: 50,
            width: 50,
            imageUrl: model.image,
            imageBuilder: (context, imageProvider) => Image(
              image: imageProvider,
              fit: BoxFit.cover,
            ),
            placeholder: (context, url) => const Center(child: CircularProgressIndicator()),
            errorWidget: (context, url, error) => Container(color: bgColor(context)),
          ),
          const SizedBox(width: 15),
          Expanded(
            child: Text(
              model.name,
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
              maxLines: 2,
            ),
          ),
          const SizedBox(width: 15),
          const Icon(
            Icons.arrow_forward_ios,
            size: 18,
            // color: unSelectedColor,
          ),
        ],
      ),
    );

Widget productItemList(
  context, {
  required ProductModel model,
  required void Function()? favorite,
  required void Function()? onTap,
}) =>
    GestureDetector(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: SizedBox(
          height: 120,
          child: Row(
            children: [
              Container(
                color: Colors.white,
                child: Stack(
                  alignment: AlignmentDirectional.bottomStart,
                  children: [
                    Center(
                      child: CachedNetworkImage(
                        imageUrl: model.image,
                        height: 120,
                        width: 120,
                        imageBuilder: (context, imageProvider) => Image(image: imageProvider),
                        placeholder: (context, url) => const Center(child: CircularProgressIndicator()),
                        errorWidget: (context, url, error) => Container(color: bgColor(context)),
                      ),
                    ),
                    if (model.discount > 0)
                      Container(
                        color: Colors.red[900],
                        padding: const EdgeInsetsDirectional.symmetric(horizontal: 5),
                        child: Text(
                          'Discount ${decimalFormatZeros(model.discount)}%'.toUpperCase(),
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 11,
                          ),
                        ),
                      ),
                  ],
                ),
              ),
              const SizedBox(width: 15),
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: Text(
                        model.name,
                        overflow: TextOverflow.ellipsis,
                        maxLines: 4,
                        style: const TextStyle(height: 1.1),
                      ),
                    ),
                    // const Spacer(),
                    Row(
                      children: [
                        Text(
                          '${decimalFormatZeros(model.price)} EGP',
                          overflow: TextOverflow.ellipsis,
                          maxLines: 2,
                          style: TextStyle(
                            fontSize: 12,
                            color: textFGColorPrimary(context),
                          ),
                        ),
                        if (model.discount > 0)
                          Row(
                            children: [
                              const SizedBox(width: 5),
                              Text(
                                '${decimalFormatZeros(model.oldPrice)} EGP',
                                overflow: TextOverflow.ellipsis,
                                maxLines: 2,
                                style: const TextStyle(
                                  fontSize: 12,
                                  color: Colors.grey,
                                  decoration: TextDecoration.lineThrough,
                                ),
                              ),
                            ],
                          ),
                        const Spacer(),
                        IconButton(
                          onPressed: favorite,
                          icon: model.inFavorites
                              ? const Icon(Icons.favorite, color: Colors.red)
                              : const Icon(Icons.favorite_border),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );

Widget itemSeparator() => Padding(
      padding: const EdgeInsetsDirectional.only(start: 20),
      child: Container(
        width: double.infinity,
        height: 1,
        color: Colors.grey.withOpacity(0.5),
      ),
    );

///
Widget customButton({
  required String innerText,
  required void Function() onPressed,
  bool Function()? isEnabled,
}) =>
    SizedBox(
      width: double.infinity,
      height: 45,
      child: ElevatedButton(
        onPressed: isEnabled == null
            ? onPressed
            : isEnabled() == true
                ? onPressed
                : null,
        style: ElevatedButton.styleFrom(
          // backgroundColor: buttonBGColor,
          side: BorderSide.none,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(5.0),
          ), // const StadiumBorder()
          textStyle: const TextStyle(
            fontSize: 18,
            // color: buttonFGColor,
            fontWeight: FontWeight.bold,
          ),
        ),
        child: Text(innerText),
      ),
    );

Widget customTextButton({
  required BuildContext context,
  required String innerText,
  required void Function() onPressed,
  Alignment alignment = Alignment.center,
}) =>
    Container(
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 0), // 3
      alignment: alignment,
      child: GestureDetector(
        onTap: onPressed,
        child: Text(
          innerText,
          style: TextStyle(
            color: textFGColorPrimary(context),
            fontSize: 13,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );

Widget customTextButton2({
  required BuildContext context,
  required String innerText,
  required String innerText2,
  required void Function() onPressed,
  MainAxisAlignment alignment = MainAxisAlignment.center,
}) =>
    SizedBox(
      child: Row(
        mainAxisAlignment: alignment,
        children: [
          Text(
            '$innerText ',
            style: const TextStyle(
              fontSize: 13,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(width: 5),
          GestureDetector(
            onTap: onPressed,
            child: Text(
              innerText2,
              style: TextStyle(
                fontSize: 15,
                color: textFGColorPrimary(context),
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    );

Widget profileMenuWidget({
  required String title,
  required IconData icon,
  required VoidCallback onPress,
  bool endIcon = true,
  Color? textColor,
}) =>
    ListTile(
      onTap: onPress,
      contentPadding: const EdgeInsetsDirectional.symmetric(horizontal: 8),
      leading: SizedBox(
        width: 30,
        height: 30,
        child: (textColor == null)
            ? Icon(
                icon,
                size: 20,
              )
            : Icon(
                icon,
                color: textColor,
                size: 20,
              ),
      ),
      title: (textColor == null)
          ? Text(
              title,
              style: const TextStyle(fontSize: 16),
            )
          : Text(
              title,
              style: TextStyle(
                color: textColor,
                fontSize: 16,
              ),
            ),
      trailing: endIcon
          ? const SizedBox(
              width: 30,
              height: 30,
              child: Icon(
                Icons.chevron_right,
                size: 20,
                // color: unSelectedColor,
              ),
            )
          : null,
    );

Widget profileMenuSwitchWidget({
  required String title,
  required bool value,
  required IconData icon,
  required VoidCallback onPress,
  Color? textColor,
}) =>
    ListTile(
      contentPadding: const EdgeInsetsDirectional.symmetric(horizontal: 8),
      leading: SizedBox(
        width: 30,
        height: 30,
        child: (textColor == null)
            ? Icon(
                icon,
                size: 20,
              )
            : Icon(
                icon,
                color: textColor,
                size: 20,
              ),
      ),
      title: (textColor == null)
          ? Text(
              title,
              style: const TextStyle(fontSize: 16),
            )
          : Text(
              title,
              style: TextStyle(
                color: textColor,
                fontSize: 16,
              ),
            ),
      trailing: SizedBox(
        width: 55, // 60
        height: 44, // 48
        child: FittedBox(
          fit: BoxFit.fill,
          child: Switch(
            value: value,
            onChanged: (value) => onPress(),
          ),
        ),
      ),
    );

Widget profileDivider() => Divider(color: Colors.grey.withOpacity(0.5));

Widget headingWidget({
  required String title,
  double topHeight = 10,
  double bottomHeight = 40,
}) =>
    Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(height: topHeight),
        Text(
          title = title,
          textAlign: TextAlign.center,
          style: const TextStyle(
            fontSize: 30,
          ),
        ),
        SizedBox(height: bottomHeight),
      ],
    );

Widget headingWidgetWithBackButton({
  required BuildContext context,
  required String title,
  double topHeight = 10,
  double bottomHeight = 40,
}) =>
    Column(
      children: [
        SizedBox(height: topHeight),
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            GestureDetector(
              onTap: () => Navigator.pop(context),
              child: const Icon(
                Icons.chevron_left,
                size: 40,
              ),
            ),
            const SizedBox(width: 15),
            Text(
              title,
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
        SizedBox(height: bottomHeight),
      ],
    );

BottomNavigationBarItem bottomNavItem({
  required String label,
  required IconData icon,
}) =>
    BottomNavigationBarItem(
      label: label,
      icon: Icon(icon),
    );

Widget customIconButton({
  required BuildContext context,
  required IconData icon,
  required void Function() onPressed,
}) =>
    Container(
      width: 35,
      height: 35,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(100),
        color: textFGColorPrimary2(context),
      ),
      child: IconButton(
        onPressed: onPressed,
        padding: const EdgeInsets.all(0),
        icon: Icon(
          icon,
          size: 20,
          color: Colors.white,
        ),
      ),
    );
