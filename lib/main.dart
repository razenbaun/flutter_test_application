import 'package:flutter/material.dart';

class MainScreen extends StatelessWidget {
  const MainScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Главное меню')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(
                  context,
                  '/second',
                  arguments: {
                    'title': 'Первый вариант',
                    'count': 10,
                    'isActive': true,
                  },
                );
              }, 
              child: const Text('Вариант 1'),
            ),
            const SizedBox(height: 10),
            ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(
                  context,
                  '/second',
                  arguments: {
                    'title': 'Второй вариант',
                    'count': 20,
                    'isActive': false,
                  },
                );
              }, 
              child: const Text('Вариант 2'),
            ),
          ],
        ),
      ),
    );
  }
}

class SecondScreen extends StatelessWidget {
  final String title;
  final int count;
  final bool isActive;
  
  const SecondScreen({
    super.key,
    required this.title,
    required this.count,
    required this.isActive,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(title)),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Заголовок: $title', style: const TextStyle(fontSize: 20)),
            Text('Число: $count', style: const TextStyle(fontSize: 18)),
            Text('Активно: $isActive', style: const TextStyle(fontSize: 18)),
            const SizedBox(height: 30),
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
              }, 
              child: const Text('Назад'),
            ),
          ],
        ),
      ),
    );
  }
}

void main() => runApp(const MainApp());

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: '/',
      routes: {
        '/': (context) => const MainScreen(),
      },
      onGenerateRoute: (RouteSettings settings) {
        switch (settings.name) {
          case '/second':
            final args = settings.arguments as Map<String, dynamic>? ?? {};
            
            return MaterialPageRoute(
              builder: (context) => SecondScreen(
                title: args['title'] ?? 'Без названия',
                count: args['count'] ?? 0,
                isActive: args['isActive'] ?? false,
              ),
            );
          
          default:
            return MaterialPageRoute(
              builder: (context) => const Scaffold(
                body: Center(child: Text('Страница не найдена')),
              ),
            );
        }
      },
    );
  }
}
