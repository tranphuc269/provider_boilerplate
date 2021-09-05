import 'package:flutter/material.dart';
import 'package:flutter_provider_example/app/login_app_service.dart';
import 'package:flutter_provider_example/view_models/login/login_view_model.dart';
import 'package:flutter_provider_example/views/widget/text_area.dart';
import 'package:provider/provider.dart';

class LoginPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: MultiProvider(
          providers: [
            ChangeNotifierProvider<LoginViewModel>(
              create: (context) => LoginViewModel(
                context,
                app: LoginAppService(context.read),
              ),
            ),
          ],
          child: _LoginBody(),
        ),
      ),
    );
  }
}

class _LoginBody extends StatefulWidget {
  @override
  __LoginBodyState createState() => new __LoginBodyState();
}

class __LoginBodyState extends State<_LoginBody> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Login Screen App'),
      ),
      body: Form(
        key: _formKey,
        child: Padding(
          padding: EdgeInsets.all(10),
          child: ListView(
            children: <Widget>[
              Container(
                alignment: Alignment.center,
                padding: EdgeInsets.all(10),
                child: Text(
                  'Login example',
                  style: TextStyle(
                    color: Colors.blue,
                    fontWeight: FontWeight.w500,
                    fontSize: 30,
                  ),
                ),
              ),
              Consumer<LoginViewModel>(
                builder: (context, viewModel, child) {
                  return Text(
                    viewModel.errorMessage ?? '',
                    style: TextStyle(
                      color: Colors.red,
                      fontWeight: FontWeight.w500,
                      fontSize: 10,
                    ),
                  );
                },
              ),
              Container(
                padding: EdgeInsets.all(10),
                child: TextArea(
                  labelText: "User Name",
                  onSaved: (value) {
                    context.read<LoginViewModel>().userName = value;
                  },
                ),
              ),
              Container(
                padding: EdgeInsets.fromLTRB(10, 10, 10, 0),
                child: TextArea(
                  labelText: "Password",
                  onSaved: (value) {
                    context.read<LoginViewModel>().password = value;
                  },
                ),
              ),
              FlatButton(
                onPressed: () {
                  // Todo: push forgot password screen
                },
                textColor: Colors.blue,
                child: Text('Forgot Password'),
              ),
              Container(
                height: 50,
                padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
                child: RaisedButton(
                  textColor: Colors.white,
                  color: Colors.blue,
                  child: Text('Login'),
                  onPressed: () async {
                    _formKey.currentState.save();
                    await context.read<LoginViewModel>().login();
                  },
                ),
              ),
              Container(
                child: Row(
                  children: <Widget>[
                    Text('Does not have account?'),
                    FlatButton(
                      textColor: Colors.blue,
                      child: Text(
                        'Sign in',
                        style: TextStyle(fontSize: 20),
                      ),
                      onPressed: () {
                        //Todo: push signup screen
                      },
                    )
                  ],
                  mainAxisAlignment: MainAxisAlignment.center,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
