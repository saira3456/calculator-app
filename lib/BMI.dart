import 'package:flutter/material.dart';
import 'package:flutter_application_2/FemaleScreen.dart';
import 'package:flutter_application_2/MaleScreen.dart';

class BMI extends StatefulWidget {
  const BMI({super.key});

  @override
  State<BMI> createState() => _BMIState();
}

class _BMIState extends State<BMI> {
  @override
  Widget build(BuildContext context) {
    final ButtonStyle style =
        ElevatedButton.styleFrom(textStyle: const TextStyle(fontSize: 15));
    return Scaffold(
      appBar: AppBar(
        title: const Text('BMI Calculator'),
      ),
      body: Container(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            const SizedBox(
              height: 100,
            ),
            const Text(
              'Select your gender',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 35),
            ),
            const SizedBox(height: 60),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Expanded(
                  child: Column(
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(100),
                        child: Image.network(
                          'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcR1K68QF717KgWu76vmBt8MkubOA7QV-dfmGBnNh03YSM3LXx3prK5mNh28OVbjnvyeQuA&usqp=CAU',
                          fit: BoxFit.cover,
                          errorBuilder: (context, error, stackTrace) {
                            return const Icon(Icons.image_not_supported);
                          },
                          loadingBuilder: (context, child, loadingProgress) {
                            if (loadingProgress?.cumulativeBytesLoaded ==
                                loadingProgress?.expectedTotalBytes) {
                              return child;
                            }
                            return const CircularProgressIndicator.adaptive();
                          },
                        ),
                      ),
                      ElevatedButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute<void>(
                              builder: (BuildContext context) =>
                                  const MaleScreen(),
                            ),
                          );
                        },
                        style: style,
                        child: const Text(
                          'Male',
                          style: TextStyle(fontSize: 30),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: 20),
                Expanded(
                  child: Column(
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(100),
                        child: Image.network(
                          'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQJEEJFJF_IRt7erUekFSx6QscC09hTvO1OfF-X-1wsCM1_oz-8KkJ1NKnUVMPL5vZPY_g&usqp=CAU',
                          fit: BoxFit.cover,
                          errorBuilder: (context, error, stackTrace) {
                            return const Icon(Icons.image_not_supported);
                          },
                          loadingBuilder: (context, child, loadingProgress) {
                            if (loadingProgress?.cumulativeBytesLoaded ==
                                loadingProgress?.expectedTotalBytes) {
                              return child;
                            }
                            return const CircularProgressIndicator.adaptive();
                          },
                        ),
                      ),
                      ElevatedButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute<void>(
                              builder: (BuildContext context) =>
                                  const FemaleScreen(),
                            ),
                          );
                        },
                        style: style,
                        child: const Text(
                          'Female',
                          style: TextStyle(fontSize: 30),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
