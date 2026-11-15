# PC16 Week 9 – Your Turn: OOP Program (Jeepney)

**PC16 – Mobile Development with Lab** · National Teachers College
Week 9: Object-Oriented Programming in Dart (Part 1) – Individual Task

A console-based Dart program that models a **Jeepney** as a class.

## Rubric checklist

| Criterion | Where in `bin/main.dart` |
|---|---|
| **Class Definition** | `class Jeepney` – fields (`plateNumber`, `route`, `driverName`, `capacity`) and methods (`board()`, `alight()`, `collectFare()`, `displayInfo()`, `toMap()`) |
| **Constructor** | `Jeepney(this.plateNumber, this.route, this.driverName, {this.capacity = 20, double fare = 13.0})` |
| **Encapsulation** | Private fields `_passengers`, `_earnings`, `_fare`, `_fareLog`; read through getters, `fare` updated through a validating setter |
| **List/Map Usage** | `List<Jeepney> fleet`, `Map<String, Jeepney> fleetByPlate`, `List<double> _fareLog`, and `toMap()` |

In `main()`, three `Jeepney` objects are created, their methods are called (boarding, alighting, fare update, including invalid cases), and the results are printed.

## Run

```bash
dart run bin/main.dart
```

Or paste `bin/main.dart` into [DartPad](https://dartpad.dev).
