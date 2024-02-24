// ignore_for_file: avoid_print

import 'dart:io';

import 'package:bookbazaar/Models/user_model.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class Profile extends StatefulWidget {
  const Profile({super.key});

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  File? imageFile;
  bool _isEditing = false;

  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();

  UserModel user = UserModel(
      name: 'John Doe',
      phoneNumber: '1234567890',
      email: 'john.doe@example.com');

  @override
  void dispose() {
    _nameController.dispose();
    _phoneController.dispose();
    _emailController.dispose();
    super.dispose();
  }

  void _toggleEdit() {
    setState(() {
      _isEditing = !_isEditing;
    });
  }

  @override
  void initState() {
    super.initState();
    _nameController.text = user.name;
    _phoneController.text = user.phoneNumber;
    _emailController.text = user.email;
  }

  void _saveUserInfo() {
    setState(() {
      user = UserModel(
        name: _nameController.text,
        phoneNumber: _phoneController.text,
        email: _emailController.text,
      );
      _isEditing = false;
    });
  }

  Future<void> selectImage(ImageSource source) async {
    final ImagePicker picker = ImagePicker();
    final XFile? pickedFile = await picker.pickImage(source: source);

    if (pickedFile != null) {
      setState(() {
        imageFile = File(pickedFile.path);
      });
    }
  }

  void showPhotoOptions() {
    showDialog(
        context: context,
        builder: (context) => AlertDialog(
              title: const Text("Upload Profile Picture"),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  ListTile(
                    onTap: () {
                      Navigator.pop(context);
                      selectImage(ImageSource.gallery);
                    },
                    leading: const Icon(Icons.photo_album),
                    title: const Text("Select from Gallery"),
                  ),
                  ListTile(
                    onTap: () {
                      Navigator.pop(context);
                      selectImage(ImageSource.camera);
                    },
                    leading: const Icon(Icons.camera_alt),
                    title: const Text("Take a Photo"),
                  )
                ],
              ),
            ));
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  IconButton(
                      onPressed: () => print("Logout"),
                      icon: const Icon(
                        Icons.logout_outlined,
                        color: Colors.white,
                      ))
                ],
              ),
            ),
            Container(
              margin: const EdgeInsets.only(top: 24),
              child: Center(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    GestureDetector(
                      onTap: showPhotoOptions,
                      child: CircleAvatar(
                        radius: 50,
                        backgroundImage:
                            (imageFile != null) ? FileImage(imageFile!) : null,
                        backgroundColor: Colors.white,
                        child: (imageFile == null)
                            ? const Icon(Icons.add_a_photo, size: 60)
                            : null,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(8, 40, 8, 8),
                      child: TextField(
                        controller: _nameController,
                        decoration: const InputDecoration(
                          labelText: 'Name',
                          filled: true,
                          fillColor: Colors.white,
                        ),
                        enabled: _isEditing,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: TextField(
                        controller: _phoneController,
                        keyboardType: TextInputType.phone,
                        decoration: const InputDecoration(
                          labelText: 'Phone Number',
                          filled: true,
                          fillColor: Colors.white,
                        ),
                        enabled: _isEditing,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: TextField(
                        controller: _emailController,
                        keyboardType: TextInputType.emailAddress,
                        decoration: const InputDecoration(
                          labelText: 'Email',
                          filled: true,
                          fillColor: Colors.white,
                        ),
                        enabled: _isEditing,
                      ),
                    ),
                    if (_isEditing)
                      ElevatedButton(
                        onPressed: _saveUserInfo,
                        child: const Text('Save'),
                      ),
                    ElevatedButton(
                      onPressed: _toggleEdit,
                      child: Text(_isEditing ? 'Cancel' : 'Edit'),
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
