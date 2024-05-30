import 'package:floor/floor.dart';
import 'package:event_connect/favorite.dart';

@dao
abstract class FavoriteDao {
  @Query('SELECT * FROM Favorite WHERE eventId = :eventId')
  Future<List<Favorite>> findFavoriteByEventId(int eventId);

  @insert
  Future<void> insertFavorite(Favorite favorite);

  @delete
  Future<void> deleteFavorite(Favorite favorite); // Bu satırı ekleyin
}