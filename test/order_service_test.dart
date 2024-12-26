import 'package:flutter_test/flutter_test.dart';

import 'dart:convert';

import 'package:ordersanalysis/cubit/orders_cubit.dart';
import 'package:ordersanalysis/models/order.dart';

void main() {
  group('loadOrders', () {
    late OrderCubit orderCubit;
    setUp(() {
      orderCubit = OrderCubit();
    });
    test('should calculate total orders and sales correctly', () async {
      // Sample mock response JSON
      final String response = '''{
        "data": {
          "orders": [
            {"id":"617ec83315ac5cc039950494","isActive":true,"price":"\$3164.16","company":"Delta Enterprises","buyer":"Charlie Brown","status":"ORDERED","registered":"2024-05-15T12:48:03"},
            {"id":"617ec8333eee751d6150968c","isActive":false,"price":"\$2599.06","company":"Delta Enterprises","buyer":"Alice Smith","status":"DELIVERED","registered":"2024-04-11T04:24:23"},
            {"id":"617ec833f12904d46ae13ea7","isActive":false,"price":"\$3778.80","company":"BetaCorp","buyer":"Diana Prince","status":"RETURNED","registered":"2024-07-02T04:56:54"}
          ]
        }
      }''';


      final orders = json
          .decode(response)['data']['orders']
          .map((e) => Order.fromJson(e))
          .toList();

      orderCubit.loadOrders();

      // Verifying calculations
      expect(orders.length, 3); // Verifying total orders
      expect(orders.where((order) => order.status == 'RETURNED').length,
          1); // Verifying Returns
      expect(
          orders.fold(0.0, (sum, order) => sum + double.parse(order.price)) /
              orders.length,
          3180.6733333333336); // Verifying Avg sales
    });
  });
}
