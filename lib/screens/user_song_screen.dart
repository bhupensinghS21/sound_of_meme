import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart'; // Import Google Fonts
import '../service/api_sercive.dart';
import 'dart:convert';

class UserSongsScreen extends StatefulWidget {
  @override
  _UserSongsScreenState createState() => _UserSongsScreenState();
}

class _UserSongsScreenState extends State<UserSongsScreen> {
  final ApiService apiService = ApiService();
  List<dynamic> _songs = [];
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _fetchUserSongs();
  }

  Future<void> _fetchUserSongs() async {
    setState(() {
      _isLoading = true;
    });

    final response = await apiService.fetchUserSongs();

    setState(() {
      _isLoading = false;
    });

    if (response?.statusCode == 200) {
      setState(() {
        _songs = json.decode(response!.body);
      });
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to fetch songs.', style: GoogleFonts.aBeeZee())),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blueGrey[800], // Blue-gray background
      appBar: AppBar(
        title: Text('Your Songs', style: GoogleFonts.aBeeZee()),
        elevation: 500,
        backgroundColor: Colors.transparent,
      ),
      body: _isLoading
          ? Center(child: CircularProgressIndicator())
          : ListView.builder(
        itemCount: _songs.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(_songs[index]['title'], style: GoogleFonts.aBeeZee()),
            subtitle: Text(_songs[index]['artist'], style: GoogleFonts.aBeeZee()),
          );
        },
      ),
    );
  }
}
