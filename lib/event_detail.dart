import 'package:flutter/material.dart';
import 'package:event_connect/event.dart';
import 'package:event_connect/database.dart';
import 'package:event_connect/favorite.dart';

class EventDetail extends StatefulWidget {
  final Event event;
  final AppDatabase database;

  const EventDetail({Key? key, required this.event, required this.database}) : super(key: key);

  @override
  _EventDetailState createState() => _EventDetailState();
}

class _EventDetailState extends State<EventDetail> {
  bool isFavorite = false;

  @override
  void initState() {
    super.initState();
    _checkIfFavorite();
  }

  void _checkIfFavorite() async {
    final favorites = await widget.database.favoriteDao.findFavoriteByEventId(widget.event.id);
    setState(() {
      isFavorite = favorites.isNotEmpty;
    });
  }

  void _toggleFavorite() async {
    if (isFavorite) {
      // Remove favorite
      final favorites = await widget.database.favoriteDao.findFavoriteByEventId(widget.event.id);
      if (favorites.isNotEmpty) {
        await widget.database.favoriteDao.deleteFavorite(favorites.first);
      }
    } else {
      // Add to favorite
      final favorite = Favorite(widget.event.id, widget.event.id);
      await widget.database.favoriteDao.insertFavorite(favorite);
    }
    setState(() {
      isFavorite = !isFavorite;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Event Details'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(widget.event.name, style: const TextStyle(fontSize: 24)),
            const SizedBox(height: 8),
            Text(widget.event.description),
            const SizedBox(height: 8),
            Text(widget.event.date),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: _toggleFavorite,
              child: Text(isFavorite ? 'Remove from Favorites' : 'Add to Favorites'),
            ),
          ],
        ),
      ),
    );
  }
}
