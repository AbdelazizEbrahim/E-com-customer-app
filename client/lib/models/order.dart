import 'dart:convert';
import 'package:client/models/cart_item.dart';

class Order {
  final String id;
  final List<CartItem> items;
  final double totalPrice;
  final String shippingName;
  final String shippingAddress;
  final String city;
  final String postalCode;
  final String shippingPhone;
  final String userId;
  final DateTime createdAt;

  Order({
    required this.id,
    required this.items,
    required this.totalPrice,
    required this.shippingName,
    required this.shippingAddress,
    required this.city,
    required this.postalCode,
    required this.shippingPhone,
    required this.userId,
    required this.createdAt,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'items': jsonEncode(items.map((item) => item.toMap()).toList()),
      'totalPrice': totalPrice,
      'shippingName': shippingName,
      'shippingAddress': shippingAddress,
      'city': city,
      'postalCode': postalCode,
      'shippingPhone': shippingPhone,
      'userId': userId,
      'createdAt': createdAt.toIso8601String(),
    };
  }

  factory Order.fromMap(Map<String, dynamic> map) {
    return Order(
      id: map['id'],
      items:
          (jsonDecode(map['items']) as List)
              .map((item) => CartItem.fromMap(item))
              .toList(),
      totalPrice: map['totalPrice'],
      shippingName: map['shippingName'],
      shippingAddress: map['shippingAddress'],
      city: map['city'],
      postalCode: map['postalCode'],
      shippingPhone: map['shippingPhone'],
      userId: map['userId'],
      createdAt: DateTime.parse(map['createdAt']),
    );
  }
}
