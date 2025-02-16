import 'package:batch_9_apps/features/expense-tracker/models/expense_model.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class ExpenseTrackerScreen extends StatefulWidget {
  const ExpenseTrackerScreen({super.key});

  @override
  State<ExpenseTrackerScreen> createState() => _ExpenseTrackerScreenState();
}

class _ExpenseTrackerScreenState extends State<ExpenseTrackerScreen> {
  final TextEditingController _titleTEController = TextEditingController();
  final TextEditingController _amountTEController = TextEditingController();
  final List<ExpenseModel> _expensesList = [];
  final List<String> _categoriesList = [
    'Food',
    'Transport',
    'Entertainment',
    'Other'
  ];
  double _totalExpenses = 0.0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.green.shade100,
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.green,
        foregroundColor: Colors.white,
        title: Text('Expense Tracker'),
        actions: [
          IconButton(
            onPressed: () => _showMBSheet(),
            icon: Icon(Icons.add),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _showMBSheet(),
        child: Icon(Icons.add),
      ),
      body: Center(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(4.0),
              child: Card(
                margin: EdgeInsets.all(8),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children: [
                      Text(
                        'Total Expenses',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 4),
                      Text(
                        '\$$_totalExpenses',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w500,
                          color: Colors.green,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Expanded(
              child: ListView.builder(
                itemCount: _expensesList.length,
                itemBuilder: (context, index) {
                  return Dismissible(
                    key: Key(_expensesList[index].hashCode.toString()),
                    background: Container(color: Colors.red),
                    onDismissed: (direction) => _deleteExpense(index),
                    child: Card(
                      margin: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                      child: Column(
                        children: [
                          Row(
                            children: [
                              Container(
                                width: 120,
                                height: 80,
                                color: Colors.green,
                                child: Center(
                                  child: FittedBox(
                                    child: Text(
                                      _expensesList[index].category,
                                      style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(width: 12),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          _expensesList[index].title,
                                          style: TextStyle(
                                              fontSize: 24,
                                              fontWeight: FontWeight.w500),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 16.0),
                                          child: Text(
                                            '\$${_expensesList[index].amount}',
                                            style: TextStyle(
                                              fontSize: 24,
                                              fontWeight: FontWeight.w500,
                                              color: Colors.green,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                    SizedBox(height: 8),
                                    Text(
                                      DateFormat.yMMMMd()
                                          .format(_expensesList[index].date),
                                      style: TextStyle(fontSize: 16),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                          Container(
                            width: double.infinity,
                            height: 40,
                            decoration: BoxDecoration(
                              color: Colors.green.shade300,
                              borderRadius: BorderRadius.only(
                                bottomLeft: Radius.circular(8),
                                bottomRight: Radius.circular(8),
                              ),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                TextButton.icon(
                                  onPressed: () {
                                    _showMBSheet(
                                      expense: _expensesList[index],
                                      index: index,
                                    );
                                  },
                                  label: Text(
                                    'Edit',
                                    style: TextStyle(
                                        color: Colors.black87, fontSize: 16),
                                  ),
                                  icon: Icon(
                                    Icons.edit,
                                    color: Colors.black87,
                                    size: 20,
                                  ),
                                ),
                                TextButton.icon(
                                  onPressed: () {
                                    showDialog(
                                      barrierDismissible: false,
                                      context: context,
                                      builder: (context) => AlertDialog(
                                        content: Text(
                                          'Do you want to delete?',
                                          style: TextStyle(
                                            fontSize: 18,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.red,
                                          ),
                                        ),
                                        actions: [
                                          MaterialButton(
                                            onPressed: () {
                                              Navigator.pop(context);
                                            },
                                            child: Text(
                                              'No',
                                              style: TextStyle(
                                                fontSize: 16,
                                                color: Colors.green,
                                              ),
                                            ),
                                          ),
                                          MaterialButton(
                                            onPressed: () {
                                              _deleteExpense(index);
                                              Navigator.pop(context);
                                            },
                                            child: Text(
                                              'Yes',
                                              style: TextStyle(
                                                fontSize: 16,
                                                color: Colors.red,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    );
                                  },
                                  label: Text(
                                    'Delete',
                                    style: TextStyle(
                                        color: Colors.red, fontSize: 16),
                                  ),
                                  icon: Icon(
                                    Icons.delete,
                                    color: Colors.red,
                                    size: 20,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _showMBSheet({ExpenseModel? expense, int? index}) {
    String selectedCategory = expense?.category ?? _categoriesList.first;
    _titleTEController.text = expense?.title ?? '';
    _amountTEController.text = expense?.amount.toString() ?? '';
    showModalBottomSheet(
      isScrollControlled: true,
      context: context,
      builder: (_) {
        return Padding(
          padding: EdgeInsets.only(
            bottom: MediaQuery.of(context).viewInsets.bottom,
            left: 16,
            right: 16,
            top: 16,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: _titleTEController,
                decoration: InputDecoration(labelText: 'Title: '),
              ),
              SizedBox(height: 10),
              TextField(
                controller: _amountTEController,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(labelText: 'Amount: '),
              ),
              SizedBox(height: 10),
              DropdownButtonFormField<String>(
                items: _categoriesList
                    .map((category) => DropdownMenuItem(
                        value: category, child: Text(category)))
                    .toList(),
                onChanged: (value) => selectedCategory = value!,
                decoration: InputDecoration(labelText: 'Category:'),
              ),
              SizedBox(height: 20),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  padding: EdgeInsets.all(8),
                  backgroundColor: Colors.green,
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                onPressed: () {
                  double? amount = double.tryParse(_amountTEController.text);
                  if(_titleTEController.text.isEmpty || amount == null) return;
                  if(index != null) {
                    _editExpense(index, _titleTEController.text, amount, selectedCategory);
                  } else {
                    _addExpense(
                      _titleTEController.text,
                      double.parse(_amountTEController.text),
                      DateTime.now(),
                      selectedCategory,
                    );
                  }

                  _clearAfterAdd();
                  Navigator.pop(context);
                },
                child: Text(index != null ? 'Edit Expense' : 'Add Expense',
                    style: TextStyle(fontSize: 20)),
              ),
              SizedBox(height: 20),
            ],
          ),
        );
      },
    );
  }

  void _addExpense(
      String title, double amount, DateTime date, String category) {
    _expensesList.add(ExpenseModel(
        title: title, amount: amount, date: date, category: category));
    _totalExpenses += amount;
    setState(() {});
  }

  void _clearAfterAdd() {
    _titleTEController.clear();
    _amountTEController.clear();
  }

  void _deleteExpense(int index) {
    _totalExpenses -= _expensesList[index].amount;
    _expensesList.removeAt(index);
    setState(() {});
  }

  void _editExpense(int index, String title, double amount, String category) {
    setState(() {
      _totalExpenses = _totalExpenses - _expensesList[index].amount + amount;
      _expensesList[index] = ExpenseModel(
        title: title,
        amount: amount,
        date: _expensesList[index].date,
        category: category,
      );
    });
  }
}
