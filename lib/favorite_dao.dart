import 'package:floor/floor.dart';
import 'favorite.dart';

@dao
abstract class FavoriteDao {
  @Query('SELECT * FROM Favorite WHERE eventId = :eventId')
  Future<List<Favorite>> findFavoriteByEventId(int eventId);

  @Query('SELECT * FROM Favorite')
  Future<List<Favorite>> findAllFavorites();  // Bu satırı ekleyin

  @insert
  Future<void> insertFavorite(Favorite favorite);

  @delete
  Future<void> deleteFavorite(Favorite favorite);
}
