import 'package:flutter/material.dart';
import 'package:sql/controller/contacts_controller.dart';

class ContactView extends StatefulWidget {
  @override
  _ContactViewState createState() => _ContactViewState();
}

class _ContactViewState extends State<ContactView> {
  final _nameController = TextEditingController();
  final _phoneController = TextEditingController();
  final _contactController = ContactController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Contacts'),
      ),
      body: Column(
        children: [
          TextField(
            controller: _nameController,
            decoration: InputDecoration(
              hintText: 'Name',
            ),
          ),
          TextField(
            controller: _phoneController,
            decoration: InputDecoration(
              hintText: 'Phone Number',
            ),
          ),
          ElevatedButton(
            onPressed: () {
              _contactController.addContact(
                _nameController.text,
                _phoneController.text,
              );
              _nameController.clear();
              _phoneController.clear();
            },
            child: Text('Save'),
          ),
          Expanded(
            child: AnimatedBuilder(
              animation: _contactController,
              builder: (context, child) {
                return ListView.builder(
                  itemCount: _contactController.contacts.length,
                  itemBuilder: (context, index) {
                    final contact = _contactController.contacts[index];
                    return ListTile(
                      title: Text(contact.name),
                      subtitle: Text(contact.phoneNumber),
                      trailing: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          IconButton(
                            icon: Icon(Icons.edit),
                            onPressed: () {
                              _nameController.text = contact.name;
                              _phoneController.text = contact.phoneNumber;
                              showDialog(
                                context: context,
                                builder: (context) => AlertDialog(
                                  title: Text('Edit Contact'),
                                  content: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      TextField(
                                        controller: _nameController,
                                        decoration: InputDecoration(
                                          hintText: 'Name',
                                        ),
                                      ),
                                      TextField(
                                        controller: _phoneController,
                                        decoration: InputDecoration(
                                          hintText: 'Phone Number',
                                        ),
                                      ),
                                    ],
                                  ),
                                  actions: [
                                    TextButton(
                                      onPressed: () {
                                        _contactController.updateContact(
                                          index,
                                          _nameController.text,
                                          _phoneController.text,
                                        );
                                        Navigator.of(context).pop();
                                      },
                                      child: Text('Save'),
                                    ),
                                  ],
                                ),
                              );
                            },
                          ),
                          IconButton(
                            icon: Icon(Icons.delete),
                            onPressed: () {
                              _contactController.deleteContact(index);
                            },
                          ),
                        ],
                      ),
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}