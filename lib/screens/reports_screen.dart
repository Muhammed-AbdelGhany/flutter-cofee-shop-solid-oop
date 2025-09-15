import 'package:flutter/material.dart';
import '../services/order_manager.dart';
import '../services/report_generator.dart';

class ReportsScreen extends StatelessWidget {
  final OrderManager orderManager;
  final ReportGenerator reportGenerator;

  const ReportsScreen({
    super.key,
    required this.orderManager,
    required this.reportGenerator,
  });

  @override
  Widget build(BuildContext context) {
    final orders = orderManager.getAllOrders();
    final report = reportGenerator.generateDailySalesReport(orders);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Reports'),
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Card(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text('Sales Summary',
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold)),
                    const SizedBox(height: 10),
                    Text('Total Orders: ${report.totalOrders}'),
                    Text('Completed: ${report.completedOrders}'),
                    Text('Pending: ${report.pendingOrders}'),
                    Text(
                        'Revenue: ${report.totalRevenue.toStringAsFixed(2)} EGP'),
                    Text('Most Popular: ${report.mostPopularDrink}'),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 16),
            const Text(
              'Drink Breakdown',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Expanded(
              child: report.drinkBreakdown.isEmpty
                  ? const Center(
                      child: Text(
                        'No orders yet',
                        style: TextStyle(fontSize: 16, color: Colors.grey),
                      ),
                    )
                  : ListView.builder(
                      itemCount: report.drinkBreakdown.length,
                      itemBuilder: (context, index) {
                        final drinkReport = report.drinkBreakdown[index];
                        return Card(
                          child: ListTile(
                            leading: CircleAvatar(
                              backgroundColor: Colors.brown[700],
                              foregroundColor: Colors.white,
                              child: Text('${drinkReport.count}'),
                            ),
                            title: Text(drinkReport.drinkName),
                            subtitle: Text(
                                'Revenue: ${drinkReport.revenue.toStringAsFixed(2)} EGP'),
                            trailing: drinkReport.count > 0
                                ? Icon(
                                    Icons.trending_up,
                                    color: Colors.green[700],
                                  )
                                : null,
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
}
