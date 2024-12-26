import 'dart:convert';
import 'dart:developer';

import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:ordersanalysis/cubit/orders_state.dart';

import 'package:intl/intl.dart';
import 'package:ordersanalysis/models/order.dart';

class OrderCubit extends Cubit<OrderState> {
  OrderCubit() : super(OrderInitial());

  void loadOrders() async {
    try {
      final String response =
          await rootBundle.loadString('assets/orders-json.json');
      final List<dynamic> data = json.decode(response)['data']['orders'];
      log(data.toString());
      final orders = data.map((e) => Order.fromJson(e)).toList();
      log(orders.toString());

      // Calculate key metrics
      final totalOrders = orders.length;
      double totalSales = orders.fold(0.0, (sum, order) {
        log(order.price);
        double price = double.parse(order.price);
        return sum + price;
      });
      final averageSales = totalOrders > 0 ? totalSales / totalOrders : 0;
      final numberOfReturns =
          orders.where((order) => order.status == 'RETURNED').length;

      // Group by month and calculate number of orders per month
      final groupedOrders = _groupOrdersByMonth(orders);

      emit(OrderLoaded(
        totalOrders: totalOrders,
        averageSales: averageSales,
        numberOfReturns: numberOfReturns,
        groupedOrders: groupedOrders,
      ));
    } catch (e) {
      emit(const OrderError('Failed to load data'));
    }
  }

  List<OrderData> _groupOrdersByMonth(List<Order> orders) {
    final Map<String, int> ordersByMonth = {};

    for (var order in orders) {
      final month = DateFormat('MM').format(order.registered);
      ordersByMonth[month] = (ordersByMonth[month] ?? 0) + 1;
    }

    return ordersByMonth.entries.map((e) => OrderData(e.key, e.value)).toList();
  }
}
