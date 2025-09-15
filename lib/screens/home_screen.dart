import 'package:flutter/material.dart';
import '../models/order.dart';
import '../services/order_manager.dart';
import '../services/report_generator.dart';
import '../widgets/order_tile.dart';
import 'add_order_screen.dart';
import 'reports_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final OrderManager _orderManager = OrderManager();
  final ReportGenerator _reportGenerator = ReportGenerator();

  void _refreshOrders() {
    setState(() {});
  }

  void _completeOrder(String orderId) {
    setState(() {
      _orderManager.completeOrder(orderId);
    });
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Order completed!')),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Ahwa Manager'),
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white,
      ),
      body: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                  onPressed: () async {
                    await Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>
                            AddOrderScreen(orderManager: _orderManager),
                      ),
                    );
                    _refreshOrders();
                  },
                  child: const Text('Add Order'),
                ),
                ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ReportsScreen(
                          orderManager: _orderManager,
                          reportGenerator: _reportGenerator,
                        ),
                      ),
                    );
                  },
                  child: const Text('View Reports'),
                ),
              ],
            ),
          ),
          Expanded(child: _buildOrdersList()),
        ],
      ),
    );
  }

  Widget _buildOrdersList() {
    final allOrders = _orderManager.getAllOrders();

    if (allOrders.isEmpty) {
      return const Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.coffee, size: 64, color: Colors.grey),
            SizedBox(height: 16),
            Text(
              'No orders yet',
              style: TextStyle(fontSize: 18, color: Colors.grey),
            ),
            Text(
              'Add a new order to get started!',
              style: TextStyle(color: Colors.grey),
            ),
          ],
        ),
      );
    }

    return ListView.builder(
      itemCount: allOrders.length,
      itemBuilder: (context, index) {
        final order = allOrders[index];
        return OrderTile(
          order: order,
          onComplete: order.isPending ? () => _completeOrder(order.id) : null,
        );
      },
    );
  }
}
