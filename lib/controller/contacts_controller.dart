import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:sql/model/contacts_model.dart';

class ContactController extends ChangeNotifier {
  final List<Contact> _contacts = [];

  UnmodifiableListView<Contact> get contacts => UnmodifiableListView(_contacts);

  void addContact(String name, String phoneNumber) {
    final contact = Contact(name: name, phoneNumber: phoneNumber);
    _contacts.add(contact);
    notifyListeners();
  }

  void updateContact(int index, String name, String phoneNumber) {
    _contacts[index].name = name;
    _contacts[index].phoneNumber = phoneNumber;
    notifyListeners();
  }

  void deleteContact(int index) {
    _contacts.removeAt(index);
    notifyListeners();
  }
}
