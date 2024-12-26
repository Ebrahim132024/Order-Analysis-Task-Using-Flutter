import 'package:equatable/equatable.dart';
import 'package:ordersanalysis/models/order.dart';

abstract class OrderState extends Equatable {
  const OrderState();

  @override
  List<Object> get props => [];
}

class OrderInitial extends OrderState {}

class OrderLoaded extends OrderState {
  final int totalOrders;
  final dynamic averageSales;
  final int numberOfReturns;
  final List<OrderData> groupedOrders;

  const OrderLoaded({
    required this.totalOrders,
    required this.averageSales,
    required this.numberOfReturns,
    required this.groupedOrders,
  });

  @override
  List<Object> get props => [totalOrders, averageSales, numberOfReturns, groupedOrders];
}

class OrderError extends OrderState {
  final String message;

  const OrderError(this.message);

  @override
  List<Object> get props => [message];
}