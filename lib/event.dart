import 'package:floor/floor.dart';

@entity
class Event {
  @primaryKey
  final int id;
  final String name;
  final String description;
  final String date;

  Event(this.id, this.name, this.description, this.date);
}
