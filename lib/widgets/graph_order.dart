import 'package:easy_localization/easy_localization.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:ordersanalysis/models/order.dart';
import 'package:ordersanalysis/utils/strings.dart';

class CustomBarChart extends StatelessWidget {
  final List<OrderData> groupedOrders;

  const CustomBarChart({Key? key, required this.groupedOrders})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BarChart(
      BarChartData(
        titlesData: FlTitlesData(
          leftTitles: AxisTitles(
            sideTitles: SideTitles(
              showTitles: true,
              reservedSize: 40,
              getTitlesWidget: (double value, TitleMeta meta) {
                return Padding(
                  padding: const EdgeInsets.only(right: 8.0),
                  child: Text(value.toString()),
                );
              },
            ),
          ),
          topTitles: const AxisTitles(
            sideTitles: SideTitles(showTitles: false),
          ),
          rightTitles: const AxisTitles(
            sideTitles: SideTitles(showTitles: false),
          ),
          bottomTitles: AxisTitles(
            axisNameWidget: Text(
              AppStrings.months.tr(),
              style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
            ),
            axisNameSize: 40, // Space for the title
            sideTitles: SideTitles(
              showTitles: true,
              reservedSize: 40,
              getTitlesWidget: (double value, TitleMeta meta) {
                final month = groupedOrders[value.toInt()].month;
                return Padding(
                  padding: const EdgeInsets.only(top: 8.0),
                  child: Text(month),
                );
              },
            ),
          ),
        ),
        borderData: FlBorderData(show: true),
        barGroups: groupedOrders.map((data) {
          return BarChartGroupData(
            x: groupedOrders.indexOf(data),
            barsSpace: 50,
            barRods: [
              BarChartRodData(
                toY: data.orderCount.toDouble(),
                color: Colors.blue,
                width: 25,
              ),
            ],
          );
        }).toList(),
      ),
    );
  }
}
