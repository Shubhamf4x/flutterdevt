import 'package:flutter/material.dart';
import 'dart:async';

void main() {
  runApp(MyApp());
}

enum DashboardOptions { contribute, practice, learn, interests, help, settings }

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Project',
      theme: ThemeData(
        primarySwatch: Colors.orange,
      ),
      home: SplashScreen(),
    );
  }
}

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    _navigateToLoginScreen();
  }

  _navigateToLoginScreen() async {
    await Future.delayed(Duration(seconds: 1), () {});
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(builder: (context) => LoginScreen()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Image.asset(
          'assets/splashex.jpeg',
          fit: BoxFit.cover,
          width: double.infinity,
          height: double.infinity,
        ),
      ),
    );
  }
}

class User {
  final String username;
  final String password;

  User({required this.username, required this.password});
}

class UserDatabase {
  static List<User> users = [];
}

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  String _usernameError = '';
  String _passwordError = '';

  void _login() {
    String username = _usernameController.text;
    String password = _passwordController.text;

    User? user = UserDatabase.users.firstWhere(
          (user) => user.username == username,
      orElse: () => User(username: '', password: ''),
    );

    setState(() {
      _usernameError = '';
      _passwordError = '';
      if (username.isEmpty) {
        _usernameError = 'Please enter your username';
      } else if (password.isEmpty) {
        _passwordError = 'Please enter your password';
      } else if (user.username == '') {
        _usernameError = 'Try again with a valid username';
      } else if (user.password != password) {
        _passwordError = 'Password is incorrect';
      } else {
        Navigator.of(context).push(
          MaterialPageRoute(
              builder: (context) => DashboardScreen(username: username)),
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Colors.orange.shade700, Colors.orange.shade200],
          ),
        ),
        padding: EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "Hello!",
              style: TextStyle(
                fontSize: 36,
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 10),
            Text(
              "LOREM IPSUM DOLOR SIT AMET,\nCONSECTETUERADIPISCING ELIT",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 16,
                color: Colors.white,
              ),
            ),
            SizedBox(height: 20),
            CustomTextField(
              hintText: 'Username',
              controller: _usernameController,
              prefixIcon: Icon(Icons.person, color: Colors.white),
            ),
            if (_usernameError.isNotEmpty)
              Padding(
                padding: const EdgeInsets.only(top: 8.0),
                child: Text(
                  _usernameError,
                  style: TextStyle(color: Colors.red),
                ),
              ),
            SizedBox(height: 10),
            CustomTextField(
              hintText: 'Password',
              obscureText: true,
              controller: _passwordController,
              prefixIcon: Icon(Icons.lock, color: Colors.white),
            ),
            if (_passwordError.isNotEmpty)
              Padding(
                padding: const EdgeInsets.only(top: 8.0),
                child: Text(
                  _passwordError,
                  style: TextStyle(color: Colors.red),
                ),
              ),
            SizedBox(height: 20),
            CustomButton(
              text: 'Login',
              onPressed: _login,
            ),
            SizedBox(height: 25),
            Text(
              "Don't have an account? ",
              style: TextStyle(
                fontSize: 20,
                fontStyle: FontStyle.italic,
                color: Colors.white,
              ),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute(builder: (context) => SignUpScreen()),
                );
              },
              child: Text(
                'Sign up',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                  decoration: TextDecoration.underline,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class SignUpScreen extends StatefulWidget {
  @override
  _SignUpScreenState createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  String _errorMessage = '';

  void _signUp() {
    String email = _emailController.text;
    String username = _usernameController.text;
    String password = _passwordController.text;

    if (username.isEmpty || password.isEmpty) {
      setState(() {
        _errorMessage = 'Please fill in all fields';
      });
      return;
    }

    User newUser = User(username: username, password: password);
    UserDatabase.users.add(newUser);

    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Colors.orange.shade700, Colors.orange.shade200],
          ),
        ),
        padding: EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              'assets/company_logo.png',
              height: 160,
            ),
            SizedBox(height: 20),
            Text(
              "LOREM IPSUM DOLOR SIT AMET,\nCONSECTETUER ADIPISCING ELIT",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 16,
                color: Colors.white,
              ),
            ),
            SizedBox(height: 20),
            CustomTextField(
              hintText: 'Email',
              controller: _emailController,
              prefixIcon: Icon(Icons.email, color: Colors.white),
            ),
            SizedBox(height: 10),
            CustomTextField(
              hintText: 'Username',
              controller: _usernameController,
              prefixIcon: Icon(Icons.person, color: Colors.white),
            ),
            SizedBox(height: 10),
            CustomTextField(
              hintText: 'Password',
              obscureText: true,
              controller: _passwordController,
              prefixIcon: Icon(Icons.lock, color: Colors.white),
            ),
            SizedBox(height: 20),
            CustomButton(
              text: 'CREATE ACCOUNT',
              onPressed: _signUp,
            ),
            if (_errorMessage.isNotEmpty) ...[
              SizedBox(height: 10),
              Text(
                _errorMessage,
                style: TextStyle(color: Colors.red),
              ),
            ],
            SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Already have an account? ",
                  style: TextStyle(
                    fontSize: 19,
                    fontStyle: FontStyle.italic,
                    color: Colors.white,
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(builder: (context) => LoginScreen()),
                    );
                  },
                  child: Text(
                    'Login',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                      decoration: TextDecoration.underline,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class DashboardScreen extends StatefulWidget {
  final String username;

  DashboardScreen({required this.username});

  @override
  _DashboardScreenState createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  bool _isContributing = false;

  void _navigateToOption(BuildContext context, DashboardOptions option) {
    switch (option) {
      case DashboardOptions.contribute:
        Navigator.of(context).push(
          MaterialPageRoute(builder: (context) => ContributeScreen()),
        );
        break;
      case DashboardOptions.practice:
        break;
      case DashboardOptions.learn:
        break;
      case DashboardOptions.interests:
        break;
      case DashboardOptions.help:
        break;
      case DashboardOptions.settings:
        break;
    }
  }

  void _logout(BuildContext context) {
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(builder: (context) => LoginScreen()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Dashboard',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.black,
        iconTheme: IconThemeData(color: Colors.white),
        actions: [
          IconButton(
            icon: Icon(Icons.power_settings_new, color: Colors.red),
            onPressed: () => _logout(context),
          ),
        ],
      ),
      body: Container(
        color: Colors.black,
        child: Column(
          children: [
            SizedBox(height: 50),
            CircleAvatar(
              radius: 50,
              backgroundImage: AssetImage('assets/user_avatar.png'),
            ),
            SizedBox(height: 20),
            Text(
              widget.username,
              style: TextStyle(
                color: Colors.white,
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 10),
            Text(
              'Flutter Developer',
              style: TextStyle(
                fontStyle: FontStyle.italic,
                color: Colors.white,
                fontSize: 16,
              ),
            ),
            SizedBox(height: 20),
            Expanded(
              child: ListView(
                children: [
                  AnimatedPositioned(
                    duration: const Duration(seconds: 2),
                    curve: Curves.fastOutSlowIn,
                    top: _isContributing ? 50.0 : 150.0,
                    child: GestureDetector(
                      onTap: () {
                        setState(() {
                          _isContributing = !_isContributing;
                        });
                        _navigateToOption(context, DashboardOptions.contribute);
                      },
                      child: ListTile(
                        leading: Icon(Icons.people, color: Colors.white),
                        title: Text(
                          'Contribute',
                          style: TextStyle(color: Colors.white),
                        ),
                        trailing:
                        Icon(Icons.arrow_forward_ios, color: Colors.white),
                      ),
                    ),
                  ),
                  ListTile(
                    leading: Icon(Icons.school, color: Colors.white),
                    title: Text(
                      'Practice',
                      style: TextStyle(color: Colors.white),
                    ),
                    trailing:
                    Icon(Icons.arrow_forward_ios, color: Colors.white),
                    onTap: () =>
                        _navigateToOption(context, DashboardOptions.practice),
                  ),
                  ListTile(
                    leading: Icon(Icons.book, color: Colors.white),
                    title: Text(
                      'Learn',
                      style: TextStyle(color: Colors.white),
                    ),
                    trailing:
                    Icon(Icons.arrow_forward_ios, color: Colors.white),
                    onTap: () =>
                        _navigateToOption(context, DashboardOptions.learn),
                  ),
                  ListTile(
                    leading: Icon(Icons.star, color: Colors.white),
                    title: Text(
                      'Interests',
                      style: TextStyle(color: Colors.white),
                    ),
                    trailing:
                    Icon(Icons.arrow_forward_ios, color: Colors.white),
                    onTap: () =>
                        _navigateToOption(context, DashboardOptions.interests),
                  ),
                  ListTile(
                    leading: Icon(Icons.help, color: Colors.white),
                    title: Text(
                      'Help & Support',
                      style: TextStyle(color: Colors.white),
                    ),
                    trailing:
                    Icon(Icons.arrow_forward_ios, color: Colors.white),
                    onTap: () =>
                        _navigateToOption(context, DashboardOptions.help),
                  ),
                  ListTile(
                    leading: Icon(Icons.settings, color: Colors.white),
                    title: Text(
                      'Settings',
                      style: TextStyle(color: Colors.white),
                    ),
                    trailing:
                    Icon(Icons.arrow_forward_ios, color: Colors.white),
                    onTap: () =>
                        _navigateToOption(context, DashboardOptions.settings),
                  ),
                  ListTile(
                    leading: Icon(Icons.logout, color: Colors.white),
                    title: Text(
                      'Log out',
                      style: TextStyle(color: Colors.white),
                    ),
                    trailing:
                    Icon(Icons.arrow_forward_ios, color: Colors.white),
                    onTap: () => _logout(context),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.black,
        selectedItemColor: Colors.white,
        unselectedItemColor: Colors.white,
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.camera_alt),
            label: '',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.calendar_today),
            label: '',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: '',
          ),
        ],
      ),
    );
  }
}

class ContributeScreen extends StatefulWidget {
  @override
  _ContributeScreenState createState() => _ContributeScreenState();
}

class _ContributeScreenState extends State<ContributeScreen> {
  bool selected = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Contribute'),
      ),
      body: Center(
        child: SizedBox(
          width: 200,
          height: 350,
          child: Stack(
            children: <Widget>[
              AnimatedPositioned(
                width: selected ? 200.0 : 50.0,
                height: selected ? 50.0 : 200.0,
                top: selected ? 50.0 : 150.0,
                duration: const Duration(seconds: 2),
                curve: Curves.fastOutSlowIn,
                child: GestureDetector(
                  onTap: () {
                    setState(() {
                      selected = !selected;
                    });
                  },
                  child: const ColoredBox(
                    color: Colors.blue,
                    child: Center(child: Text('Tap me')),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class CustomTextField extends StatelessWidget {
  final String hintText;
  final TextEditingController controller;
  final bool obscureText;
  final Icon? prefixIcon;

  CustomTextField({
    required this.hintText,
    required this.controller,
    this.obscureText = false,
    this.prefixIcon,
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      obscureText: obscureText,
      style: TextStyle(color: Colors.white),
      decoration: InputDecoration(
        hintText: hintText,
        hintStyle: TextStyle(color: Colors.white70),
        enabledBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: Colors.white70),
        ),
        focusedBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: Colors.white),
        ),
        prefixIcon: prefixIcon,
      ),
    );
  }
}

class CustomButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;

  CustomButton({required this.text, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.white,
        foregroundColor: Colors.orange,
        padding: EdgeInsets.symmetric(horizontal: 50, vertical: 15),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(25),
        ),
      ),
      child: Text(
        text,
        style: TextStyle(color: Colors.orange, fontWeight: FontWeight.bold),
      ),
    );
  }
}
