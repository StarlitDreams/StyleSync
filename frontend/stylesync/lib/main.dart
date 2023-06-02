import 'package:flutter/material.dart';
import 'package:animated_text_kit/animated_text_kit.dart';

void main() {
  runApp(StyleSyncApp());
}

class StyleSyncApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'StyleSync',
      theme: ThemeData(
        primarySwatch: Colors.purple,
      ),
      home: WelcomeScreen(),
    );
  }
}

class WelcomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Color.fromRGBO(253, 175, 19, 1),
              Color.fromARGB(255, 78, 232, 240),
            ],
          ),
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Hero(
                tag: 'logo',
                child: Image.asset('images/logo.jpg', height: 150),
              ),
              SizedBox(height: 16),
              DefaultTextStyle(
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'CustomFont',
                  color: Colors.white,
                ),
                child: AnimatedTextKit(
                  animatedTexts: [
                    TypewriterAnimatedText('Welcome to StyleSync'),
                  ],
                  totalRepeatCount: 1,
                ),
              ),
              SizedBox(height: 32),
              AnimatedOpacity(
                opacity: 1,
                duration: Duration(seconds: 2),
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => PersonalInfoScreen(),
                      ),
                    );
                  },
                  style: ButtonStyle(
                    padding: MaterialStateProperty.all<EdgeInsets>(
                      EdgeInsets.all(15),
                    ),
                    backgroundColor: MaterialStateProperty.all<Color>(
                      Colors.blueAccent,
                    ),
                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30.0),
                      ),
                    ),
                  ),
                  child: Text(
                    'Get Started',
                    style: TextStyle(
                      fontFamily: 'Pixelated',
                      fontSize: 20,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class PersonalInfoScreen extends StatefulWidget {
  @override
  _PersonalInfoScreenState createState() => _PersonalInfoScreenState();
}

class _PersonalInfoScreenState extends State<PersonalInfoScreen> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController ageController = TextEditingController();
  final TextEditingController pronounsController = TextEditingController();
  bool isNameValid = true;
  bool isAgeValid = true;
  bool isPronounsValid = true;

  void validateFields() {
    setState(() {
      isNameValid = nameController.text.isNotEmpty;
      isAgeValid = ageController.text.isNotEmpty;
      isPronounsValid = pronounsController.text.isNotEmpty;

      if (isNameValid && isAgeValid && isPronounsValid) {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => FeelLikeScreen(
              name: nameController.text,
            ),
          ),
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Personal Information'),
        automaticallyImplyLeading: false, // Disables back button
      ),
      body: Center(
        child: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                Color.fromRGBO(253, 175, 19, 1),
                Color.fromARGB(255, 78, 232, 240),
              ],
            ),
          ),
          padding: EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              buildAnimatedTextField(nameController, 'Name', isNameValid),
              SizedBox(height: 16),
              buildAnimatedTextField(ageController, 'Age', isAgeValid),
              SizedBox(height: 16),
              buildAnimatedTextField(pronounsController, 'Pronouns', isPronounsValid),
              SizedBox(height: 16),
              ElevatedButton(
                onPressed: validateFields,
                child: Text('Next'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildAnimatedTextField(
    TextEditingController controller,
    String labelText,
    bool isValid,
  ) {
    return AnimatedContainer(
      duration: Duration(milliseconds: 500),
      curve: Curves.easeInOut,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: isValid ? Colors.transparent : Colors.red),
      ),
      child: TextField(
        controller: controller,
        style: TextStyle(color: Colors.black),
        decoration: InputDecoration(
          labelText: labelText,
          labelStyle: TextStyle(color: Colors.black54),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
          ),
          contentPadding: EdgeInsets.symmetric(horizontal: 16),
          errorText: isValid ? null : 'Please enter $labelText',
        ),
      ),
    );
  }
}

class FeelLikeScreen extends StatefulWidget {
  final String name;

  FeelLikeScreen({required this.name});

  @override
  _FeelLikeScreenState createState() => _FeelLikeScreenState();
}

class _FeelLikeScreenState extends State<FeelLikeScreen> {
  final TextEditingController feelingController = TextEditingController();
  bool isFeelingValid = true;

  void validateFields() {
    setState(() {
      isFeelingValid = feelingController.text.isNotEmpty;

      if (isFeelingValid) {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => TakeSeatScreen(
              feeling: feelingController.text,
              name: widget.name,
            ),
          ),
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('What do you feel like?'),
        automaticallyImplyLeading: true, // Disables back button
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Color.fromRGBO(253, 175, 19, 1),
              Color.fromARGB(255, 78, 232, 240),
            ],
          ),
        ),
        child: Padding(
          padding: EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              buildAnimatedTextField(
                feelingController,
                'Enter your feeling',
                isFeelingValid,
              ),
              SizedBox(height: 16),
              ElevatedButton(
                onPressed: validateFields,
                child: Text('Next'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildAnimatedTextField(
    TextEditingController controller,
    String labelText,
    bool isValid,
  ) {
    return AnimatedContainer(
      duration: Duration(milliseconds: 500),
      curve: Curves.easeInOut,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: isValid ? Colors.transparent : Colors.red),
      ),
      child: TextField(
        controller: controller,
        style: TextStyle(color: Colors.black),
        decoration: InputDecoration(
          labelText: labelText,
          labelStyle: TextStyle(color: Colors.black54),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
          ),
          contentPadding: EdgeInsets.symmetric(horizontal: 16),
          errorText: isValid ? null : 'Please enter $labelText',
        ),
      ),
    );
  }
}

class TakeSeatScreen extends StatelessWidget {
  final String feeling;
  final String name;

  TakeSeatScreen({required this.feeling, required this.name});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Take a Seat'),
      ),
      body: Container(
        color: Colors.purple,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Take a seat and relax, $name, we will do everything for you.',
              style: TextStyle(fontSize: 24, color: Colors.white),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => AddClothesScreen(),
                      ),
                    );
                  },
                  child: Column(
                    children: [
                      Icon(Icons.add),
                      SizedBox(height: 8),
                      Text('Add Clothes'),
                    ],
                  ),
                ),
                ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => GenerateFitScreen(),
                      ),
                    );
                  },
                  child: Column(
                    children: [
                      Icon(Icons.auto_awesome),
                      SizedBox(height: 8),
                      Text('Generate Fit'),
                    ],
                  ),
                ),
                ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => SettingsScreen(),
                      ),
                    );
                  },
                  child: Column(
                    children: [
                      Icon(Icons.settings),
                      SizedBox(height: 8),
                      Text('Settings'),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class AddClothesScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add Clothes'),
      ),
      body: Container(
        child: Center(
          child: Text('Add Clothes'),
        ),
      ),
    );
  }
}

class GenerateFitScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Generate Fit'),
      ),
      body: Container(
        child: Center(
          child: Text('Generate Fit'),
        ),
      ),
    );
  }
}

class SettingsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Settings'),
      ),
      body: Container(
        child: Center(
          child: Text('Settings'),
        ),
      ),
    );
  }
}
