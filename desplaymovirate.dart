import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

class RateMovieEntry extends StatelessWidget {
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  double _rating = 0;

  Future<void> _addMovie() async {
    if (_titleController.text.isEmpty || _descriptionController.text.isEmpty || _rating == 0) {
      return;
    }
    await FirebaseFirestore.instance.collection('movies').add({
      'title': _titleController.text,
      'description': _descriptionController.text,
      'rating': _rating,
    });
    _titleController.clear();
    _descriptionController.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Add Movie')),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            TextField(
              controller: _titleController,
              decoration: InputDecoration(labelText: 'Title'),
            ),
            TextField(
              controller: _descriptionController,
              decoration: InputDecoration(labelText: 'Description'),
            ),
            SizedBox(height: 20),
            Text('Rate the movie:'),
            RatingBar.builder(
              initialRating: 0,
              minRating: 1,
              direction: Axis.horizontal,
              allowHalfRating: true,
              itemCount: 5,
              itemPadding: EdgeInsets.symmetric(horizontal: 4.0),
              itemBuilder: (context, _) => Icon(
                Icons.star,
                color: Colors.amber,
              ),
              onRatingUpdate: (rating) {
                _rating = rating;
              },
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _addMovie,
              child: Text('Add Movie'),
            ),
          ],
        ),
      ),
    );
  }
}
