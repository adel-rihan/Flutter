import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop/shared/components/classes/auth_validator.dart';
import 'package:shop/shared/components/classes/components.dart';
import 'package:shop/shared/components/classes/formatters.dart';
import 'package:shop/shared/components/controls/custom_input_field.dart';
import 'package:shop/shared/cubit/cubit.dart';
import 'package:shop/shared/cubit/states.dart';

class UpdatePasswordPage extends StatelessWidget {
  const UpdatePasswordPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => UpdatePasswordCubit(),
      child: BlocConsumer<UpdatePasswordCubit, UpdatePasswordStates>(
        listener: (context, state) {
          // print(state.toString());
        },
        builder: (context, state) {
          UpdatePasswordCubit cubit = UpdatePasswordCubit.get(context);

          return Scaffold(
            body: SafeArea(
              child: Scrollbar(
                child: SingleChildScrollView(
                  child: Form(
                    key: cubit.updatePasswordFormKey,
                    child: Padding(
                      padding: const EdgeInsets.all(20),
                      child: Column(
                        children: [
                          headingWidgetWithBackButton(
                            context: context,
                            title: 'Update Password',
                          ),
                          CustomInputField(
                            controller: cubit.currentPasswordInput,
                            labelText: 'Current Password',
                            obscureText: true,
                            validator: isPasswordValid,
                            inputFormatters: [noSpaceFormatter],
                            prefixIcon: Icons.lock_outlined,
                          ),
                          const SizedBox(height: 15),
                          CustomInputField(
                            controller: cubit.newPasswordInput,
                            labelText: 'New Password',
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
                            innerText: 'Save',
                            onPressed: () => cubit.updatePassword(context),
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
