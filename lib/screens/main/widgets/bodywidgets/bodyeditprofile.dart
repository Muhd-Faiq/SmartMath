import 'package:flutter/material.dart';
import 'package:smartmath/models/user.dart';

import '../../../view.dart';
import '../../main_viewmodel.dart';

class Bodyeditprofile extends StatelessWidget {
  Bodyeditprofile({state}) : _state = state;
  final _state;

  void _onUpdate(BuildContext context, MainViewmodel viewmodel) async {
    final User _user = await viewmodel.updateUser();

    // if (_user != null) Navigator.pop(context, _user);
    if (_user != null) {
      _state.editProfile = false;
      _state.loguser = _user;
      // Navigator.pushNamed(context, '/main');
    }
  }

  void _onCancel(BuildContext context, MainViewmodel viewmodel) {
    _state.editProfile = false;
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: View(
        viewmodel: MainViewmodel(User.copy(_state.loguser)),
        builder: (context, viewmodel, _) => Column(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Column(
              children: [
                SizedBox(
                  height: 50,
                ),
                Image.asset('assets/image/editprofile.png'),
                Text(
                  'Profile',
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 16,
            ),
            Column(
              children: [
                Container(
                  width: 350,
                  child: _buildTextLisTile(
                    label: 'Name',
                    value: viewmodel.username,
                    onChanged: (value) => viewmodel.username = value,
                  ),
                ),
                SizedBox(
                  height: 16,
                ),
                Container(
                  width: 350,
                  child: _buildTextLisTile(
                    label: 'Password',
                    value: viewmodel.password,
                    onChanged: (value) => viewmodel.password = value,
                  ),
                ),
                SizedBox(
                  height: 16,
                ),
                Container(
                  width: 350,
                  child: _buildTextLisTile(
                    label: 'Name',
                    value: viewmodel.name,
                    onChanged: (value) => viewmodel.name = value,
                  ),
                ),
                // if (viewmodel.showErrorMessage)
                //   Text(
                //     'Invalid username or password!',
                //     style: TextStyle(color: Colors.red, fontSize: 20.0),
                //   ),
                SizedBox(
                  height: 10.0,
                ),
                _buildButtons(context, viewmodel),
                SizedBox(
                  height: 10.0,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  ListTile _buildTextLisTile({label, value, onChanged}) {
    return ListTile(
      title: TextFormField(
        initialValue: value,
        decoration: InputDecoration(
          labelText: label,
        ),
        onChanged: onChanged,
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

  Row _buildButtons(BuildContext context, MainViewmodel viewmodel) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        ElevatedButton(
          child: Text('Save'),
          onPressed: () => _onUpdate(context, viewmodel),
        ),
        SizedBox(width: 10.0),
        ElevatedButton(
          child: Text('Cancel'),
          onPressed: () => _onCancel(context, viewmodel),
        ),
      ],
    );
  }
}
