import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop/shared/components/classes/auth_validator.dart';
import 'package:shop/shared/components/classes/components.dart';
import 'package:shop/shared/components/classes/formatters.dart';
import 'package:shop/shared/components/controls/custom_input_field.dart';
import 'package:shop/shared/cubit/cubit.dart';
import 'package:shop/shared/cubit/states.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => LoginCubit(),
      child: BlocConsumer<LoginCubit, LoginStates>(
        listener: (context, state) {},
        builder: (context, state) {
          LoginCubit cubit = LoginCubit.get(context);

          return Scaffold(
            body: SingleChildScrollView(
              child: SafeArea(
                child: Form(
                  key: cubit.loginFormKey,
                  child: Padding(
                    padding: const EdgeInsets.all(20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        headingWidget(
                          title: 'Login'.toUpperCase(),
                          topHeight: 50,
                          bottomHeight: 10,
                        ),
                        Text(
                          'Login now to browse our hot offers',
                          style: Theme.of(context).textTheme.bodyMedium?.copyWith(color: Colors.grey),
                        ),
                        const SizedBox(height: 30),
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
                          controller: cubit.passwordInput,
                          labelText: 'Password',
                          obscureText: true,
                          validator: isPasswordValid,
                          inputFormatters: [noSpaceFormatter],
                          prefixIcon: Icons.lock_outline,
                        ),
                        const SizedBox(height: 20),
                        customButton(
                          innerText: 'Login',
                          onPressed: () => cubit.login(context),
                          // isEnabled: cubit.isEnabledButton,
                        ),
                        const SizedBox(height: 20),
                        customTextButton2(
                          context: context,
                          innerText: 'Don\'t have an account?',
                          innerText2: 'Register'.toUpperCase(),
                          onPressed: () => cubit.signUp(context),
                        ),
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
