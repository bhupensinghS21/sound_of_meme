import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sound/screens/user_song_screen.dart';
import 'song_creation_screen.dart';
import 'create_custom_song_screen.dart';
import 'login_screen.dart';
import 'signup_screen.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blueGrey[800],
      appBar: AppBar(
        title: Text(
          'Meme duniya',
          style: GoogleFonts.aBeeZee(
            fontSize: 22.0,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: Colors.transparent,
        elevation: 200, // Removes the shadow
        iconTheme: IconThemeData(color: Colors.white), // Sets the icon color
        actions: [
          Row(
            children: [
              TextButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => SignupScreen()),
                  );
                },
                child: Text(
                  'Sign Up',
                  style: GoogleFonts.poppins(
                    color: Colors.white,
                  ),
                ),
              ),
              SizedBox(width: 10), // Add some space between the buttons
              ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => LoginScreen()),
                  );
                },
                child: Text(
                  'Login',
                  style: GoogleFonts.poppins(
                    color: Colors.white,
                  ),
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.black, // Button background color
                ),
              ),
            ],
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: double.infinity,
                height: 300, // Adjust height as needed
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage('assets/logo.png'), // Replace with your image path
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              SizedBox(height: 20.0), // Space between image and description fields
              _buildDescriptionField(
                'Create a new song by filling in the details below. This feature allows you to compose and save new music.',
                'Create Song',
                    () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => SongCreationScreen()),
                  );
                },
              ),
              SizedBox(height: 20.0),
              _buildDescriptionField(
                'View all the songs you have created. This screen displays a list of your songs for easy access and management.',
                'View User Songs',
                    () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => UserSongsScreen()),
                  );
                },
              ),
              SizedBox(height: 20.0),
              _buildDescriptionField(
                'Create a custom song using your own data. This feature allows for more personalized song creation.',
                'Create Custom Song',
                    () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => CreateCustomSongScreen()),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildDescriptionField(String description, String buttonText, VoidCallback onPressed) {
    return Container(
      padding: const EdgeInsets.all(8.0),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.white),
        borderRadius: BorderRadius.circular(8.0),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            description,
            style: GoogleFonts.aBeeZee(
              color: Colors.white,
              fontSize: 16.0,
            ),
          ),
          SizedBox(height: 10.0),
          ElevatedButton(
            onPressed: onPressed,
            child: Text(
              buttonText,
              style: GoogleFonts.aBeeZee(
                color: Colors.white,
              ),
            ),
            style: ElevatedButton.styleFrom(
              foregroundColor: Colors.white,
              backgroundColor: Colors.black, // Button background color
            ),
          ),
        ],
      ),
    );
  }
}
