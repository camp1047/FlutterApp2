import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage('assets/images/background.jpeg'), 
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
            Expanded(
              child: Container(
                color: Theme.of(context).colorScheme.secondary, 
                child: Center(
                  child: Text(
                    'Welcome to Our App!',
                    style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                      color: Colors.white, 
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
