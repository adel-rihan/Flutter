import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop/main.dart';
import 'package:shop/shared/components/classes/auth_validator.dart';
import 'package:shop/shared/components/classes/components.dart';
import 'package:shop/shared/components/classes/formatters.dart';
import 'package:shop/shared/components/controls/custom_input_field.dart';
import 'package:shop/shared/cubit/cubit.dart';
import 'package:shop/shared/cubit/states.dart';

class UpdateProfilePage extends StatelessWidget {
  const UpdateProfilePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => UpdateProfileCubit(),
      child: BlocConsumer<UpdateProfileCubit, UpdateProfileStates>(
        listener: (context, state) {
          // print(state.toString());
        },
        builder: (context, state) {
          UpdateProfileCubit cubit = UpdateProfileCubit.get(context);

          return Scaffold(
            body: SafeArea(
              child: Scrollbar(
                child: SingleChildScrollView(
                  child: Form(
                    key: cubit.updateProfileFormKey,
                    child: Padding(
                      padding: const EdgeInsets.all(20),
                      child: Column(
                        children: [
                          headingWidgetWithBackButton(
                            context: context,
                            title: 'Update Profile',
                            bottomHeight: 20,
                          ),
                          Stack(
                            alignment: AlignmentDirectional.bottomEnd,
                            children: [
                              cubit.image != null
                                  ? Container(
                                      width: 150,
                                      height: 150,
                                      decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        image: DecorationImage(
                                          image: FileImage(cubit.image!),
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                    )
                                  : CachedNetworkImage(
                                      imageUrl: userModel.image,
                                      width: 150,
                                      height: 150,
                                      imageBuilder: (context, imageProvider) => Container(
                                        decoration: BoxDecoration(
                                          shape: BoxShape.circle,
                                          image: DecorationImage(
                                            image: imageProvider,
                                            fit: BoxFit.cover,
                                          ),
                                        ),
                                      ),
                                      placeholder: (context, url) => const Center(child: CircularProgressIndicator()),
                                      errorWidget: (context, url, error) => Image.asset('assets/images/avatar.png'),
                                    ),
                              customIconButton(
                                context: context,
                                icon: Icons.edit,
                                onPressed: () => cubit.editPhoto(context),
                              ),
                            ],
                          ),
                          const SizedBox(height: 40),
                          CustomInputField(
                            controller: cubit.nameInput,
                            labelText: 'Name',
                            validator: isFieldEmpty,
                            inputFormatters: [nameFormatter],
                            textType: TextInputType.name,
                            prefixIcon: Icons.abc_outlined,
                          ),
                          const SizedBox(height: 15),
                          CustomInputField(
                            controller: cubit.emailInput,
                            labelText: 'Email',
                            validator: isEmailValid,
                            inputFormatters: [noSpaceFormatter],
                            textType: TextInputType.emailAddress,
                            prefixIcon: Icons.email_outlined,
                          ),
                          const SizedBox(height: 15),
                          CustomInputField(
                            controller: cubit.phoneInput,
                            labelText: 'Mobile No.',
                            validator: isFieldEmpty,
                            inputFormatters: [digitsFormatter],
                            textType: TextInputType.number,
                            prefixIcon: Icons.phone_outlined,
                          ),
                          const SizedBox(height: 20),
                          customButton(
                            innerText: 'Save',
                            onPressed: () => cubit.updateProfile(context),
                          ),
                        ],
                      ),
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
