import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:smartmath/models/activity.dart';
import 'package:smartmath/models/user.dart';
import 'package:smartmath/screens/view.dart';
import 'package:path/path.dart';

import '../addactivity_viewmodel.dart';

class Body extends StatelessWidget {
  Body({state}) : _state = state;
  final _state;

  void _onAddactivty(
      BuildContext context, AddactivityViewmodel viewmodel) async {
    final Activity _activity = await viewmodel.createnewactivity();
    if (_activity != null) Navigator.pop(context);
  }

  void _onCancel(BuildContext context, AddactivityViewmodel viewmodel) {
    Navigator.pop(context, null);
  }

  @override
  Widget build(BuildContext context) {
    String dropDownValue = 'Tutorial';
    List<String> categoryList = ['Tutorial', 'Submission'];
    return View(
      viewmodel: AddactivityViewmodel(_state.loguser),
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
                  width: 70,
                ),
                Container(
                  width: 55,
                  height: 55,
                  child: Icon(
                    Icons.notifications,
                    size: 50,
                  ),
                ),
                SizedBox(
                  width: 16,
                ),
                Column(
                  children: [
                    Text(
                      'New Activity',
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 30,
                      ),
                    ),
                  ],
                ),
              ],
            ),
            SizedBox(
              height: 75,
            ),
            Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                SizedBox(
                  width: 32,
                ),
                Text(
                  'Enter Title',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 25,
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 15,
            ),
            Container(
              width: 350,
              child: _buildTextField(
                  hint: 'Title',
                  onChanged: (value) {
                    viewmodel.title = value;
                  }),
            ),
            SizedBox(
              height: 35,
            ),
            Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                SizedBox(
                  width: 32,
                ),
                Text(
                  'Enter Description',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 25,
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 15,
            ),
            Container(
              width: 350,
              child: TextField(
                maxLines: 6,
                minLines: 5,
                decoration: InputDecoration(
                  hintText: 'Description',
                  border: OutlineInputBorder(),
                ),
                onChanged: (value) => viewmodel.description = value,
              ),
            ),
            SizedBox(
              height: 35,
            ),
            Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                SizedBox(
                  width: 32,
                ),
                Text(
                  'Choose File',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 25,
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 15,
            ),
            Custom(
              context: context,
              viewmodel: viewmodel,
            ),
            //choose file--------------------------------------------------
            SizedBox(
              height: 35,
            ),
            Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                SizedBox(
                  width: 32,
                ),
                Text(
                  'Choose Category',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 25,
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 15,
            ),
            Container(
              width: 350,
              child: DropdownButtonFormField(
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  filled: true,
                  hintStyle: TextStyle(color: Colors.grey[800]),
                  hintText: "Category",
                ),
                value: dropDownValue,
                onChanged: (String value) {
                  // setState(() {
                  dropDownValue = value;
                  viewmodel.category = value;
                  // });
                },
                items: categoryList
                    .map((listcategory) => DropdownMenuItem(
                        value: listcategory, child: Text("$listcategory")))
                    .toList(),
              ),
            ),
            SizedBox(
              height: 50.0,
            ),
            _buildButtons(context, viewmodel),
            SizedBox(
              height: 50.0,
            ),
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

  Row _buildButtons(BuildContext context, AddactivityViewmodel viewmodel) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        ElevatedButton(
          child: Text('Create'),
          onPressed: () => _onAddactivty(context, viewmodel),
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

class Custom extends StatefulWidget {
  Custom({context, viewmodel})
      : _viewmodel = viewmodel,
        _context = context;
  final _viewmodel, _context;
  @override
  _CustomState createState() => _CustomState();
}

class _CustomState extends State<Custom> {
  File file;
  UploadTask task;
  Future selectFile(AddactivityViewmodel viewmodel) async {
    final result = await FilePicker.platform.pickFiles(allowMultiple: false);
    if (result == null) return;
    final path = result.files.single.path;
    setState(() => file = File(path));
    uploadFile(widget._context, viewmodel);
  }

  Future uploadFile(
      BuildContext context, AddactivityViewmodel viewmodel) async {
    if (file == null) return;

    final fileName = basename(file.path);
    final destination = 'files/$fileName';

    task = viewmodel.uploadFile(destination, file);
    setState(() {});

    if (task == null) return;

    final snapshot = await task.whenComplete(() {});
    viewmodel.urlfile = await snapshot.ref.getDownloadURL();
  }

  @override
  Widget build(BuildContext context) {
    final fileName = file != null ? basename(file.path) : 'No File Selected';
    return Column(
      children: [
        SizedBox(
          width: 350,
          child: MaterialButton(
            color: Colors.orange,
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  Text(
                    "Choose File",
                    style: TextStyle(color: Colors.white),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Icon(
                    Icons.arrow_upward,
                    color: Colors.white,
                  )
                ],
              ),
            ),
            onPressed: () => selectFile(widget._viewmodel),
          ),
        ),
        SizedBox(height: 8),
        Text(
          fileName,
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
        ),
      ],
    );
  }
}
