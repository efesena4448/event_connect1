import 'package:floor/floor.dart';
import 'event.dart';

@dao
abstract class EventDao {
  @Query('SELECT * FROM Event')
  Future<List<Event>> findAllEvents();

  @Query('SELECT * FROM Event WHERE id IN (:ids)')
  Future<List<Event>> findEventsByIds(List<int> ids);  // Bu satırı ekleyin

  @insert
  Future<void> insertEvent(Event event);
}
