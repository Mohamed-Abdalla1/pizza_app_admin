import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../blocs/authentication_bloc/authentication_bloc.dart';
import '../screens/auth/blocs/sign_in/sign_in_bloc.dart';
import '../screens/auth/sign_in_view.dart';
import '../screens/base/base_view.dart';
import '../screens/create/create_pizza.dart';
import '../screens/home/home_view.dart';
import '../screens/splash/splash_view.dart';



final _navKey = GlobalKey<NavigatorState>();
final _shellNavigationKey = GlobalKey<NavigatorState>();

GoRouter router (AuthenticationBloc authBloc) {
  return GoRouter(
    navigatorKey: _navKey,
    initialLocation: '/',
    redirect: (context, state) {
      if(authBloc.state.status == AuthenticationStatus.unknown) {
        return '/';
      }
    },
    routes: [
      ShellRoute(
        navigatorKey: _shellNavigationKey,
        builder: (context, state, child) {
          if(state.fullPath == '/signIn' || state.fullPath == '/' ) {
            return child;
          } else {
            return BlocProvider<SignInBloc>(
              create: (context) => SignInBloc(
                context.read<AuthenticationBloc>().userRepository
              ),
              child: BaseView(child: child,)
            );
          }
        },
        routes: [
          GoRoute(
            path: '/',
            builder: (context, state) => BlocProvider<AuthenticationBloc>.value(
              value: BlocProvider.of<AuthenticationBloc>(context),
              child: const SplashView(),
            )
          ),
          GoRoute(
            path: '/signIn',
            builder: (context, state) => BlocProvider<AuthenticationBloc>.value(
              value: BlocProvider.of<AuthenticationBloc>(context),
              child: BlocProvider<SignInBloc>(
                create: (context) => SignInBloc(
                  context.read<AuthenticationBloc>().userRepository
                ),
                child: const SignInView(),
              ),
            )
          ),
          GoRoute(
            path: '/home',
            builder: (context, state) => const HomeView(),
          ),
          GoRoute(
            path: '/create',
            builder: (context, state) => const CreatePizza(),
            )
        ]
      )
    ]
  );
}