import 'dart:convert';

import './address.dart';
import './company.dart';

class User {
  final int id;
  final String name;
  final String userName;
  final String email;
  final UserAddress address;
  final String phone;
  final String website;
  final Company company;

  User({
    required this.id,
    required this.name,
    required this.userName,
    required this.email,
    required this.address,
    required this.phone,
    required this.website,
    required this.company,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'username': userName,
      'email': email,
      'address': address.toMap(),
      'phone': phone,
      'website': website,
      'company': company.toMap(),
    };
  }

  factory User.fromMap(Map<String, dynamic> map) {
    return User(
      id: map['id']?.toInt() ?? 0,
      name: map['name'] ?? '',
      userName: map['username'] ?? '',
      email: map['email'] ?? '',
      address: UserAddress.fromMap(map['address']),
      phone: map['phone'] ?? '',
      website: map['website'] ?? '',
      company: Company.fromMap(map['company']),
    );
  }

  String toJson() => json.encode(toMap());

  factory User.fromJson(String source) => User.fromMap(json.decode(source));
}
