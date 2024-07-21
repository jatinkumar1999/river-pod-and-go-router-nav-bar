import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:river_pods_practice/go_router/first_screen.dart';
import 'package:river_pods_practice/go_router/seconds_screen.dart';
import 'package:river_pods_practice/go_router/third_screen.dart';
import 'package:river_pods_practice/pages/home_screen.dart';
import 'package:riverpod/riverpod.dart';

import 'pages/isolates/isolates_page.dart';

final counterProvider = StateProvider((ref) => 0);
void main() {
  runApp(
    const ProviderScope(
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'RiverPods',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      routerConfig: router,
      // home: const HomePage(),
      // home: const TextIsolatesScreen(),
    );
  }
}

// class MyApp extends StatelessWidget {
//   const MyApp({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'RiverPods',
//       debugShowCheckedModeBanner: false,
//       theme: ThemeData(
//         primarySwatch: Colors.blue,
//       ),
//       // home: const HomePage(),
//       home: const TextIsolatesScreen(),
//     );
//   }
// }
final _rootNavigatorKey = GlobalKey<NavigatorState>();
final _shellNavigatorKey = GlobalKey<NavigatorState>();
final router = GoRouter(
  initialLocation: '/',
  navigatorKey: _rootNavigatorKey,
  routes: [
    ShellRoute(
      navigatorKey: _shellNavigatorKey,
      pageBuilder: (context, state, child) {
        return NoTransitionPage(
          child: Scaffold(
            appBar: AppBar(
              title: const Text('Bottom Navigator Shell'),
            ),
            body: SafeArea(child: child),
            bottomNavigationBar: BottomNavigation(
              currentIndex: _bottomNavigationIndex.value,
              onTap: (index) => _bottomNavigationIndex.value = index,
              valueNotifier: _bottomNavigationIndex,
              // items: const [
              //   BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
              //   BottomNavigationBarItem(
              //       icon: Icon(Icons.explore), label: 'Explore'),
              //   BottomNavigationBarItem(
              //       icon: Icon(Icons.settings), label: 'Settings'),
              // ],
            ),
          ),
        );
      },
      routes: [
        GoRoute(
          path: '/',
          // parentNavigatorKey: context.goShell.navigatorKey,
          builder: (context, state) => Center(
            child: ElevatedButton(
              onPressed: () {
                context.push('/second_screen');
              },
              child: Text('first screen'),
            ),
          ),
          // p,: (context, state) => const Text('Home Page'),
        ),
        GoRoute(
          path: '/explore',
          // parentNavigatorKey: context.goShell.navigatorKey,
          builder: (context, state) => const Center(
            child: Text('Explore Page'),
          ),
          // pageBuilder: (context, state) => const Text('Explore Page'),
        ),
        GoRoute(
          path: '/settings',
          // parentNavigatorKey: context.goShell.navigatorKey,
          builder: (context, state) =>
              const Center(child: Text('Settings Page')),
          // pageBuilder: (context, state) => const Text('Settings Page'),
        ),
        GoRoute(
          path: '/second_screen',
          // parentNavigatorKey: _rootNavigatorKey,
          builder: (context, state) {
            return const SecondsScreen();
          },
        ),
      ],
    ),
    GoRoute(
      path: '/third_screen',
      // parentNavigatorKey: _rootNavigatorKey,
      builder: (context, state) {
        return const ThirdScreen();
      },
    ),
  ],
);

final _bottomNavigationIndex = ValueNotifier<int>(0);

// final GoRouter router = GoRouter(
//   routes: [
//     GoRoute(
//         path: '/',
//         builder: (context, state) {
//           return const FirstScreen();
//         },
//         routes: [
//           GoRoute(
//             path: 'second_screen',
//             builder: (context, state) {
//               return const SecondsScreen();
//             },
//           ),
//           GoRoute(
//             path: 'third_screen',
//             builder: (context, state) {
//               return const ThirdScreen();
//             },
//           ),
//         ]),
//   ],
// );

class BottomNavigation extends StatefulWidget {
  final int currentIndex;
  final ValueNotifier<int> valueNotifier;
  final ValueChanged<int> onTap;

  const BottomNavigation({
    super.key,
    required this.currentIndex,
    required this.valueNotifier,
    required this.onTap,
  });

  @override
  State<BottomNavigation> createState() => _BottomNavigationState();
}

class _BottomNavigationState extends State<BottomNavigation> {
  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<int>(
      valueListenable: widget.valueNotifier,
      builder: (context, selectedIndex, child) {
        return BottomNavigationBar(
          currentIndex: selectedIndex,
          onTap: (index) {
            widget.onTap(index);
            // context.goShell.goBranch(
            //   GoRoute(
            //     path: '/${['home', 'explore', 'settings'][index]}',
            //     // Other route parameters if needed
            //   ),
            // );
          },
          items: const [
            BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
            BottomNavigationBarItem(
                icon: Icon(Icons.explore), label: 'Explore'),
            BottomNavigationBarItem(
                icon: Icon(Icons.settings), label: 'Settings'),
          ],
        );
      },
    );
  }
}
