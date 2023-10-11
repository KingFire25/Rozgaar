import 'dart:io';
import 'package:flutter/material.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:file_picker/file_picker.dart';

class PdfUploadWidget extends StatefulWidget {
  @override
  _PdfUploadWidgetState createState() => _PdfUploadWidgetState();
}

class _PdfUploadWidgetState extends State<PdfUploadWidget> {
  File? _pdfFile;
  bool _isLoading = false;

  void _pickPDF() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['pdf'],
    );

    if (result != null) {
      setState(() {
        _pdfFile = File(result.files.single.path!);
      });
    }
  }

  void _uploadPDF() async {
    setState(() {
      _isLoading = true;
    });

    if (_pdfFile != null) {
      try {
        String fileName =
            DateTime.now().millisecondsSinceEpoch.toString() + '.pdf';
        firebase_storage.Reference ref = firebase_storage
            .FirebaseStorage.instance
            .ref()
            .child('pdfs')
            .child(fileName);
        await Future.delayed(Duration(seconds: 3));
        // await ref.putFile(_pdfFile!);
        setState(() {
          // _pdfFile = null;
          _isLoading = false;
          Navigator.of(context).pop();

        });

        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          backgroundColor: Colors.amber[100],
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          behavior: SnackBarBehavior.floating,
          elevation: 5,
          margin: EdgeInsets.only(left:20,right: 20,bottom: 50),
          content: Text('PDF uploaded successfully!',style:TextStyle(color: Colors.black),textAlign: TextAlign.center,),
        ));
      } catch (e) {
        print('Error uploading PDF: $e');
        setState(() {
          _isLoading = false;
        });
      }
    } else {
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('PDF Upload Widget'),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Column(
            children: [
              Container(
                height: 250,
                width: 340,
                decoration: BoxDecoration(
                  color: Color.fromRGBO(240, 204, 239, 0.6),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    TextButton(onPressed: (){
                      _pickPDF();
                    },
                    style: TextButton.styleFrom(backgroundColor: Colors.purple.shade400,shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10))),
                     child: Text('Select Resume',style: TextStyle(color: Colors.white),)
                    ),
                    SizedBox(height: 20),
                    Text("File Format: pdf, doc, xls  File Size: 10 MB max"),

                  ],
                ),
              ),
              SizedBox(height: 50),
              _pdfFile != null
                  ? Text('Selected PDF: ${_pdfFile!.path}')
                  : Text('No PDF selected'),
              const Divider(color: Colors.transparent,height: 30),
              TextButton(
                onPressed: _uploadPDF,
                  style: TextButton.styleFrom(backgroundColor: Colors.purple.shade400,shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10))),
                  child: _isLoading
                    ? CircularProgressIndicator(color: Colors.white,)
                    : Text('Upload Resume',style: TextStyle(color: Colors.white)),
              ),
            ],
          )
        ),
      ),
    );
  }
}
