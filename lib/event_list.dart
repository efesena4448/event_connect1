import 'package:flutter/material.dart';
import 'package:event_connect/event.dart';
import 'package:event_connect/database.dart';
import 'event_detail.dart';

class EventList extends StatefulWidget {
  final AppDatabase database;

  const EventList({Key? key, required this.database}) : super(key: key);

  @override
  _EventListState createState() => _EventListState();
}

class _EventListState extends State<EventList> {
  List<Event> _events = [];
  List<Event> _filteredEvents = [];
  final TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _fetchEvents();
    _searchController.addListener(_filterEvents);
  }

  void _filterEvents() {
    final query = _searchController.text.toLowerCase();
    setState(() {
      _filteredEvents = _events.where((event) {
        return event.name.toLowerCase().contains(query) ||
            event.description.toLowerCase().contains(query);
      }).toList();
    });
  }

  Future<void> _fetchEvents() async {
    final events = await widget.database.eventDao.findAllEvents();
    setState(() {
      _events = events;
      _filteredEvents = events;
    });
  }

  void _addEvent() async {
    await Navigator.pushNamed(context, '/add');
    _fetchEvents(); // Refresh the list after adding a new event
  }

  void _showEventDetails(Event event) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => EventDetail(event: event),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Event List'),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: _searchController,
              decoration: const InputDecoration(
                labelText: 'Search Events',
                border: OutlineInputBorder(),
              ),
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: _filteredEvents.length,
              itemBuilder: (context, index) {
                final event = _filteredEvents[index];
                return ListTile(
                  title: Text(event.name),
                  subtitle: Text(event.description),
                  trailing: Text(event.date),
                  onTap: () => _showEventDetails(event),
                );
              },
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _addEvent,
        child: const Icon(Icons.add),
      ),
    );
  }
}
