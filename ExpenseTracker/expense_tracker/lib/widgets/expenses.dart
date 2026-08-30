import 'package:expense_tracker/chart/chart.dart';
import 'package:expense_tracker/widgets/expenses_list/new_expense.dart';
import 'package:flutter/material.dart';
import 'package:expense_tracker/models/expense.dart';
import 'expenses_list/expense_list.dart';

class Expenses extends StatefulWidget {
  Expenses({super.key});

  @override
  State<Expenses> createState() {
    return _ExpensesState();
  }
}

class _ExpensesState extends State<Expenses> {
  final List<Expense> _registeredExpenses = [
    Expense(
      title: "MoMo",
      price: 120,
      date: DateTime.now(),
      category: Category.food,
    ),
    Expense(
      title: "Flutter Course",
      price: 19.99,
      date: DateTime.now(),
      category: Category.work,
    ),
  ];
  void _openAddOverlayExpense() {
    showModalBottomSheet(
      useSafeArea: true,
      isScrollControlled: true,
      context: context,
      builder: (ctx) => SizedBox(child: NewExpense(addExpense)),
    );
  }

  void addExpense(Expense ex) {
    setState(() {
      _registeredExpenses.add(ex);
    });
  }

  void _removeExpense(Expense ex) {
    final expenseIndex = _registeredExpenses.indexOf(ex);
    setState(() {
      _registeredExpenses.remove(ex);
    });
    ScaffoldMessenger.of(context).clearSnackBars();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        duration: const Duration(seconds: 2),
        persist:false,
        content: Text("Expense with title ${ex.title} deleted"),
        action: SnackBarAction(label: 'Undo', 
          onPressed: (){
            setState((){
              _registeredExpenses.insert(expenseIndex, ex);
            });
        }),
      ),
    );
  }

  @override
  Widget build(context) {
    final deviceWidth = MediaQuery.of(context).size.width;

    Widget expenseContent = Center(child: Text("No expense data to show!"));
    if (_registeredExpenses.isNotEmpty) {
      expenseContent = ExpenseList(
        expenses: _registeredExpenses,
        removeExpense: _removeExpense,
      );
    }
    return Scaffold(
      appBar: AppBar(
        title: Text("Expense Tracker"),
        actions: [
          IconButton(onPressed: _openAddOverlayExpense, icon: Icon(Icons.add)),
        ],
      ),
      body: deviceWidth<=600 ? Expanded(
        child: Column(
          children: [
            Chart(expenses: _registeredExpenses),
            Expanded(child: expenseContent),
          ],
        ),
      ):Expanded(
        child: Row(
          children: [
            Expanded(child: Chart(expenses: _registeredExpenses)),
            Expanded(child: expenseContent),
          ],
        ),
      )
    );
  }
}
