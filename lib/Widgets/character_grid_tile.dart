import 'package:flutter/material.dart';
import '../Models/characters.dart';
import '../Screens/detail_page.dart';

class CharacterGridTile extends StatelessWidget {
  final Character character;

  CharacterGridTile({required this.character});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => CharacterDetailScreen(resource: character),
          ),
        );
      },
      child: Card(
        color: Colors.grey[100],
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Expanded(
              child: Image.network(
                'https://img.freepik.com/free-vector/illustration-gallery-icon_53876-27002.jpg?w=740&t=st=1720703297~exp=1720703897~hmac=01c149cd2b3088a89b53e9576de9132873b63a9e942f314938a8cec457a1b907', // Placeholder image URL
                fit: BoxFit.cover,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                character.name,
                style: TextStyle(fontWeight: FontWeight.bold),
                textAlign: TextAlign.center,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
