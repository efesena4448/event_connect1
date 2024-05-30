import 'package:floor/floor.dart';
import 'package:event_connect/event.dart';

@dao
abstract class EventDao {
  @Query('SELECT * FROM Event')
  Future<List<Event>> findAllEvents();

  @insert
  Future<void> insertEvent(Event event);
}
