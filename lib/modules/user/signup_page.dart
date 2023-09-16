import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop/shared/components/classes/auth_validator.dart';
import 'package:shop/shared/components/classes/components.dart';
import 'package:shop/shared/components/classes/formatters.dart';
import 'package:shop/shared/components/controls/custom_input_field.dart';
import 'package:shop/shared/cubit/cubit.dart';
import 'package:shop/shared/cubit/states.dart';

class SignUpPage extends StatelessWidget {
  const SignUpPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => SignUpCubit(),
      child: BlocConsumer<SignUpCubit, SignUpStates>(
        listener: (context, state) {},
        builder: (context, state) {
          SignUpCubit cubit = SignUpCubit.get(context);

          return Scaffold(
            body: SafeArea(
              child: Scrollbar(
                child: SingleChildScrollView(
                  child: Form(
                    key: cubit.signupFormKey,
                    child: Padding(
                      padding: const EdgeInsets.all(20),
                      child: Column(
                        children: [
                          headingWidgetWithBackButton(
                            context: context,
                            title: 'Sign-up Details',
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
                                  : Image.asset(
                                      'assets/images/avatar.png',
                                      width: 150,
                                      height: 150,
                                    ),
                              customIconButton(
                                context: context,
                                icon: Icons.edit,
                                onPressed: () => cubit.selectPhoto(context),
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
                          const SizedBox(height: 15),
                          CustomInputField(
                            controller: cubit.passwordInput,
                            labelText: 'Password',
                            obscureText: true,
                            validator: isPasswordValid,
                            onChange: cubit.refreshPassword,
                            inputFormatters: [noSpaceFormatter],
                            prefixIcon: Icons.lock_outlined,
                          ),
                          const SizedBox(height: 15),
                          CustomInputField(
                            controller: cubit.passwordRetryInput,
                            labelText: 'Retry Password',
                            obscureText: true,
                            validator: (value) {
                              return isPasswordValid2(value, cubit.password);
                            },
                            inputFormatters: [noSpaceFormatter],
                            prefixIcon: Icons.lock_outlined,
                          ),
                          const SizedBox(height: 20),
                          customButton(
                            innerText: 'Register',
                            onPressed: () => cubit.signUp(context),
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
