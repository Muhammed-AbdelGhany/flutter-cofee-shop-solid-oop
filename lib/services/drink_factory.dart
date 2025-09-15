import '../models/drink.dart';

class DrinkFactory {
  static const List<String> availableDrinks = [
    'Shai',
    'Turkish Coffee',
    'Hibiscus Tea'
  ];

  static Drink createDrink(String drinkName) {
    switch (drinkName) {
      case 'Shai':
        return Shai();
      case 'Turkish Coffee':
        return TurkishCoffee();
      case 'Hibiscus Tea':
        return HibiscusTea();
      default:
        throw ArgumentError('Unknown drink type: $drinkName');
    }
  }

  static List<Drink> getAllDrinks() {
    return availableDrinks.map((name) => createDrink(name)).toList();
  }
}
