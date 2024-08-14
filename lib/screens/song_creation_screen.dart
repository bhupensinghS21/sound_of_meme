import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart'; // Import Google Fonts
import '../service/api_sercive.dart';

class SongCreationScreen extends StatefulWidget {
  @override
  _SongCreationScreenState createState() => _SongCreationScreenState();
}

class _SongCreationScreenState extends State<SongCreationScreen> {
  final ApiService apiService = ApiService();
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _artistController = TextEditingController();
  final TextEditingController _lyricsController = TextEditingController();
  bool _isLoading = false;

  Future<void> _createSong() async {
    setState(() {
      _isLoading = true;
    });

    final success = await apiService.createSong(
      _titleController.text,
      _artistController.text,
      _lyricsController.text,
    );

    setState(() {
      _isLoading = false;
    });

    if (success) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Song created successfully!')),
      );
      _titleController.clear();
      _artistController.clear();
      _lyricsController.clear();
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to create the song.')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blueGrey[800], // Blue-gray background
      appBar: AppBar(
        title: Text('Create Song', style: GoogleFonts.aBeeZee()),
        elevation: 500,
        backgroundColor: Colors.transparent,
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Container(
            padding: const EdgeInsets.all(16.0),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(8.0),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextField(
                  controller: _titleController,
                  decoration: InputDecoration(
                    labelText: 'Title',
                    labelStyle: GoogleFonts.aBeeZee(),
                  ),
                ),
                SizedBox(height: 10.0),
                TextField(
                  controller: _artistController,
                  decoration: InputDecoration(
                    labelText: 'Artist',
                    labelStyle: GoogleFonts.aBeeZee(),
                  ),
                ),
                SizedBox(height: 10.0),
                TextField(
                  controller: _lyricsController,
                  decoration: InputDecoration(
                    labelText: 'Lyrics',
                    labelStyle: GoogleFonts.aBeeZee(),
                  ),
                ),
                SizedBox(height: 20.0),
                _isLoading
                    ? CircularProgressIndicator()
                    : ElevatedButton(
                  onPressed: _createSong,
                  child: Text('Create Song', style: GoogleFonts.aBeeZee()),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blueGrey[800],
                    foregroundColor: Colors.white,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
