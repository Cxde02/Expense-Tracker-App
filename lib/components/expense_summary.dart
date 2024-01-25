import 'package:flutter/material.dart';
import 'package:flutter_application_1/bar%20graph/bar_graph.dart';
import 'package:flutter_application_1/data/expense_data.dart';
import 'package:flutter_application_1/datetime/date_time_helper.dart';
import 'package:provider/provider.dart';

class ExpenseSummary extends StatelessWidget {
  final DateTime startOfWeek;
  const ExpenseSummary({
    super.key,
    required this.startOfWeek,
  });

  //calc max amount in bar graph
  double calculateMax(
      ExpenseData value,
      String monday,
      String tuesday,
      String wednesday,
      String thursday,
      String friday,
      String saturday,
      String sunday) {
    double? max = 100;

    List<double> values = [
      value.calculateDailyExpenseSummary()[monday] ?? 0,
      value.calculateDailyExpenseSummary()[tuesday] ?? 0,
      value.calculateDailyExpenseSummary()[wednesday] ?? 0,
      value.calculateDailyExpenseSummary()[thursday] ?? 0,
      value.calculateDailyExpenseSummary()[friday] ?? 0,
      value.calculateDailyExpenseSummary()[saturday] ?? 0,
      value.calculateDailyExpenseSummary()[sunday] ?? 0,
    ];

    //sort from smallest to largest
    values.sort();
    //get largest amount and increase the cap to make graph look almost full
    max = values.last * 1.1;
    return max == 0 ? 100 : max;
  }

  //calculate week total
  String calculateWeekTotal(
      ExpenseData value,
      String monday,
      String tuesday,
      String wednesday,
      String thursday,
      String friday,
      String saturday,
      String sunday) {
    List<double> values = [
      value.calculateDailyExpenseSummary()[monday] ?? 0,
      value.calculateDailyExpenseSummary()[tuesday] ?? 0,
      value.calculateDailyExpenseSummary()[wednesday] ?? 0,
      value.calculateDailyExpenseSummary()[thursday] ?? 0,
      value.calculateDailyExpenseSummary()[friday] ?? 0,
      value.calculateDailyExpenseSummary()[saturday] ?? 0,
      value.calculateDailyExpenseSummary()[sunday] ?? 0,
    ];

    double total = 0;
    for (int i = 0; i < values.length; i++) {
      total += values[i];
    }

    return total.toStringAsFixed(2);
  }

  @override
  Widget build(BuildContext context) {
    //get ddmmyyyy for each day of the week
    String monday =
        convertDateTimeToString(startOfWeek.add(const Duration(days: 0)));
    String tuesday =
        convertDateTimeToString(startOfWeek.add(const Duration(days: 1)));
    String wednesday =
        convertDateTimeToString(startOfWeek.add(const Duration(days: 2)));
    String thursday =
        convertDateTimeToString(startOfWeek.add(const Duration(days: 3)));
    String friday =
        convertDateTimeToString(startOfWeek.add(const Duration(days: 4)));
    String saturday =
        convertDateTimeToString(startOfWeek.add(const Duration(days: 5)));
    String sunday =
        convertDateTimeToString(startOfWeek.add(const Duration(days: 6)));

    return Consumer<ExpenseData>(
      builder: (context, value, child) => Column(
        children: [
          //Week total
          Padding(
            padding: const EdgeInsets.fromLTRB(30, 10, 0, 10),
            child: Row(
              children: [
                const Text(
                  'Week Total: ',
                  style: TextStyle(
                      fontWeight: FontWeight.bold, fontFamily: 'Poppins'),
                ),
                Text(
                  'Rs ${calculateWeekTotal(value, monday, tuesday, wednesday, thursday, friday, saturday, sunday)}',
                  style: TextStyle(fontFamily: 'Poppins'),
                ),
              ],
            ),
          ),

          //bar graph
          SizedBox(
            height: 200,
            child: MyBarGraph(
              maxY: calculateMax(value, monday, tuesday, wednesday, thursday,
                  friday, saturday, sunday),
              monAmount: value.calculateDailyExpenseSummary()[monday] ?? 0,
              tueAmount: value.calculateDailyExpenseSummary()[tuesday] ?? 0,
              wedAmount: value.calculateDailyExpenseSummary()[wednesday] ?? 0,
              thurAmount: value.calculateDailyExpenseSummary()[thursday] ?? 0,
              friAmount: value.calculateDailyExpenseSummary()[friday] ?? 0,
              satAmount: value.calculateDailyExpenseSummary()[saturday] ?? 0,
              sunAmount: value.calculateDailyExpenseSummary()[sunday] ?? 0,
            ),
          ),
        ],
      ),
    );
  }
}
