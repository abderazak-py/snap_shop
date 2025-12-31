import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/widgets/error_widget.dart';
import '../../../auth/presentation/cubit/auth_cubit.dart';
import 'widgets/profile_buttons.dart';
import 'widgets/profile_loading.dart';
import 'widgets/profile_top_section.dart';

class ProfileView extends StatelessWidget {
  const ProfileView({super.key});

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    return Scaffold(
      body: BlocBuilder<AuthCubit, AuthState>(
        builder: (context, state) {
          if (state is AuthSuccessConfirmed) {
            return SizedBox(
              width: width,
              child: Column(
                children: [
                  SizedBox(height: height * 0.08),
                  ProfileTopSection(width: width, user: state.user),
                  Spacer(),
                  ProfileButtons(),
                  SizedBox(height: 50),
                ],
              ),
            );
          } else if (state is AuthFailure) {
            return CustomErrorWidget(errorMsg: state.error);
          } else {
            return ProfileLoading();
          }
        },
      ),
    );
  }
}
