import 'package:flutter/material.dart';
import 'package:event_connect/event.dart';
import 'package:event_connect/database.dart';
import 'package:event_connect/favorite.dart';
import 'package:event_connect/comment_form.dart';

class EventDetail extends StatefulWidget {
  final Event event;
  final AppDatabase database;

  const EventDetail({Key? key, required this.event, required this.database}) : super(key: key);

  @override
  _EventDetailState createState() => _EventDetailState();
}

class _EventDetailState extends State<EventDetail> {
  bool isFavorite = false;
  List<Comment> _comments = [];

  @override
  void initState() {
    super.initState();
    _checkIfFavorite();
    _fetchComments();
  }

  void _checkIfFavorite() async {
    final favorites = await widget.database.favoriteDao.findFavoriteByEventId(widget.event.id);
    setState(() {
      isFavorite = favorites.isNotEmpty;
    });
  }

  void _fetchComments() async {
    final comments = await widget.database.commentDao.findCommentsByEventId(widget.event.id);
    setState(() {
      _comments = comments;
    });
  }

  void _toggleFavorite() async {
    if (isFavorite) {
      final favorites = await widget.database.favoriteDao.findFavoriteByEventId(widget.event.id);
      if (favorites.isNotEmpty) {
        await widget.database.favoriteDao.deleteFavorite(favorites.first);
      }
    } else {
      final favorite = Favorite(widget.event.id, widget.event.id);
      await widget.database.favoriteDao.insertFavorite(favorite);
    }
    setState(() {
      isFavorite = !isFavorite;
    });
  }

  void _addComment() async {
    await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => CommentForm(database: widget.database, eventId: widget.event.id),
      ),
    );
    _fetchComments(); // Refresh comments after adding a new comment
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
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: _addComment,
              child: const Text('Add Comment'),
            ),
            const SizedBox(height: 20),
            const Text('Comments:', style: TextStyle(fontSize: 18)),
            Expanded(
              child: ListView.builder(
                itemCount: _comments.length,
                itemBuilder: (context, index) {
                  final comment = _comments[index];
                  return ListTile(
                    title: Text(comment.text),
                    subtitle: Text('Rating: ${comment.rating}, Date: ${comment.date}'),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
