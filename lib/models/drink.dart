abstract class Drink {
  String get name;
  String get description;
  double get price;

  String prepare();

  @override
  String toString() => name;
}

class Shai extends Drink {
  @override
  String get name => "Shai";

  @override
  String get description => "Traditional Egyptian tea with mint";

  @override
  double get price => 5.0;

  @override
  String prepare() =>
      "Boiling water, adding tea leaves and fresh mint, ya rais!";
}

class TurkishCoffee extends Drink {
  @override
  String get name => "Turkish Coffee";

  @override
  String get description =>
      "Rich and strong coffee prepared in traditional style";

  @override
  double get price => 12.0;

  @override
  String prepare() =>
      "Grinding beans finely, brewing in cezve with perfect foam";
}

class HibiscusTea extends Drink {
  @override
  String get name => "Hibiscus Tea";

  @override
  String get description => "Refreshing herbal tea with vibrant red color";

  @override
  double get price => 8.0;

  @override
  String prepare() => "Steeping dried hibiscus flowers in hot water";
}
