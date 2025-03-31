import 'package:flutter/material.dart';

class ThemeProvider extends InheritedWidget {
  final ThemeData theme;
  final Function toggleTheme;

  const ThemeProvider({
    Key? key,
    required this.theme,
    required this.toggleTheme,
    required Widget child,
  }) : super(key: key, child: child);

  static ThemeProvider? of(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<ThemeProvider>();
  }

  @override
  bool updateShouldNotify(ThemeProvider oldWidget) {
    return theme != oldWidget.theme;
  }
}

class ThemeProviderWidget extends StatefulWidget {
  final Widget child;

  const ThemeProviderWidget({Key? key, required this.child}) : super(key: key);

  @override
  State<ThemeProviderWidget> createState() => _ThemeProviderWidgetState();
}

class _ThemeProviderWidgetState extends State<ThemeProviderWidget> {
  bool _isDarkMode = false;

  ThemeData get _theme {
    return _isDarkMode
        ? ThemeData.dark().copyWith(
            primaryColor: Color.fromARGB(255, 218, 113, 148),
            colorScheme: ColorScheme.dark(
              primary: Color.fromARGB(255, 218, 113, 148),
              secondary: Colors.pink,
            ),
          )
        : ThemeData.light().copyWith(
            primaryColor: Color.fromARGB(255, 218, 113, 148),
            colorScheme: ColorScheme.light(
              primary: Color.fromARGB(255, 218, 113, 148),
              secondary: Colors.pink,
            ),
          );
  }

  void _toggleTheme() {
    setState(() {
      _isDarkMode = !_isDarkMode;
    });
  }

  @override
  Widget build(BuildContext context) {
    return ThemeProvider(
      theme: _theme,
      toggleTheme: _toggleTheme,
      child: widget.child,
    );
  }
}

