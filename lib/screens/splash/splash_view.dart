import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:pizza_app_admin/blocs/authentication_bloc/authentication_bloc.dart';

class SplashView extends StatelessWidget {
  const SplashView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<AuthenticationBloc, AuthenticationState>(
        builder: (context, state) {
          if (state.status == AuthenticationStatus.authenticated) {
            context.go('/home');
            return Container();
          } else if (state.status == AuthenticationStatus.unauthenticated) {
            context.go('/signIn');
            return Container();
          } else {
            return const Center(child:  CircularProgressIndicator());
          }
        },
      ),
    );
  }
}
