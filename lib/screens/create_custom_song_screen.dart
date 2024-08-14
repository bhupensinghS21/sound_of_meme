import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart'; // Import Google Fonts
import '../service/api_sercive.dart';

class CreateCustomSongScreen extends StatefulWidget {
  @override
  _CreateCustomSongScreenState createState() => _CreateCustomSongScreenState();
}

class _CreateCustomSongScreenState extends State<CreateCustomSongScreen> {
  final ApiService apiService = ApiService();
  final TextEditingController _customDataController = TextEditingController();
  bool _isLoading = false;

  Future<void> _createCustomSong() async {
    setState(() {
      _isLoading = true;
    });

    final success = await apiService.createCustomSong(_customDataController.text);

    setState(() {
      _isLoading = false;
    });

    if (success) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Custom song created successfully!', style: GoogleFonts.aBeeZee())),
      );
      _customDataController.clear();
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to create custom song.', style: GoogleFonts.aBeeZee())),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blueGrey[800], // Blue-gray background
      appBar: AppBar(
        title: Text('Create Custom Song', style: GoogleFonts.aBeeZee()),
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
                  controller: _customDataController,
                  decoration: InputDecoration(
                    labelText: 'Custom Data',
                    labelStyle: GoogleFonts.aBeeZee(),
                  ),
                  maxLines: 5,
                ),
                SizedBox(height: 20.0),
                _isLoading
                    ? CircularProgressIndicator()
                    : ElevatedButton(
                  onPressed: _createCustomSong,
                  child: Text('Create Custom Song', style: GoogleFonts.aBeeZee()),
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
