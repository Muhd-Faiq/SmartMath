import 'dart:io';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:smartmath/models/submission.dart';
import 'package:smartmath/screens/view.dart';
import 'package:path/path.dart';
import '../../main_viewmodel.dart';

class Studentsubmission extends StatelessWidget {
  Studentsubmission({state}) : _state = state;
  final _state;

  void _onAddsubmission(BuildContext context, MainViewmodel viewmodel) async {
    if (viewmodel.submissiontemp != null) {
      final Submission _submission2 = await viewmodel.updateSubmission();
      if (_submission2 != null) _state.showStudentsubmission = true;
    } else if (viewmodel.submissiontemp == null) {
      final Submission _submission = await viewmodel.createnewsubmission();
      if (_submission != null) _state.showStudentsubmission = true;
    } else {
      _state.showSubmission = true;
    }
  }

  void _onCancel(BuildContext context, MainViewmodel viewmodel) {
    _state.showSubmission = true;
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: View(
        viewmodel: MainViewmodel(),
        builder: (context, viewmodel, _) => Container(
          child: Column(
            children: [
              if (viewmodel.activity.category == 'Submission')
                Container(
                  margin: const EdgeInsets.only(
                    top: 30.0,
                    right: 15.0,
                    left: 15.0,
                  ),
                  padding: const EdgeInsets.only(
                    top: 20.0,
                    right: 6.0,
                    left: 6.0,
                    bottom: 40.0,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.grey[200],
                    border: Border.all(color: Colors.grey),
                  ),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Text(
                            'Title: ${viewmodel.activity.title}',
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 20,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 50,
                      ),
                      Custom(
                        context: context,
                        viewmodel: viewmodel,
                      ),
                    ],
                  ),
                ),
              SizedBox(
                height: 25,
              ),
              Container(
                margin: const EdgeInsets.only(
                  right: 6.0,
                  left: 6.0,
                ),
                padding: const EdgeInsets.only(
                  top: 20.0,
                  right: 6.0,
                  left: 6.0,
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    MaterialButton(
                      color: Colors.orange,
                      child: Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: <Widget>[
                            Text(
                              'Add Submission',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 18,
                              ),
                            ),
                          ],
                        ),
                      ),
                      onPressed: () => _onAddsubmission(context, viewmodel),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    MaterialButton(
                      color: Colors.orange,
                      child: Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: <Widget>[
                            Text(
                              'Cancel',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 18,
                              ),
                            ),
                          ],
                        ),
                      ),
                      onPressed: () => _onCancel(context, viewmodel),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
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
  Future selectFile(MainViewmodel viewmodel) async {
    final result = await FilePicker.platform.pickFiles(allowMultiple: false);
    if (result == null) return;
    final path = result.files.single.path;
    setState(() => file = File(path));
    uploadFile(widget._context, viewmodel);
  }

  Future uploadFile(BuildContext context, MainViewmodel viewmodel) async {
    if (file == null) return;

    final fileName = basename(file.path);
    final destination = 'files/$fileName';

    task = viewmodel.uploadFile(destination, file);
    setState(() {});

    if (task == null) return;

    final snapshot = await task.whenComplete(() {});
    viewmodel.filesubmit = await snapshot.ref.getDownloadURL();
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
