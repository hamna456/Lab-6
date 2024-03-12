import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue, // Change the primary color
        // Add more theme customizations as needed
      ),
      home: SavedSuggestions(
        suggestions: ['Black', 'Pink', 'Red', 'Purple'], // Example suggestions list
      ),
    );
  }
}

class SavedSuggestions extends StatefulWidget {
  final List<String> suggestions; // List of suggestions

  const SavedSuggestions({Key? key, required this.suggestions}) : super(key: key);

  @override
  State<SavedSuggestions> createState() => _SavedSuggestionsState();
}

class _SavedSuggestionsState extends State<SavedSuggestions> {
  late List<bool> _isSelected; // Tracks whether each item is selected or not
  late List<String> _selectedToDelete; // Keeps track of selected items to delete

  @override
  void initState() {
    super.initState();
    _isSelected = List.generate(widget.suggestions.length, (_) => false); // Initialize all items as unselected
    _selectedToDelete = []; // Initialize selected items to delete as empty
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Hamna Naveed ,346470,Lab 6'), // AppBar title
        actions: [
          IconButton(
            icon: const Icon(Icons.delete), // Delete icon button
            onPressed: () {
              // Check if any item is selected for deletion
              if (_isSelected.any((isSelected) => isSelected)) {
                showDialog(
                  context: context,
                  builder: (context) => AlertDialog(
                    title: const Text('Delete Suggestions'), // Dialog title
                    content: const Text('Are you sure you want to delete the selected suggestions?'), // Dialog content
                    actions: [
                      TextButton(
                        onPressed: () {
                          // Add selected items to delete list
                          for (var i = 0; i < _isSelected.length; i++) {
                            if (_isSelected[i]) {
                              _selectedToDelete.add(widget.suggestions[i]);
                            }
                          }
                          // Remove selected items from suggestions list and update isSelected state
                          setState(() {
                            widget.suggestions.removeWhere((suggestion) => _selectedToDelete.contains(suggestion));
                            _isSelected = List.generate(widget.suggestions.length, (_) => false);
                          });
                          Navigator.pop(context); // Close the dialog
                        },
                        child: const Text('Yes'), // Yes button
                      ),
                      TextButton(
                        onPressed: () => Navigator.pop(context), // No button
                        child: const Text('No'),
                      ),
                    ],
                  ),
                );
              } else {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('No Item Selected'), // Snackbar message if no item is selected
                  ),
                );
              }
            },
          ),
        ],
      ),
      body: ListView.builder(
        itemCount: widget.suggestions.length, // Total number of suggestions
        itemBuilder: (context, index) {
          final suggestion = widget.suggestions[index]; // Current suggestion
          return ListTile(
            title: Text(
              suggestion, // Display suggestion instead of "Color $index"
            ),
            trailing: Checkbox(
              value: _isSelected[index], // Whether this item is selected or not
              onChanged: (newValue) {
                setState(() {
                  _isSelected[index] = newValue!; // Update the selection status
                });
              },
            ),
          );
        },
      ),
    );
  }
}

