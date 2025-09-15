import '../models/order.dart';

class DrinkReport {
  final String drinkName;
  final int count;
  final double revenue;

  DrinkReport({
    required this.drinkName,
    required this.count,
    required this.revenue,
  });
}

class DailySalesReport {
  final int totalOrders;
  final int completedOrders;
  final int pendingOrders;
  final double totalRevenue;
  final String mostPopularDrink;
  final List<DrinkReport> drinkBreakdown;

  DailySalesReport({
    required this.totalOrders,
    required this.completedOrders,
    required this.pendingOrders,
    required this.totalRevenue,
    required this.mostPopularDrink,
    required this.drinkBreakdown,
  });
}

class ReportGenerator {
  DailySalesReport generateDailySalesReport(List<Order> orders) {
    final drinkCounts = <String, int>{};
    final drinkRevenue = <String, double>{};
    double totalRevenue = 0;
    int completedCount = 0;

    for (final order in orders) {
      final drinkName = order.drink.name;
      drinkCounts[drinkName] = (drinkCounts[drinkName] ?? 0) + 1;

      if (order.isCompleted) {
        completedCount++;
        final revenue = order.totalPrice;
        totalRevenue += revenue;
        drinkRevenue[drinkName] = (drinkRevenue[drinkName] ?? 0) + revenue;
      }
    }

    final drinkBreakdown = drinkCounts.entries.map((entry) {
      return DrinkReport(
        drinkName: entry.key,
        count: entry.value,
        revenue: drinkRevenue[entry.key] ?? 0,
      );
    }).toList();

    drinkBreakdown.sort((a, b) => b.count.compareTo(a.count));

    final mostPopular = drinkBreakdown.isNotEmpty
        ? drinkBreakdown.first.drinkName
        : 'No orders yet';

    return DailySalesReport(
      totalOrders: orders.length,
      completedOrders: completedCount,
      pendingOrders: orders.length - completedCount,
      totalRevenue: totalRevenue,
      mostPopularDrink: mostPopular,
      drinkBreakdown: drinkBreakdown,
    );
  }

  Map<String, int> getDrinkPopularityCount(List<Order> orders) {
    final drinkCounts = <String, int>{};

    for (final order in orders) {
      final drinkName = order.drink.name;
      drinkCounts[drinkName] = (drinkCounts[drinkName] ?? 0) + 1;
    }

    return drinkCounts;
  }
}
