import 'package:bloc_login_demo/authentication/bloc/authentication_bloc.dart';
import 'package:bloc_login_demo/detail/detail_screen.dart';
import 'package:bloc_login_demo/login/bloc/login_bloc.dart';
import 'package:bloc_login_demo/login/ui/login.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class Authentication extends StatelessWidget {
  const Authentication({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthenticationBloc, AuthenticationState>(
        builder: (ctx, state) {
      return BlocListener<AuthenticationBloc, AuthenticationState>(
        listener: (ctx, state) {
          Navigator.of(ctx).popUntil(ModalRoute.withName("/"));
        },
        child: _renderBody(state, ctx),
      );
    });
  }

  Widget _renderBody(AuthenticationState state, BuildContext ctx) {
    if (state is LogoutAuthenticationState) {
      return BlocProvider<LoginBloc>(
        create: (ctx) {
          return LoginBloc();
        },
        child: LoginScreen(),
      );
    } else if (state is LoggedAuthenticationState) {
      return DetailScreen(email: state.email);
    } else {
      return Scaffold(
        body: Center(
          child: CircularProgressIndicator(),
        ),
      );
    }
  }
}
