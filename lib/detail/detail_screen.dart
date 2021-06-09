import 'package:bloc_login_demo/authentication/bloc/authentication_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DetailScreen extends StatelessWidget {
  final String email;

  const DetailScreen({Key? key, required this.email}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text("Detail Screen"),
          actions: [
            IconButton(
                onPressed: () {
                  BlocProvider.of<AuthenticationBloc>(context)
                      .add(LogoutAuthenticationEvent());
                },
                icon: Icon(Icons.logout_outlined))
          ],
        ),
        body: Center(
          child: Text(
            email,
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30),
          ),
        ),
      ),
    );
  }
}
