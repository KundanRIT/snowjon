import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:snowjon/models/authmode.dart';
import 'package:snowjon/scope-models/mainmodel.dart';

class AuthPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _AuthPageState();
  }
}

class _AuthPageState extends State<AuthPage> {
  bool acceptTerms = false;
  String email;
  String password;
  AuthMode authMode = AuthMode.LOGIN;

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _passwordController = TextEditingController();

  BoxDecoration _buildBackgraoundImage() {
    return BoxDecoration(
      image: DecorationImage(
          image: AssetImage('assets/background.jpg'),
          colorFilter: ColorFilter.mode(
              Colors.red.withOpacity(.7), BlendMode.difference),
          repeat: ImageRepeat.repeat),
    );
  }

  Widget _buildAppTitle() {
    return Container(
      color: Colors.black,
      padding: EdgeInsets.symmetric(horizontal: 15, vertical: 2),
      child: Text(
        'My Food List',
        style: TextStyle(
          fontFamily: 'Oswald',
          fontSize: 32,
          fontWeight: FontWeight.bold,
          color: Colors.white,
          letterSpacing: 1,
        ),
      ),
    );
  }

  Widget _buildUsernameTextField() {
    return TextFormField(
      keyboardType: TextInputType.emailAddress,
      validator: (String username) {
        if (username.isEmpty) return 'Email is invalid.';
      },
      decoration: InputDecoration(
          labelText: 'Email', filled: true, fillColor: Colors.white),
      onSaved: (String value) {
        email = value;
      },
    );
  }

  Widget _buildPasswordTextField() {
    return TextFormField(
      keyboardType: TextInputType.text,
      obscureText: true,
      controller: _passwordController,
      validator: (String password) {
        if (password.isEmpty) {
          return 'Password is invalid.';
        }
      },
      decoration: InputDecoration(
          labelText: 'Password', filled: true, fillColor: Colors.white),
      onSaved: (String value) {
        password = value;
      },
    );
  }

  Widget _buildConfirmPasswordTextField() {
    return TextFormField(
      keyboardType: TextInputType.text,
      obscureText: true,
      validator: (String confirmPassword) {
        if (confirmPassword != _passwordController.text) {
          return 'Passwords do not match.';
        }
      },
      decoration: InputDecoration(
          labelText: 'Confirm Password', filled: true, fillColor: Colors.white),
      onSaved: (String value) {
        password = value;
      },
    );
  }

  Widget _buildLoginButton() {
    return ScopedModelDescendant<MainModel>(
      builder: (BuildContext context, Widget child, MainModel model) {
        if (model.isLoading) {
          return Center(
            child: CircularProgressIndicator(),
          );
        }
        return RaisedButton(
            color: Theme.of(context).primaryColor,
            child: Text(
              authModeLabel(authMode),
              style: TextStyle(color: Colors.white),
            ),
            onPressed: () {
              if (_formKey.currentState.validate()) {
                _formKey.currentState.save();
                model
                    .authenticate(email, password, authMode)
                    .then((Map<String, dynamic> val) {
                  if (val.containsKey('idToken')) {
                    Navigator.pushReplacementNamed(context, 'food');
                  } else {
                    showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            title: Text('Error'),
                            content: Text(val['error']['message']),
                            actions: <Widget>[
                              RaisedButton(
                                child: Text('OK!'),
                                onPressed: () {
                                  Navigator.of(context).pop();
                                },
                              ),
                            ],
                          );
                        });
                  }
                });
              }
            });
      },
    );
  }

  Widget _buildAcceptTerms() {
    return Row(
      children: <Widget>[
        Text(
          'Accept Terms',
          style: TextStyle(
              color: Colors.white,
              backgroundColor: Theme.of(context).primaryColor,
              fontWeight: FontWeight.bold),
        ),
        Switch(
          value: acceptTerms,
          activeColor: Theme.of(context).primaryColor,
          onChanged: (bool value) {
            setState(() {
              this.acceptTerms = value;
            });
          },
        )
      ],
    );
  }

  String authModeLabel(AuthMode mode) {
    switch (mode) {
      case AuthMode.LOGIN:
        return 'Login';
      case AuthMode.SIGNUP:
        return 'Sign Up';
    }
    return '';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Authenticate'),
      ),
      body: Form(
        key: _formKey,
        child: Container(
          decoration: _buildBackgraoundImage(),
          child: Center(
            child: SingleChildScrollView(
              padding: EdgeInsets.all(10.0),
              child: Column(
                children: <Widget>[
                  _buildAppTitle(),
                  SizedBox(
                    height: 30,
                  ),
                  FlatButton(
                    color: Theme.of(context).primaryColor,
                    child: Text(
                      'Switch To ${authMode == AuthMode.LOGIN ? 'Sign Up' : 'Login'}',
                      style: TextStyle(
                          fontWeight: FontWeight.bold, color: Colors.white),
                    ),
                    onPressed: () {
                      setState(() {
                        authMode = authMode == AuthMode.LOGIN
                            ? AuthMode.SIGNUP
                            : AuthMode.LOGIN;
                        acceptTerms = false;
                      });
                    },
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  _buildUsernameTextField(),
                  SizedBox(
                    height: 10,
                  ),
                  _buildPasswordTextField(),
                  SizedBox(
                    height: 10,
                  ),
                  authMode == AuthMode.SIGNUP
                      ? Column(
                          children: <Widget>[
                            _buildConfirmPasswordTextField(),
                            SizedBox(
                              height: 10,
                            ),
                            _buildAcceptTerms(),
                          ],
                        )
                      : Container(),
                  _buildLoginButton(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
