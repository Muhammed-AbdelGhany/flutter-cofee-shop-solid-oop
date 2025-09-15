import 'package:flutter/material.dart';
import '../models/drink.dart';
import '../services/drink_factory.dart';
import '../services/order_manager.dart';

class AddOrderScreen extends StatefulWidget {
  final OrderManager orderManager;

  const AddOrderScreen({super.key, required this.orderManager});

  @override
  State<AddOrderScreen> createState() => _AddOrderScreenState();
}

class _AddOrderScreenState extends State<AddOrderScreen> {
  final _formKey = GlobalKey<FormState>();
  final _customerNameController = TextEditingController();
  final _specialInstructionsController = TextEditingController();

  String? _selectedDrinkName;
  final List<String> _availableDrinks = DrinkFactory.availableDrinks;

  @override
  void dispose() {
    _customerNameController.dispose();
    _specialInstructionsController.dispose();
    super.dispose();
  }

  void _submitOrder() {
    if (_formKey.currentState!.validate() && _selectedDrinkName != null) {
      try {
        final drink = DrinkFactory.createDrink(_selectedDrinkName!);

        widget.orderManager.addOrder(
          customerName: _customerNameController.text.trim(),
          drink: drink,
          specialInstructions: _specialInstructionsController.text.trim(),
        );

        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Order added successfully!')),
        );

        _customerNameController.clear();
        _specialInstructionsController.clear();
        setState(() {
          _selectedDrinkName = null;
        });
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error: $e')),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Order'),
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              TextFormField(
                controller: _customerNameController,
                decoration: const InputDecoration(
                  labelText: 'Customer Name',
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.person),
                ),
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'Please enter customer name';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              DropdownButtonFormField<String>(
                value: _selectedDrinkName,
                decoration: const InputDecoration(
                  labelText: 'Select Drink',
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.local_cafe),
                ),
                items: _availableDrinks.map((drink) {
                  final drinkObj = DrinkFactory.createDrink(drink);
                  return DropdownMenuItem(
                    value: drink,
                    child: Text(
                        '$drink - ${drinkObj.price.toStringAsFixed(2)} EGP'),
                  );
                }).toList(),
                onChanged: (value) {
                  setState(() {
                    _selectedDrinkName = value;
                  });
                },
                validator: (value) {
                  if (value == null) {
                    return 'Please select a drink';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _specialInstructionsController,
                decoration: const InputDecoration(
                  labelText: 'Special Instructions (Optional)',
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.note),
                  hintText: 'e.g., extra mint, ya rais!',
                ),
                maxLines: 3,
              ),
              const SizedBox(height: 24),
              ElevatedButton(
                onPressed: _submitOrder,
                child: const Text('Add Order'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
