import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:pizza_app_admin/screens/auth/blocs/sign_in/sign_in_bloc.dart';
import 'dart:html' as html;

class BaseView extends StatefulWidget {
  const BaseView({super.key, required this.child});
  final Widget child;

  @override
  State<BaseView> createState() => _BaseViewState();
}

class _BaseViewState extends State<BaseView> {
  @override
  Widget build(BuildContext context) {
    return BlocListener<SignInBloc, SignInState>(
      listener: (context, state) {
        if (state is SignOutSuccess) {
          html.window.location.reload();
        }
      },
      child: Scaffold(
          body: Column(
        children: [
          Container(
            width: MediaQuery.of(context).size.width,
            height: kToolbarHeight,
            color: Colors.white,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      InkWell(
                        onTap: () {
                          context.go('/home');
                        },
                        child: const Text(
                          'Pizza Admin',
                          style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.w700),
                        ),
                      ),
                      const SizedBox(
                        width: 8,
                      ),
                      InkWell(
                        onTap: () {
                          context.go('/create');
                        },
                        highlightColor: Colors.orange,
                        child: const Text(
                          'Create Pizza',
                          style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w600,
                              color: Colors.grey),
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      const Text(
                        'Log Out',
                        style: TextStyle(
                            fontSize: 14, fontWeight: FontWeight.w500),
                      ),
                      const SizedBox(
                        width: 8,
                      ),
                      InkWell(
                          onTap: () {
                            context.read<SignInBloc>().add(SignOutRequired());
                          },
                          child: const Icon(
                            Icons.logout,
                          )),
                    ],
                  ),
                ],
              ),
            ),
          ),
          Expanded(child: widget.child)
        ],
      )),
    );
  }
}
