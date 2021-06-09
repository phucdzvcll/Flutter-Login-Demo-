import 'package:bloc_login_demo/authentication/bloc/authentication_bloc.dart';
import 'package:bloc_login_demo/login/bloc/login_bloc.dart';
import 'package:bloc_login_demo/register/bloc/register_bloc.dart';
import 'package:bloc_login_demo/register/ui/register.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({Key? key}) : super(key: key);

  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            "Login",
            style: TextStyle(color: Colors.white),
          ),
          centerTitle: true,
        ),
        body: Padding(
          padding: EdgeInsets.all(20),
          child: BlocBuilder<LoginBloc, LoginState>(
            builder: (ctx, state) => BlocListener<LoginBloc, LoginState>(
              listener: (ctx, state) {
                BlocProvider.of<AuthenticationBloc>(ctx)
                    .add(LoginAuthenticationEvent());
              },
              child: _form(ctx, state),
            ),
          ),
        ),
      ),
    );
  }

  Form _form(BuildContext ctx, LoginState state) {
    var errorMess = "";
    if (state is LoginError) {
      errorMess = state.errorMess;
    }
    return Form(
      key: _formKey,
      child: ListView(
        children: [
          SizedBox(
            height: 20,
          ),
          Text(
            "Welcomes",
            style: TextStyle(
                color: Colors.black, fontSize: 32, fontWeight: FontWeight.bold),
          ),
          SizedBox(
            height: 20,
          ),
          Text(
            "Login to continue",
            style: TextStyle(
                color: Colors.black, fontSize: 18, fontStyle: FontStyle.italic),
          ),
          SizedBox(
            height: 30,
          ),
          Visibility(
            visible: state is LoginError ? true : false,
            child: Text(
              errorMess,
              style: TextStyle(color: Colors.red, fontSize: 16),
            ),
          ),
          SizedBox(
            height: 30,
          ),
          TextFormField(
            controller: _emailController,
            validator: (email) {
              if (email != null) {
                if (!EmailValidator.validate(email)) {
                  return "Please enter email";
                }
              }
              return null;
            },
            decoration: InputDecoration(hintText: "email"),
          ),
          SizedBox(
            height: 30,
          ),
          TextFormField(
            obscureText: true,
            validator: (password) {
              if (password != null) {
                if (password.length < 6) {
                  return "Please enter at least 6 characters";
                }
              }
              return null;
            },
            controller: _passController,
            decoration: InputDecoration(hintText: "password"),
          ),
          SizedBox(
            height: 50,
          ),
          DecoratedBox(
            decoration: BoxDecoration(color: Colors.blue),
            child: SizedBox(
              width: double.infinity,
              height: 50,
              child: MaterialButton(
                color: Colors.blue,
                onPressed: () {
                  if (_formKey.currentState != null &&
                      _formKey.currentState!.validate()) {
                    BlocProvider.of<LoginBloc>(ctx).add(LoggingEvent(
                        email: _emailController.text,
                        password: _passController.text));
                  }
                },
                textColor: Colors.white,
                child: Text("Login"),
              ),
            ),
          ),
          SizedBox(
            height: 20,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text("No have account?"),
              SizedBox(
                width: 10,
              ),
              TextButton(
                  onPressed: () {
                    Navigator.push(
                      ctx,
                      MaterialPageRoute(
                        builder: (context) => BlocProvider<RegisterBloc>(
                          create: (ctx) {
                            return RegisterBloc();
                          },
                          child: RegisterScreen(
                            ctx: ctx,
                          ),
                        ),
                      ),
                    );
                  },
                  child: Text("Register"))
            ],
          )
        ],
      ),
    );
  }
}
