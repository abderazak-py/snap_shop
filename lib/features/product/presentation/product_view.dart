import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:snap_shop/core/utils/app_router.dart';
import 'package:snap_shop/core/utils/injection_container.dart';
import 'package:snap_shop/features/auth/domain/repos/auth_repo.dart';
import 'package:snap_shop/core/utils/styles.dart';

class ProductView extends StatelessWidget {
  const ProductView({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: ElevatedButton(onPressed: (){
        sl<AuthRepository>().signOut();
        GoRouter.of(context).pushReplacement(AppRouter.kLoginView);}, child: Text('Logout', style: Styles.titleText16)),
    );
  }
}
