import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(
    home: CharacterSelectionPage(),
  ));
}

class CharacterSelectionPage extends StatefulWidget {
  @override
  _CharacterSelectionPageState createState() => _CharacterSelectionPageState();
}

class _CharacterSelectionPageState extends State<CharacterSelectionPage> {
  String selectedCharacter = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(253, 255, 215, 217),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(height: 30),
          Text(
            'Choose Your Character',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
            textAlign: TextAlign.center,
          ),
          SizedBox(height: 20),
          CharacterRow([
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
              child: CharacterCard(
                image: 'assets/images/tom.png',
                name: 'Tom',
                isSelected: selectedCharacter == 'Tom',
                onSelect: () {
                  setState(() {
                    selectedCharacter = 'Tom';
                  });
                },
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
              child: CharacterCard(
                image: 'assets/images/ghost.png',
                name: 'Ghost',
                isSelected: selectedCharacter == 'ghost',
                onSelect: () {
                  setState(() {
                    selectedCharacter = 'ghost';
                  });
                },
              ),
            ),
          ]),
          CharacterRow([
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
              child: CharacterCard(
                image: 'assets/images/kevin.png',
                name: 'Kevin',
                isSelected: selectedCharacter == 'Kevin',
                onSelect: () {
                  setState(() {
                    selectedCharacter = 'Kevin';
                  });
                },
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
              child: CharacterCard(
                image: 'assets/images/sara.png',
                name: 'Sara',
                isSelected: selectedCharacter == 'Sara',
                onSelect: () {
                  setState(() {
                    selectedCharacter = 'Sara';
                  });
                },
              ),
            ),
          ]),
          CharacterRow([
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
              child: CharacterCard(
                image: 'assets/images/barbie.png',
                name: 'Barbie',
                isSelected: selectedCharacter == 'Barbie',
                onSelect: () {
                  setState(() {
                    selectedCharacter = 'Barbie';
                  });
                },
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
              child: CharacterCard(
                image: 'assets/images/queen.png',
                name: 'Queen',
                isSelected: selectedCharacter == 'Queen',
                onSelect: () {
                  setState(() {
                    selectedCharacter = 'Queen';
                  });
                },
              ),
            ),
          ]),
          SizedBox(height: 20),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context); // Navigate back to the previous screen
            },
            child: Text('Back'),
          ),
        ],
      ),
    );
  }
}

class CharacterRow extends StatelessWidget {
  final List<Widget> children;

  CharacterRow(this.children);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: children,
    );
  }
}

class CharacterCard extends StatelessWidget {
  final String image;
  final String name;
  final bool isSelected;
  final VoidCallback onSelect;

  const CharacterCard({
    required this.image,
    required this.name,
    required this.isSelected,
    required this.onSelect,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onSelect,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: isSelected ? Colors.green : Color.fromARGB(255, 137, 201, 26),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 5,
              spreadRadius: 2,
            ),
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircleAvatar(
              radius: 70,
              backgroundImage: AssetImage(image),
            ),
            SizedBox(height: 10),
            Text(
              name,
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                fontFamily: 'Indie Flower',
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
