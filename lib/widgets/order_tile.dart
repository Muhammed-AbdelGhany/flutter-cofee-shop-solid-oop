import 'package:flutter/material.dart';
import '../models/order.dart';

class OrderTile extends StatelessWidget {
  final Order order;
  final VoidCallback? onComplete;

  const OrderTile({
    super.key,
    required this.order,
    this.onComplete,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(8),
      child: ListTile(
        title: Text('${order.customerName} - ${order.drink.name}'),
        subtitle: order.specialInstructions.isNotEmpty
            ? Text(order.specialInstructions)
            : null,
        trailing: order.isCompleted
            ? const Text('Done', style: TextStyle(color: Colors.green))
            : onComplete != null
                ? ElevatedButton(
                    onPressed: onComplete,
                    child: const Text('Complete'),
                  )
                : null,
      ),
    );
  }
}
