import '../models/order.dart';
import '../models/drink.dart';

class OrderManager {
  final List<Order> _orders = [];
  int _nextId = 1;

  void addOrder({
    required String customerName,
    required Drink drink,
    required String specialInstructions,
  }) {
    final order = Order(
      id: _nextId.toString(),
      customerName: customerName,
      drink: drink,
      specialInstructions: specialInstructions,
    );
    _orders.add(order);
    _nextId++;
  }

  List<Order> getAllOrders() {
    return List.unmodifiable(_orders);
  }

  List<Order> getPendingOrders() {
    return _orders.where((order) => order.isPending).toList();
  }

  List<Order> getCompletedOrders() {
    return _orders.where((order) => order.isCompleted).toList();
  }

  void completeOrder(String orderId) {
    final order = _orders.firstWhere(
      (order) => order.id == orderId,
      orElse: () => throw ArgumentError('Order not found: $orderId'),
    );
    order.markCompleted();
  }

  int get totalOrdersCount => _orders.length;
  int get pendingOrdersCount => getPendingOrders().length;
  int get completedOrdersCount => getCompletedOrders().length;
} 