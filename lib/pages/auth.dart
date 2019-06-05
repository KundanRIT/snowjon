import 'package:flutter/material.dart';

class AuthPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _AuthPageState();
  }
}

class _AuthPageState extends State<AuthPage> {
  bool rememberMe = false;

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
    return TextField(
      keyboardType: TextInputType.emailAddress,
      decoration: InputDecoration(
          labelText: 'Email', filled: true, fillColor: Colors.white),
    );
  }

  Widget _buildPasswordTextField() {
    return TextField(
      keyboardType: TextInputType.text,
      obscureText: true,
      decoration: InputDecoration(
          labelText: 'Password', filled: true, fillColor: Colors.white),
    );
  }

  Widget _buildLoginButton() {
    return RaisedButton(
      color: Theme.of(context).primaryColor,
      child: Text(
        'Login',
        style: TextStyle(color: Colors.white),
      ),
      onPressed: () => Navigator.pushReplacementNamed(context, 'food'),
    );
  }

  Widget _buildRememberMe() {
    return Row(
      children: <Widget>[
        Text(
          'Remember Me',
          style: TextStyle(
              color: Colors.white,
              backgroundColor: Theme.of(context).primaryColor,
              fontWeight: FontWeight.bold),
        ),
        Switch(
            value: rememberMe,
            activeColor: Theme.of(context).primaryColor,
            onChanged: (bool value) {
              setState(() {
                this.rememberMe = value;
              });
            })
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Authenticate'),
      ),
      body: Container(
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
                _buildUsernameTextField(),
                SizedBox(
                  height: 10,
                ),
                _buildPasswordTextField(),
                SizedBox(
                  height: 10,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: <Widget>[_buildRememberMe(), _buildLoginButton()],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
