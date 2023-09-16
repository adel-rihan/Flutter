import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';
import 'package:shop/main.dart';
import 'package:shop/shared/components/classes/components.dart';
import 'package:shop/shared/cubit/cubit.dart';
import 'package:shop/shared/cubit/states.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit, ShopStates>(
      listener: (context, state) {},
      builder: (context, state) {
        ShopCubit cubit = ShopCubit.get(context);

        return Scrollbar(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                children: [
                  Stack(
                    alignment: AlignmentDirectional.bottomEnd,
                    children: [
                      CachedNetworkImage(
                        imageUrl: userModel.image,
                        width: 150,
                        height: 150,
                        imageBuilder: (context, imageProvider) => Container(
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            image: DecorationImage(image: imageProvider, fit: BoxFit.cover),
                          ),
                        ),
                        placeholder: (context, url) => const Center(child: CircularProgressIndicator()),
                        errorWidget: (context, url, error) => Image.asset('assets/images/avatar.png'),
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                  Text(
                    userModel.name,
                    style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                  ),
                  const SizedBox(height: 5),
                  Text(userModel.email),
                  const SizedBox(height: 20),
                  SizedBox(
                    width: 180,
                    child: customButton(
                      innerText: 'Edit Profile',
                      onPressed: () => cubit.editProfile(context),
                    ),
                  ),
                  const SizedBox(height: 30),
                  profileDivider(),
                  const SizedBox(height: 10),
                  profileMenuSwitchWidget(
                    title: "Dark Mode",
                    value: darkMode,
                    icon: LineAwesomeIcons.moon,
                    onPress: () => cubit.darkModeChange(),
                  ),
                  // profileMenuWidget(
                  //   title: "Settings",
                  //   icon: LineAwesomeIcons.cog,
                  //   onPress: () {},
                  // ),
                  profileMenuWidget(
                    title: "Change Password",
                    icon: LineAwesomeIcons.lock,
                    onPress: () => cubit.changePassword(context),
                  ),
                  // profileMenuWidget(
                  //   title: "Info",
                  //   icon: LineAwesomeIcons.info,
                  //   onPress: () {},
                  // ),
                  // profileMenuWidget(
                  //   title: "Contact Us",
                  //   icon: LineAwesomeIcons.phone,
                  //   onPress: () {},
                  // ),
                  profileMenuWidget(
                    title: "Logout",
                    icon: LineAwesomeIcons.alternate_sign_out,
                    textColor: Colors.red,
                    endIcon: false,
                    onPress: () => cubit.signOut(context),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
