import 'package:flutter/material.dart';
import 'package:smartmath/models/user.dart';
import 'package:smartmath/screens/view.dart';

import '../register_viewmodel.dart';

class Body extends StatelessWidget {
  void _onRegister(BuildContext context, RegisterViewmodel viewmodel) async {
    final User _user = await viewmodel.register();

    // if (_user != null) Navigator.pop(context, _user);
    if (_user != null) Navigator.pushNamed(context, '/login');
  }

  @override
  Widget build(BuildContext context) {
    return View(
      viewmodel: RegisterViewmodel(),
      builder: (context, viewmodel, _) => SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              height: 50,
            ),
            Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                SizedBox(
                  width: 50,
                ),
                Container(
                  width: 55,
                  height: 55,
                  child: Column(
                    children: [
                      Image.asset('assets/image/blackboard.png'),
                    ],
                  ),
                ),
                SizedBox(
                  width: 16,
                ),
                Column(
                  children: [
                    Text(
                      'SmartMath',
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 30,
                      ),
                    ),
                    Text(
                      'Create New Account',
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        fontSize: 18,
                      ),
                    ),
                  ],
                ),
              ],
            ),
            SizedBox(
              height: 75,
            ),
            Container(
              width: 350,
              child: _buildTextField(
                hint: 'Name',
                icon: Icons.people,
                onChanged: (value) => viewmodel.name = value,
              ),
            ),
            SizedBox(
              height: 15,
            ),
            Container(
              width: 350,
              child: _buildTextField(
                hint: 'Email',
                icon: Icons.email,
                onChanged: (value) => viewmodel.login = value,
              ),
            ),
            SizedBox(
              height: 15,
            ),
            Container(
              width: 350,
              child: _buildTextField(
                hint: 'Password',
                icon: Icons.lock,
                onChanged: (value) => viewmodel.password = value,
              ),
            ),
            SizedBox(
              height: 15,
            ),
            Container(
              width: 350,
              child: _buildTextField(
                hint: 'Confirm Password',
                icon: Icons.lock,
                onChanged: (value) => viewmodel.username = value,
              ),
            ),
            SizedBox(
              height: 30.0,
            ),
            _buildButtons(context, viewmodel),
          ],
        ),
      ),
    );
  }

  TextField _buildTextField(
      {hint, icon, isObsecure = false, button, onChanged}) {
    return TextField(
      decoration: InputDecoration(
        hintText: hint,
        prefixIcon: icon != null ? Icon(icon) : null,
        suffixIcon: button,
        border: OutlineInputBorder(),
      ),
      obscureText: isObsecure,
      onChanged: onChanged,
    );
  }

  Row _buildButtons(BuildContext context, RegisterViewmodel viewmodel) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        ElevatedButton(
          style: ButtonStyle(
            minimumSize: MaterialStateProperty.all(Size(250, 50)),
            backgroundColor: MaterialStateProperty.all<Color>(Colors.orange),
          ),
          child: Text(
            'Sign Up',
            style: TextStyle(fontSize: 20),
          ),
          onPressed: () => _onRegister(context, viewmodel),
          // onPressed: () {},
        ),
      ],
    );
  }
}
