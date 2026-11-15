// PC16 – Mobile Development with Lab
// Week 9: Object-Oriented Programming in Dart (Part 1)
// Your Turn: Submit Your OOP Program
//
// Object modeled: a Jeepney (from the ice breaker activity).
//   Properties -> fields   : plateNumber, route, driverName, capacity,
//                            passengers (private), earnings (private), fare (private)
//   Behaviors  -> methods  : board(), alight(), collectFare(), displayInfo()

/// A Philippine jeepney that carries passengers along a fixed route.
class Jeepney {
  // ---------- Public fields ----------
  final String plateNumber;
  final String route;
  String driverName;
  final int capacity;

  // ---------- Private fields (encapsulation) ----------
  int _passengers = 0;
  double _earnings = 0.0;
  double _fare;

  /// Fare history: a List that records every fare collected.
  final List<double> _fareLog = [];

  // ---------- Constructor ----------
  /// Sets the initial values of the jeepney when it is created.
  Jeepney(
    this.plateNumber,
    this.route,
    this.driverName, {
    this.capacity = 20,
    double fare = 13.0,
  }) : _fare = fare;

  // ---------- Getters (read-only access to private fields) ----------
  int get passengers => _passengers;
  double get earnings => _earnings;
  double get fare => _fare;
  int get availableSeats => capacity - _passengers;
  bool get isFull => _passengers >= capacity;
  List<double> get fareLog => List.unmodifiable(_fareLog);

  // ---------- Setter with validation ----------
  /// Updates the fare only if the new value is valid.
  set fare(double newFare) {
    if (newFare <= 0) {
      print('  [!] Invalid fare: PHP ${newFare.toStringAsFixed(2)}. Fare unchanged.');
      return;
    }
    _fare = newFare;
    print('  Fare for $plateNumber updated to PHP ${_fare.toStringAsFixed(2)}.');
  }

  // ---------- Behaviors (methods) ----------
  /// Lets [count] passengers board, if seats are available.
  void board(int count) {
    if (count <= 0) {
      print('  [!] Number of boarding passengers must be positive.');
      return;
    }
    if (count > availableSeats) {
      print('  [!] $plateNumber: only $availableSeats seat(s) left, '
          'cannot board $count passenger(s).');
      return;
    }
    _passengers += count;
    collectFare(count);
    print('  $count passenger(s) boarded $plateNumber. '
        'Now: $_passengers/$capacity.');
  }

  /// Lets [count] passengers get off ("Para po!").
  void alight(int count) {
    if (count <= 0 || count > _passengers) {
      print('  [!] $plateNumber: invalid number of passengers to alight ($count).');
      return;
    }
    _passengers -= count;
    print('  "Para po!" $count passenger(s) got off $plateNumber. '
        'Now: $_passengers/$capacity.');
  }

  /// Collects the fare from [count] passengers and records it.
  void collectFare(int count) {
    final amount = _fare * count;
    _earnings += amount;
    _fareLog.add(amount);
  }

  /// Prints a summary of this jeepney.
  void displayInfo() {
    print('  Plate No.  : $plateNumber');
    print('  Route      : $route');
    print('  Driver     : $driverName');
    print('  Passengers : $_passengers/$capacity${isFull ? ' (FULL)' : ''}');
    print('  Fare       : PHP ${_fare.toStringAsFixed(2)}');
    print('  Earnings   : PHP ${_earnings.toStringAsFixed(2)}');
  }

  /// Converts the jeepney into a Map (useful for reports / storage).
  Map<String, dynamic> toMap() => {
        'plateNumber': plateNumber,
        'route': route,
        'driver': driverName,
        'passengers': _passengers,
        'capacity': capacity,
        'earnings': _earnings,
      };
}

void printHeader(String title) {
  print('');
  print('=' * 50);
  print(' $title');
  print('=' * 50);
}

void main() {
  printHeader('JEEPNEY FLEET MANAGER - Week 9 OOP Program');

  // ---------- Create objects using the constructor ----------
  final jeep1 = Jeepney('NXA-1234', 'Quiapo - Cubao', 'Mang Juan');
  final jeep2 = Jeepney('TJP-5678', 'Divisoria - Monumento', 'Mang Pedro',
      capacity: 16, fare: 15.0);
  final jeep3 =
      Jeepney('PUJ-9012', 'Baclaran - Lawton', 'Aling Rosa', capacity: 18);

  // ---------- List: store a collection of Jeepney objects ----------
  final List<Jeepney> fleet = [jeep1, jeep2, jeep3];

  // ---------- Map: organize jeepneys by plate number ----------
  final Map<String, Jeepney> fleetByPlate = {
    for (final j in fleet) j.plateNumber: j,
  };

  // ---------- Test methods ----------
  printHeader('TRIP SIMULATION');
  print('\n> ${jeep1.plateNumber} (${jeep1.route})');
  jeep1.board(5);
  jeep1.board(10);
  jeep1.alight(4);
  jeep1.board(10); // too many -> rejected

  print('\n> ${jeep2.plateNumber} (${jeep2.route})');
  jeep2.board(16);
  jeep2.board(1); // full -> rejected
  jeep2.alight(6);

  print('\n> ${jeep3.plateNumber} (${jeep3.route})');
  jeep3.board(7);
  jeep3.alight(10); // more than on board -> rejected

  // ---------- Encapsulation: update private field via setter ----------
  printHeader('FARE UPDATE (Encapsulation)');
  jeep3.fare = 14.0; // valid
  jeep3.fare = -5.0; // invalid -> rejected
  jeep3.board(3);
  // Note: _earnings, _passengers and _fare are private, so code outside
  // this library cannot change them directly — only through methods.

  // ---------- Display every jeepney in the List ----------
  printHeader('FLEET STATUS');
  for (var i = 0; i < fleet.length; i++) {
    print('\nJeepney #${i + 1}');
    fleet[i].displayInfo();
  }

  // ---------- Look up a jeepney using the Map ----------
  printHeader('LOOKUP BY PLATE NUMBER (Map)');
  for (final plate in ['TJP-5678', 'ABC-0000']) {
    final found = fleetByPlate[plate];
    if (found != null) {
      print('  Found $plate -> driven by ${found.driverName} on ${found.route}');
    } else {
      print('  No jeepney found with plate $plate.');
    }
  }

  // ---------- Summary using List operations ----------
  printHeader('DAILY SUMMARY');
  final totalEarnings = fleet.fold<double>(0, (sum, j) => sum + j.earnings);
  final totalPassengers = fleet.fold<int>(0, (sum, j) => sum + j.passengers);
  final topEarner = fleet.reduce((a, b) => a.earnings >= b.earnings ? a : b);

  print('  Jeepneys in fleet    : ${fleet.length}');
  print('  Passengers on board  : $totalPassengers');
  print('  Total fleet earnings : PHP ${totalEarnings.toStringAsFixed(2)}');
  print('  Top earner           : ${topEarner.plateNumber} '
      '(${topEarner.driverName}) - PHP ${topEarner.earnings.toStringAsFixed(2)}');
  print('  ${jeep1.plateNumber} fare log : ${jeep1.fareLog}');

  print('\n  Fleet as a List of Maps:');
  for (final data in fleet.map((j) => j.toMap())) {
    print('  $data');
  }
  print('');
}
