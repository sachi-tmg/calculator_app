import 'package:flutter/material.dart';

class CalculatorView extends StatefulWidget {
  const CalculatorView({super.key});

  @override
  State<CalculatorView> createState() => _CalculatorViewState();
}

class _CalculatorViewState extends State<CalculatorView> {
  final _textController = TextEditingController();
  List<String> lstSymbols = [
    "C",
    "*",
    "/",
    "<-",
    "1",
    "2",
    "3",
    "+",
    "4",
    "5",
    "6",
    "-",
    "7",
    "8",
    "9",
    "*",
    "%",
    "0",
    ".",
    "=",
  ];

  String displayText = "";
  String previousText = "";
  String operation = "";
  bool resultDisplayed = false; // Flag to track if a result was displayed

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Sachi Calculator App'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            // Display the equation being solved
            Align(
              alignment: Alignment.centerRight,
              child: Text(
                previousText.isNotEmpty && operation.isNotEmpty
                    ? "$previousText $operation $displayText"
                    : "",
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w300,
                  color: Colors.grey,
                ),
              ),
            ),
            const SizedBox(height: 4),
            TextFormField(
              controller: _textController,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
              ),
              style: const TextStyle(
                fontSize: 40,
                fontWeight: FontWeight.bold,
              ),
              readOnly: true,
              textAlign: TextAlign.right,
            ),
            const SizedBox(height: 8),
            Expanded(
              child: GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 4,
                  crossAxisSpacing: 8.0,
                  mainAxisSpacing: 8.0,
                ),
                itemCount: lstSymbols.length,
                itemBuilder: (context, index) {
                  return ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color.fromARGB(255, 126, 243, 185),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                    ),
                    onPressed: () {
                      setState(() {
                        String value = lstSymbols[index];

                        if (value == "C") {
                          displayText = "";
                          previousText = "";
                          operation = "";
                          resultDisplayed = false;
                        } else if (value == "<-") {
                          displayText = displayText.isNotEmpty
                              ? displayText.substring(0, displayText.length - 1)
                              : "";
                          resultDisplayed = false;
                        } else if (value == "=") {
                          if (previousText.isNotEmpty &&
                              displayText.isNotEmpty &&
                              operation.isNotEmpty) {
                            double num1 = double.tryParse(previousText) ?? 0;
                            double num2 = double.tryParse(displayText) ?? 0;
                            displayText = (operation == "+")
                                ? (num1 + num2).toString()
                                : (operation == "-")
                                    ? (num1 - num2).toString()
                                    : (operation == "*")
                                        ? (num1 * num2).toString()
                                        : (operation == "/" && num2 != 0)
                                            ? (num1 / num2).toString()
                                            : (operation == "%")
                                                ? (num1 % num2).toString()
                                                : "0";
                            previousText = "";
                            operation = "";
                            resultDisplayed = true; // Result is displayed
                          }
                        } else if (["+", "-", "*", "/", "%"].contains(value)) {
                          previousText = displayText;
                          displayText = "";
                          operation = value;
                          resultDisplayed = false;
                        } else {
                          if (resultDisplayed) {
                            displayText =
                                ""; // Clear the field if result was displayed
                            resultDisplayed = false;
                          }
                          displayText += value;
                        }
                        _textController.text = displayText;
                      });
                    },
                    child: Text(
                      lstSymbols[index],
                      style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
