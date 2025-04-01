import 'package:donut_app_2a_marin1/pages/home_page.dart';
import 'package:flutter/material.dart';
// Importamos las pantallas de autenticación
import 'package:donut_app_2a_marin1/pages/login.dart';
import 'package:donut_app_2a_marin1/pages/register.dart';
import 'package:donut_app_2a_marin1/pages/verify.dart';
import 'package:donut_app_2a_marin1/pages/email_verification_screen.dart'; // Nueva pantalla
import 'package:donut_app_2a_marin1/pages/forgot.dart';
import 'package:donut_app_2a_marin1/pages/reset.dart';
import 'package:donut_app_2a_marin1/pages/theme_provider.dart';
void main() {
  runApp(const MyApp());
}
 
class MyApp extends StatelessWidget {
  const MyApp({super.key});
 
  @override
  Widget build(BuildContext context) {
    return ThemeProviderWidget(
      child: Builder(
        builder: (context) {
          final themeProvider = ThemeProvider.of(context);
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            title: 'Flutter Demo',
            theme: themeProvider?.theme ?? ThemeData(
              tabBarTheme: const TabBarTheme(indicatorColor: Colors.pink),
              colorScheme: ColorScheme.fromSeed(
                seedColor: Colors.deepPurple,
                primary: Colors.deepPurple,
                secondary: Colors.pink,
              ),
              useMaterial3: true,
              // Añadimos estilos para los inputs y botones
              inputDecorationTheme: InputDecorationTheme(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: const BorderSide(color: Colors.grey),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: const BorderSide(color: Colors.grey),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide(color: Colors.deepPurple.shade300, width: 2),
                ),
                contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
              ),
              elevatedButtonTheme: ElevatedButtonThemeData(
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                ),
              ),
              outlinedButtonTheme: OutlinedButtonThemeData(
                style: OutlinedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                ),
              ),
              textButtonTheme: TextButtonThemeData(
                style: TextButton.styleFrom(
                  foregroundColor: Colors.deepPurple,
                ),
              ),
            ),
            // Cambiamos la página inicial a LoginScreen
            home: const LoginScreen(),
            // Definimos las rutas para la navegación
            routes: {
              '/home': (context) => const HomePage(),
              '/login': (context) => const LoginScreen(),
              '/register': (context) => const RegisterScreen(),
              '/verify-email': (context) {
                final email = ModalRoute.of(context)?.settings.arguments as String? ?? '';
                return EmailVerificationScreen(email: email);
              },
              '/verify-old': (context) => const VerifyEmailScreen(),
              '/forgot-password': (context) => const ForgotPasswordScreen(),
              '/reset-password': (context) => const ResetPasswordScreen(),
            },
          );
        }
      ),
    );
  }
}

