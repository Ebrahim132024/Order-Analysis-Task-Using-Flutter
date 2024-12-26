import 'dart:developer';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:ordersanalysis/cubit/orders_cubit.dart';
import 'package:ordersanalysis/cubit/orders_state.dart';

import 'package:ordersanalysis/localzations/lang_cubit.dart';
import 'package:ordersanalysis/utils/extensions/extensions.dart';

import 'package:ordersanalysis/utils/strings.dart';
import 'package:ordersanalysis/widgets/graph_order.dart';
import 'package:ordersanalysis/widgets/metric_card.dart';

class OrdersScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(AppStrings.orderAnalysis.tr()),
        actions: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                padding: EdgeInsets.zero,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10)),
              ),
              onPressed: () async {
                await BlocProvider.of<LangCubit>(context)
                    .toggleLanguage(context);
              },
              child: Text(context.locale.languageCode.toUpperCase() == 'AR'
                  ? 'ع'
                  : context.locale.languageCode.toUpperCase()),
            ),
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: BlocBuilder<OrderCubit, OrderState>(
          builder: (context, state) {
            if (state is OrderError) {
              return Center(child: Text(state.message));
            } else if (state is OrderLoaded) {
              return Column(
                children: [
                  // Key Metrics
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      metricCard(AppStrings.totalOrders.tr(),
                          state.totalOrders.toString()),
                      metricCard(AppStrings.avgSales.tr(),
                          state.averageSales.toStringAsFixed(2)),
                      metricCard(AppStrings.returns.tr(),
                          state.numberOfReturns.toString()),
                    ],
                  ),
                  SizedBox(height: context.height * 0.02),
                  // Graph using fl_chart
                  Expanded(
                      child:
                          CustomBarChart(groupedOrders: state.groupedOrders)),
                ],
              );
            }
            return const Center(child: CircularProgressIndicator());
          },
        ),
      ),
    );
  }
}
