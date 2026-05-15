import 'package:flutter/material.dart';

void main() {
  runApp(const AdderPresentationApp());
}

class AdderPresentationApp extends StatelessWidget {
  const AdderPresentationApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Basic Adders Presentation',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blueGrey),
        useMaterial3: true,
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => const PresentationScreen(),
      },
    );
  }
}

class Slide {
  final String title;
  final Widget content;

  const Slide({required this.title, required this.content});
}

class PresentationScreen extends StatefulWidget {
  const PresentationScreen({super.key});

  @override
  State<PresentationScreen> createState() => _PresentationScreenState();
}

class _PresentationScreenState extends State<PresentationScreen> {
  int _currentSlide = 0;

  final List<Slide> _slides = [
    Slide(
      title: 'Introduction to Basic Adders',
      content: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: const [
          Text(
            'Digital Logic Design',
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 20),
          Text(
            'Understanding how computers perform arithmetic at the hardware level.',
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 18),
          ),
        ],
      ),
    ),
    Slide(
      title: 'Binary Addition Rules',
      content: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: const [
          Text('Just like decimal addition, but with only 0s and 1s:', style: TextStyle(fontSize: 18)),
          SizedBox(height: 20),
          Text('• 0 + 0 = 0'),
          Text('• 0 + 1 = 1'),
          Text('• 1 + 0 = 1'),
          Text('• 1 + 1 = 10 (Sum = 0, Carry = 1)'),
        ],
      ),
    ),
    Slide(
      title: 'The Half Adder',
      content: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: const [
          Text('Adds two single binary digits (A and B).', style: TextStyle(fontSize: 18)),
          SizedBox(height: 20),
          Text('Outputs:', style: TextStyle(fontWeight: FontWeight.bold)),
          Text('• Sum (S) = A XOR B'),
          Text('• Carry (C) = A AND B'),
          SizedBox(height: 20),
          Text('Limitation: Cannot accept a carry from a previous less significant digit.'),
        ],
      ),
    ),
    Slide(
      title: 'The Full Adder',
      content: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: const [
          Text('Adds three single binary digits: A, B, and a Carry-In (Cin).', style: TextStyle(fontSize: 18)),
          SizedBox(height: 20),
          Text('Outputs:', style: TextStyle(fontWeight: FontWeight.bold)),
          Text('• Sum (S) = A XOR B XOR Cin'),
          Text('• Carry-Out (Cout) = (A AND B) OR (Cin AND (A XOR B))'),
          SizedBox(height: 20),
          Text('Advantage: Can be chained together to add multi-bit numbers.'),
        ],
      ),
    ),
    Slide(
      title: 'Ripple Carry Adder',
      content: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: const [
          Text('Multiple Full Adders connected in a chain.', style: TextStyle(fontSize: 18)),
          SizedBox(height: 20),
          Text('How it works:', style: TextStyle(fontWeight: FontWeight.bold)),
          Text('• The Carry-Out of each adder is connected to the Carry-In of the next.'),
          Text('• Used to add multi-bit numbers (e.g., 4-bit, 8-bit, 32-bit).'),
          SizedBox(height: 20),
          Text('Limitation: Propagation delay. The higher-order bits must wait for the carry to "ripple" through the lower-order bits.'),
        ],
      ),
    ),
    Slide(
      title: 'Summary',
      content: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: const [
          Text('• Adders are the fundamental building blocks of the ALU (Arithmetic Logic Unit).'),
          SizedBox(height: 10),
          Text('• Half Adders add two bits.'),
          SizedBox(height: 10),
          Text('• Full Adders add three bits (including Carry-In).'),
          SizedBox(height: 10),
          Text('• Ripple Carry Adders chain Full Adders to add multi-bit numbers.'),
        ],
      ),
    ),
  ];

  void _nextSlide() {
    if (_currentSlide < _slides.length - 1) {
      setState(() {
        _currentSlide++;
      });
    }
  }

  void _previousSlide() {
    if (_currentSlide > 0) {
      setState(() {
        _currentSlide--;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_slides[_currentSlide].title),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 800),
          child: Card(
            margin: const EdgeInsets.all(16.0),
            elevation: 4,
            child: Padding(
              padding: const EdgeInsets.all(32.0),
              child: _slides[_currentSlide].content,
            ),
          ),
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            TextButton.icon(
              onPressed: _currentSlide > 0 ? _previousSlide : null,
              icon: const Icon(Icons.arrow_back),
              label: const Text('Previous'),
            ),
            Text(
              'Slide ${_currentSlide + 1} of ${_slides.length}',
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
            TextButton.icon(
              onPressed: _currentSlide < _slides.length - 1 ? _nextSlide : null,
              icon: const Icon(Icons.arrow_forward),
              label: const Text('Next'),
              iconAlignment: IconAlignment.end,
            ),
          ],
        ),
      ),
    );
  }
}
