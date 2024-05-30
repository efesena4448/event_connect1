import 'package:floor/floor.dart';

@entity
class Favorite {
  @primaryKey
  final int id;
  final int eventId;

  Favorite(this.id, this.eventId);
}
