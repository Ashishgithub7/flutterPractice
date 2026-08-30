import "package:flutter/material.dart";
import "package:expense_tracker/models/expense.dart";

class NewExpense extends StatefulWidget {
  final Function (Expense) addExpense;
  const NewExpense(this.addExpense,{super.key});

  @override
  State<NewExpense> createState() {
    return _NewExpenseState();
  }
}

class _NewExpenseState extends State<NewExpense> {
  final _titleController = TextEditingController();
  final _amountController = TextEditingController();
  DateTime? _expenseDate;
  Category _selectedCategory = Category.leisure;

  void _submitExpense() {
    final _enteredAmount = double.tryParse(_amountController.text);
    final isAmountInvalid = _enteredAmount == null || _enteredAmount <= 0;

    if (_titleController.text.trim().isEmpty ||
        isAmountInvalid ||
        _expenseDate == null) {
      showDialog(
        context: context,
        builder: (ctx) => AlertDialog(
          title: Text("Invalid input"),
          content: Text(
            "Please enter a valid title, amount, date and category",
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(ctx),
              child: Text("Okay"),
            ),
          ],
        ),
      );
      return;
    } else {
      final newExpense = Expense(
        title: _titleController.text,
        price: _enteredAmount,
        date: _expenseDate!,
        category: _selectedCategory,
      );
      widget.addExpense(newExpense);
      Navigator.pop(context);
    }
  }

  @override
  void dispose() {
    _titleController.dispose();
    _amountController.dispose();
    super.dispose();
  }

  void _showCalender() async {
    var now = DateTime.now();
    var firstDate = DateTime(now.year - 1, now.month, now.day);
    final _pickedDate = await showDatePicker(
      context: context,
      initialDate: now,
      firstDate: firstDate,
      lastDate: now,
    );
    setState(() {
      _expenseDate = _pickedDate;
    });
  }

  @override
  Widget build(context) {
    final keyboardOverlapSpace = MediaQuery.of(context).viewInsets.bottom;
    return LayoutBuilder(builder: (ctx, constraints){
      final width = constraints.maxWidth;
      return SizedBox(
      height: double.infinity,
      child: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.fromLTRB(16,48,16, keyboardOverlapSpace + 16),
          child: Column(
            children: [
              if (width>=600)
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: TextField(
                                    controller: _titleController,
                                    maxLength: 50,
                                    decoration: InputDecoration(label: Text("Title")),
                                  ),
                  ),
                  SizedBox(width:24),
              Expanded(
                    child: TextField(
                      decoration: InputDecoration(
                        prefixText: "Rs ",
                        label: Text('Amount'),
                      ),
                      keyboardType: TextInputType.number,
                      controller: _amountController,
                    ),
                  ),
                ],
              )
              else
              TextField(
                controller: _titleController,
                maxLength: 50,
                decoration: InputDecoration(label: Text("Title")),
              ),
              SizedBox(height: 8),
              if(width>=600)
              Row(children: [
                DropdownButton(
                    value: _selectedCategory,
                    items: Category.values
                        .map(
                          (category) => DropdownMenuItem(
                            value: category,
                            child: Text(
                              category.name.toUpperCase(),
                              style: TextStyle(fontSize: 14),
                            ),
                          ),
                        )
                        .toList(),
                    onChanged: (value) {
                      if (value == null) return;
                      setState(() {
                        _selectedCategory = value;
                      });
                    },
                  ),
                  Spacer(),
                  Expanded(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          _expenseDate == null
                              ? "Select a date"
                              : formatter.format(_expenseDate!),
                        ),
                        IconButton(
                          onPressed: _showCalender,
                          icon: const Icon(Icons.calendar_month),
                        ),
                      ],
                    ),
                  ),
              ],)
              else
              Row(
                children: [
                  Expanded(
                    child: TextField(
                      decoration: InputDecoration(
                        prefixText: "Rs ",
                        label: Text('Amount'),
                      ),
                      keyboardType: TextInputType.number,
                      controller: _amountController,
                    ),
                  ),
                  SizedBox(width: 16),
                  Expanded(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          _expenseDate == null
                              ? "Select a date"
                              : formatter.format(_expenseDate!),
                        ),
                        IconButton(
                          onPressed: _showCalender,
                          icon: const Icon(Icons.calendar_month),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              SizedBox(height: 20,),
              Row(
                children: [
                  if(width<600)
                  DropdownButton(
                    value: _selectedCategory,
                    items: Category.values
                        .map(
                          (category) => DropdownMenuItem(
                            value: category,
                            child: Text(
                              category.name.toUpperCase(),
                              style: TextStyle(fontSize: 14),
                            ),
                          ),
                        )
                        .toList(),
                    onChanged: (value) {
                      if (value == null) return;
                      setState(() {
                        _selectedCategory = value;
                      });
                    },
                  ),
                  Spacer(),
                  TextButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: Text("Cancel"),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      _submitExpense();
                    },
                    child: Text("Submit"),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
    });  
    
  }
}
