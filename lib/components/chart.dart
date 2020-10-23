import 'package:expenses/components/chart_bar.dart';
import 'package:expenses/models/transactions.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class Chart extends StatelessWidget {
  const Chart(this.recentTransactions);

  final List<Transaction> recentTransactions;

  List<Map<String, Object>> get groupedTransactions {
    return List.generate(7, (index) {
      final weekDay = DateTime.now().subtract(Duration(days: index));
      double totalSumOfRecentTransactions = 0.0;
      recentTransactions.forEach((element) {
        bool sameDay = element.date.day == weekDay.day;
        bool sameMOnth = element.date.month == weekDay.month;
        bool sameYear = element.date.year == weekDay.year;
        if (sameDay && sameMOnth && sameYear)
          totalSumOfRecentTransactions += element.value;
      });
      return {
        'day': DateFormat.E().format(weekDay)[0],
        'value': totalSumOfRecentTransactions
      };
    });
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      margin: EdgeInsets.all(20),
      child: Row(
        children: groupedTransactions.map((e) {
          return ChartBar(
            label: e['day'],
            value: e['value'],
            percentage: 0,
          );
        }).toList(),
      ),
    );
  }
}
