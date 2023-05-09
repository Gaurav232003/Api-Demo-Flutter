import 'package:flutter/material.dart';
import 'user.dart';
import 'getValues.dart';

class Page2 extends StatelessWidget {
  final _formKey = GlobalKey<FormState>();
  final _user = User(
    id: '',
    email: '',
    firstName: '',
    lastName: '',
    avatar: '',
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Create User'),
      ),
      body: Container(
        padding: EdgeInsets.all(14.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              TextFormField(
                decoration: InputDecoration(
                  hintText: 'First Name',
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter first name';
                  }
                  return null;
                },
                onSaved: (value) {
                  _user.firstName = value!;
                },
              ),
              TextFormField(
                decoration: InputDecoration(
                  hintText: 'Last Name',
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter last name';
                  }
                  return null;
                },
                onSaved: (value) {
                  _user.lastName = value!;
                },
              ),
              TextFormField(
                decoration: InputDecoration(
                  hintText: 'Email',
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter email';
                  } else if (!value.contains('@')) {
                    return 'Please enter a valid email';
                  }
                  return null;
                },
                onSaved: (value) {
                  _user.email = value!;
                },
              ),
              ElevatedButton(
                onPressed: () async {
                  if (_formKey.currentState!.validate()) {
                    _formKey.currentState!.save();
                    try {
                      final user = await createUser(_user);
                      FocusManager.instance.primaryFocus?.unfocus();

                      print(user.firstName);
                      print(user.lastName);
                      print(user.email);
                      print(user.id);
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text('User created successfully'),
                        ),
                      );
                      _formKey.currentState!.reset();
                    } catch (e) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text('${e.toString()}'),
                        ),
                      );
                    }
                  }
                },
                child: Text('Create User'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
