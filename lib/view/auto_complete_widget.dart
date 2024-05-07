import 'package:flutter/material.dart';


class AutocompleteWidget extends StatefulWidget {
  final List<String> options;
  final Function(String) onChange;
  final String selectedCurrency;

  const AutocompleteWidget({Key? key, required this.options, required this.onChange, required this.selectedCurrency}) : super(key: key);

  @override
  _AutocompleteWidgetState createState() => _AutocompleteWidgetState();
}

class _AutocompleteWidgetState extends State<AutocompleteWidget> {
  List<String> filteredOptions = [];
  final TextEditingController _textEditingController = TextEditingController();
  bool showOptions = false;
  String selectedCurrency = "INR";

  @override
  void initState() {
    selectedCurrency = widget.selectedCurrency;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Expanded(
              child: TextField(
                controller: _textEditingController,
                onTap: () {
                  setState(() {
                    showOptions = true;
                  });
                },
                onChanged: (value) {
                  setState(() {
                    if (value.isEmpty) {
                      showOptions = false;
                    } else {
                      filteredOptions = widget.options.where((option) => option.toLowerCase().contains(value.toLowerCase())).toList();
                      showOptions = true;
                    }
                  });
                },
                style: const TextStyle(color: Colors.pinkAccent), // Text color
                decoration: const InputDecoration(
                  labelText: 'Search',
                  labelStyle: TextStyle(color: Colors.green), // Label text color
                  hintStyle: TextStyle(color: Colors.white), // Hint text color
                  border: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.white), // Border color
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.grey), // Line color
                  ),
                  focusedBorder: OutlineInputBorder(
                    // Highlight color when focused
                    borderSide: BorderSide(color: Colors.grey), // White color
                  ),
                ),
              ),
            ),
            IconButton(
              icon: const Icon(
                Icons.arrow_drop_down,
                color: Colors.grey,
              ),
              onPressed: () {
                setState(() {
                  showOptions = !showOptions;
                });
              },
            ),
          ],
        ),
        if (showOptions || _textEditingController.text.isEmpty)
          Container(
            constraints: const BoxConstraints(maxHeight: 200),
            child: ListView.builder(
              itemCount: showOptions ? filteredOptions.length : widget.options.length,
              itemBuilder: (context, index) {
                final option = showOptions ? filteredOptions[index] : widget.options[index];
                return ListTile(
                  title: Text(
                    option,
                    style: const TextStyle(color: Colors.yellowAccent),
                  ),
                  onTap: () {
                    _textEditingController.text = option;
                    widget.onChange(option);
                    setState(() {
                      showOptions = false;
                      filteredOptions = [];
                    });
                  },
                );
              },
            ),
          ),
      ],
    );
  }
}
