import 'package:flutter/material.dart';

class InterestPage extends StatefulWidget {
  const InterestPage({super.key});

  @override
  _InterestPageState createState() => _InterestPageState();
}

class _InterestPageState extends State<InterestPage> {
  final List<String> _categories = ['Politics', 'Sports', 'Technology', 'Entertainment', 'Health', 'Business'];
  final List<bool> _selectedCategories = List.generate(6, (_) => false);

  void _navigateToHomePage() {
    // Check if at least two categories are selected
    List<String> selectedInterests = [];
    for (int i = 0; i < _selectedCategories.length; i++) {
      if (_selectedCategories[i]) {
        selectedInterests.add(_categories[i]);
      }
    }

    if (selectedInterests.length >= 2) {
      Navigator.pushNamed(context, '/home', arguments: selectedInterests);
    } else {
      // Show a custom dialog to prompt the user to select at least two categories
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Error'),
            content: Text('Please select at least two categories.'),
            actions: <Widget>[
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text('OK'),
              ),
            ],
          );
        },
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height:30),
            const Text(
              "Choose your topic",
              style: TextStyle(fontSize: 40.0, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16.0),
            Expanded(
              child: ListView.builder(
                itemCount: _categories.length,
                itemBuilder: (context, index) {
                  return CheckboxListTile(
                    title: Text(_categories[index]),
                    value: _selectedCategories[index],
                    onChanged: (value) {
                      setState(() {
                        _selectedCategories[index] = value!;
                      });
                    },
                  );
                },
              ),
            ),
            const SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: _navigateToHomePage,
              child: const Text('Continue',
                style: TextStyle(fontSize:40),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
