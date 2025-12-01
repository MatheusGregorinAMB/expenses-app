import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class TransactionForm extends StatefulWidget {
  final void Function(String, double) onSubmit;

  const TransactionForm(this.onSubmit, {super.key});

  @override
  State<TransactionForm> createState() => _TransactionFormState();
}

class _TransactionFormState extends State<TransactionForm> {
  final _titleController = TextEditingController();
  final _valueController = TextEditingController();
  DateTime? _selectedDate = null;

  _submitForm() {
    final title = _titleController.text;
    final value = double.tryParse(_valueController.text) ?? 0.0;

    if (title.isEmpty || value <= 0) {
      return;
    }

    widget.onSubmit(title, value);
  }

  _showDatePicker() {
    showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2024),
      lastDate: DateTime.now(),
    ).then((pickedDate) {
      if (pickedDate == null) {
        return;
      }
      setState(() {
        _selectedDate = pickedDate;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            spacing: 50,
            children: <Widget>[
              TextField(
                controller: _titleController,
                decoration: InputDecoration(labelText: 'Titúlo'),
                onSubmitted: (_) =>
                    _submitForm(), // Quando clicado na seta de envio no teclado, aciona o método
              ),
              TextField(
                controller: _valueController,
                decoration: InputDecoration(labelText: 'Valor R\$'),
                keyboardType: TextInputType.numberWithOptions(decimal: true),
                onSubmitted: (_) =>
                    _submitForm(), // Quando clicado na seta de envio no teclado, aciona o método
              ),
              Row(
                children: <Widget>[
                  Text(
                    _selectedDate == null
                        ? 'Nenhuma data selecionada!'
                        : 'Data: ${DateFormat('dd/MM/yyyy').format(_selectedDate!)}',
                  ),
                  TextButton(
                    onPressed: _showDatePicker,
                    child: Text(
                      _selectedDate == null
                          ? 'Selecionar data'
                          : 'Selecionar outra data',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  ElevatedButton(
                    onPressed:
                        _submitForm, // Quando clicado no botão, aciona o método
                    style: ButtonStyle(),
                    child: Text(
                      'Nova Transação',
                      style: TextStyle(color: Colors.blue),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
