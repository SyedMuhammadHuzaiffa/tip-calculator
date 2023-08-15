import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Tip Calculator',
      theme: ThemeData.dark(),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  double billAmount = 0.0;
  double tipPercentage = 15.0;
  int splitCount = 1;

  double calculateTip() {
    return billAmount * (tipPercentage / 100);
  }

  double calculateTotalBill() {
    return billAmount + calculateTip();
  }

  double calculateBillPerPerson() {
    return calculateTotalBill() / splitCount;
  }

  double calculateTipPerPerson() {
    return calculateTip() / splitCount;
  }

  void incrementSplitCount() {
    setState(() {
      splitCount++;
    });
  }

  void decrementSplitCount() {
    if (splitCount > 1) {
      setState(() {
        splitCount--;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.grey[900],
      ),
      drawer: const Drawer(),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Container(
              decoration: BoxDecoration(
                color: Colors.grey[800],
                borderRadius: BorderRadius.circular(8.0),
              ),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    const Text(
                      "Per Person",
                      style: TextStyle(
                        color: Colors.blueAccent,  // Change to a cool color
                        fontSize: 18.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      '\$${calculateTotalBill().toStringAsFixed(2)}',
                      style: const TextStyle(
                        fontSize: 18.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 12.0),
                    const Text(
                      "Sub Total",
                      style: TextStyle(
                        color: Colors.blueAccent,  // Change to a cool color
                        fontSize: 18.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      '\$${calculateBillPerPerson().toStringAsFixed(2)}',
                      style: const TextStyle(
                        fontSize: 18.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 12.0),
                    const Text(
                      "Per Person",
                      style: TextStyle(
                        color: Colors.blueAccent,  // Change to a cool color
                        fontSize: 18.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      '\$${calculateTipPerPerson().toStringAsFixed(2)}',
                      style: const TextStyle(
                        fontSize: 18.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 40.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                ElevatedButton(
                  onPressed: () {
                    setState(() {
                      tipPercentage = 10.0;
                    });
                  },
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.all(8.0),
                    backgroundColor: tipPercentage == 10.0
                        ? Colors.blueAccent  // Change to a cool color
                        : Colors.grey,
                  ),
                  child: const Text('10%'),
                ),
                ElevatedButton(
                  onPressed: () {
                    setState(() {
                      tipPercentage = 15.0;
                    });
                  },
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.all(8.0),
                    backgroundColor: tipPercentage == 15.0
                        ? Colors.blueAccent  // Change to a cool color
                        : Colors.grey,
                  ),
                  child: const Text('15%'),
                ),
                ElevatedButton(
                  onPressed: () {
                    setState(() {
                      tipPercentage = 20.0;
                    });
                  },
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.all(8.0),
                    backgroundColor: tipPercentage == 20.0
                        ? Colors.blueAccent  // Change to a cool color
                        : Colors.grey,
                  ),
                  child: const Text('20%'),
                ),
                ElevatedButton(
                  onPressed: () {
                    showDialog(
                      context: context,
                      builder: (context) {
                        return AlertDialog(
                          title: const Text('Custom Tip Percentage'),
                          content: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: <Widget>[
                              TextField(
                                onChanged: (value) {
                                  setState(() {
                                    tipPercentage =
                                        double.tryParse(value) ?? 0.0;
                                  });
                                },
                                keyboardType: TextInputType.number,
                                decoration: const InputDecoration(
                                  labelText: 'Enter tip percentage',
                                ),
                              ),
                            ],
                          ),
                          actions: <Widget>[
                            TextButton(
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                              child: const Text('Cancel'),
                            ),
                            TextButton(
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                              child: const Text('Save'),
                            ),
                          ],
                        );
                      },
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.all(8.0),
                    backgroundColor: Colors.grey,
                  ),
                  child: const Text('Custom'),
                ),
              ],
            ),
            const SizedBox(height: 40.0),
            TextField(
              onChanged: (value) {
                setState(() {
                  billAmount = double.tryParse(value) ?? 0.0;
                });
              },
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                labelText: 'Enter bill amount',
              ),
            ),
            const SizedBox(height: 40.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                ElevatedButton(
                  onPressed: decrementSplitCount,
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.all(8.0),
                    backgroundColor: Colors.blueAccent,  // Change to a cool color
                    shape: const CircleBorder(),
                  ),
                  child: const Icon(Icons.remove),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: Text(
                    splitCount.toString(),
                    style: const TextStyle(fontSize: 24.0),
                  ),
                ),
                ElevatedButton(
                  onPressed: incrementSplitCount,
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.all(8.0),
                    backgroundColor: Colors.blueAccent,  // Change to a cool color
                    shape: const CircleBorder(),
                  ),
                  child: const Icon(Icons.add),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
