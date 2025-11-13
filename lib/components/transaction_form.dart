import 'package:flutter/material.dart';

class TransactionForm extends StatefulWidget {
  final void Function(String, double) onSubmit;

  const TransactionForm(this.onSubmit, {super.key});

  @override
  State<TransactionForm> createState() => _TransactionFormState();
}

class _TransactionFormState extends State<TransactionForm> {
  final titleController = TextEditingController();
  final valueController = TextEditingController();

  _submitForm() {
    final title = titleController.text;
    final value = double.tryParse(valueController.text) ?? 0.0;

    if (title.isEmpty || value <= 0) {
      return;
    }

    widget.onSubmit(title, value);
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
                controller: titleController,
                decoration: InputDecoration(labelText: 'Titúlo'),
                onSubmitted: (_) =>
                    _submitForm(), // Quando clicado na seta de envio no teclado, aciona o método
              ),
              TextField(
                controller: valueController,
                decoration: InputDecoration(labelText: 'Valor R\$'),
                keyboardType: TextInputType.numberWithOptions(decimal: true),
                onSubmitted: (_) =>
                    _submitForm(), // Quando clicado na seta de envio no teclado, aciona o método
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
