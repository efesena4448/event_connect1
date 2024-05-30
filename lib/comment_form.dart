import 'package:flutter/material.dart';
import 'package:event_connect/database.dart';
import 'package:event_connect/comment.dart';

class CommentForm extends StatefulWidget {
  final AppDatabase database;
  final int eventId;

  const CommentForm({Key? key, required this.database, required this.eventId}) : super(key: key);

  @override
  _CommentFormState createState() => _CommentFormState();
}

class _CommentFormState extends State<CommentForm> {
  final _formKey = GlobalKey<FormState>();
  String _text = '';
  double _rating = 1;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Comment'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: <Widget>[
              TextFormField(
                decoration: const InputDecoration(labelText: 'Comment'),
                onSaved: (value) {
                  _text = value ?? '';
                },
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your comment';
                  }
                  return null;
                },
              ),
              DropdownButtonFormField<double>(
                value: _rating,
                decoration: const InputDecoration(labelText: 'Rating'),
                items: [1, 2, 3, 4, 5].map((rating) {
                  return DropdownMenuItem<double>(
                    value: rating.toDouble(),
                    child: Text(rating.toString()),
                  );
                }).toList(),
                onChanged: (value) {
                  setState(() {
                    _rating = value ?? 1;
                  });
                },
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () async {
                  if (_formKey.currentState?.validate() ?? false) {
                    _formKey.currentState?.save();
                    final newComment = Comment(
                      DateTime.now().millisecondsSinceEpoch,
                      widget.eventId,
                      _text,
                      _rating,
                      DateTime.now().toIso8601String(),
                    );
                    await widget.database.commentDao.insertComment(newComment);
                    if (mounted) {
                      Navigator.pop(context);
                    }
                  }
                },
                child: const Text('Submit'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
