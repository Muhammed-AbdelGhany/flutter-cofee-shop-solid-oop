import 'drink.dart';
import 'order_status.dart';

class Order {
  final String _id;
  final String _customerName;
  final Drink _drink;
  final String _specialInstructions;
  
  OrderStatus _status;

  Order({
    required String id,
    required String customerName,
    required Drink drink,
    required String specialInstructions,
  })  : _id = id,
        _customerName = customerName,
        _drink = drink,
        _specialInstructions = specialInstructions,
        _status = OrderStatus.pending {
    if (customerName.trim().isEmpty) {
      throw ArgumentError('Customer name cannot be empty');
    }
  }

  String get id => _id;
  String get customerName => _customerName;
  Drink get drink => _drink;
  String get specialInstructions => _specialInstructions;
  OrderStatus get status => _status;

  bool get isCompleted => _status == OrderStatus.completed;
  bool get isPending => _status == OrderStatus.pending;

  void markCompleted() {
    if (_status == OrderStatus.pending) {
      _status = OrderStatus.completed;
    }
  }

  double get totalPrice => _drink.price;

 
}
