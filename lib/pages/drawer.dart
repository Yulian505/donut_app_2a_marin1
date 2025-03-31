import 'package:donut_app_2a_marin1/pages/theme_provider.dart';
import 'package:flutter/material.dart';

class MyDrawer extends StatelessWidget {
  const MyDrawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: [
          // Drawer header with user info
          UserAccountsDrawerHeader(
            decoration: BoxDecoration(
              color: Color.fromARGB(255, 218, 113, 148),
            ),
            accountName: Text(
              "Usuario Demo",
              style: TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
            accountEmail: Text("usuario@ejemplo.com"),
            currentAccountPicture: CircleAvatar(
              backgroundColor: Colors.white,
              child: Icon(
                Icons.person,
                size: 50,
                color: Color.fromARGB(255, 218, 113, 148),
              ),
            ),
          ),
          
          // Menu items
          ListTile(
            leading: Icon(Icons.home),
            title: Text("Inicio"),
            onTap: () {
              Navigator.pop(context); // Close drawer
              // Already on home page
            },
          ),
          
          ListTile(
            leading: Icon(Icons.favorite),
            title: Text("Favoritos"),
            onTap: () {
              Navigator.pop(context); // Close drawer
              // Navigate to favorites (you would add this page later)
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text("Favoritos - Próximamente"))
              );
            },
          ),
          
          ListTile(
            leading: Icon(Icons.history),
            title: Text("Historial de pedidos"),
            onTap: () {
              Navigator.pop(context); // Close drawer
              // Navigate to order history (you would add this page later)
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text("Historial - Próximamente"))
              );
            },
          ),
          
          Divider(),
          
          ListTile(
            leading: Icon(Icons.settings),
            title: Text("Configuración"),
            onTap: () {
              Navigator.pop(context); // Close drawer first
              // Show settings dialog
              _showSettingsDialog(context);
            },
          ),
          
          ListTile(
            leading: Icon(Icons.help),
            title: Text("Ayuda"),
            onTap: () {
              Navigator.pop(context); // Close drawer
              // Navigate to help (you would add this page later)
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text("Ayuda - Próximamente"))
              );
            },
          ),
          
          Expanded(child: Container()),
          
          Divider(),
          
          ListTile(
            leading: Icon(Icons.logout, color: Colors.red),
            title: Text("Cerrar sesión", style: TextStyle(color: Colors.red)),
            onTap: () {
              Navigator.pop(context); // Close drawer
              // Logout logic
              Navigator.pushReplacementNamed(context, '/login');
            },
          ),
          SizedBox(height: 20),
        ],
      ),
    );
  }

  void _showSettingsDialog(BuildContext context) {
    // Get the current theme mode
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;
    
    showDialog(
      context: context,
      builder: (context) => StatefulBuilder(
        builder: (context, setState) {
          bool _isDarkMode = isDarkMode;
          
          return AlertDialog(
            title: Text('Configuración'),
            content: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Change Password
                  ListTile(
                    leading: Icon(Icons.lock_outline),
                    title: Text('Cambiar contraseña'),
                    onTap: () {
                      Navigator.pop(context);
                      _showChangePasswordDialog(context);
                    },
                  ),
                  
                  // Change Email
                  ListTile(
                    leading: Icon(Icons.email_outlined),
                    title: Text('Cambiar correo electrónico'),
                    onTap: () {
                      Navigator.pop(context);
                      _showChangeEmailDialog(context);
                    },
                  ),
                  
                  // Theme Toggle
                  SwitchListTile(
                    title: Text('Tema oscuro'),
                    secondary: Icon(
                      _isDarkMode ? Icons.dark_mode : Icons.light_mode,
                    ),
                    value: _isDarkMode,
                    onChanged: (value) {
                      setState(() {
                        _isDarkMode = value;
                      });
                      
                      // Toggle theme
                      final themeProvider = ThemeProvider.of(context);
                      if (themeProvider != null) {
                        themeProvider.toggleTheme();
                      } else {
                        // Fallback if ThemeProvider is not available
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text("Cambio de tema no disponible"))
                        );
                      }
                    },
                  ),
                  
                  // Logout
                  ListTile(
                    leading: Icon(Icons.logout, color: Colors.red),
                    title: Text('Cerrar sesión', style: TextStyle(color: Colors.red)),
                    onTap: () {
                      Navigator.pop(context);
                      Navigator.pushReplacementNamed(context, '/login');
                    },
                  ),
                ],
              ),
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: Text('Cerrar'),
              ),
            ],
          );
        }
      ),
    );
  }

  void _showChangePasswordDialog(BuildContext context) {
    final TextEditingController currentPasswordController = TextEditingController();
    final TextEditingController newPasswordController = TextEditingController();
    final TextEditingController confirmPasswordController = TextEditingController();
    
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Cambiar contraseña'),
        content: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: currentPasswordController,
                decoration: InputDecoration(
                  labelText: 'Contraseña actual',
                  border: OutlineInputBorder(),
                ),
                obscureText: true,
              ),
              SizedBox(height: 16),
              TextField(
                controller: newPasswordController,
                decoration: InputDecoration(
                  labelText: 'Nueva contraseña',
                  border: OutlineInputBorder(),
                ),
                obscureText: true,
              ),
              SizedBox(height: 16),
              TextField(
                controller: confirmPasswordController,
                decoration: InputDecoration(
                  labelText: 'Confirmar nueva contraseña',
                  border: OutlineInputBorder(),
                ),
                obscureText: true,
              ),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text('Cancelar'),
          ),
          ElevatedButton(
            onPressed: () {
              // Validate passwords
              if (newPasswordController.text.isEmpty || 
                  currentPasswordController.text.isEmpty ||
                  confirmPasswordController.text.isEmpty) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text("Por favor complete todos los campos"))
                );
                return;
              }
              
              if (newPasswordController.text != confirmPasswordController.text) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text("Las contraseñas nuevas no coinciden"))
                );
                return;
              }
              
              // Here you would implement the actual password change logic
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text("Contraseña cambiada exitosamente"))
              );
            },
            child: Text('Cambiar'),
          ),
        ],
      ),
    );
  }

  void _showChangeEmailDialog(BuildContext context) {
    final TextEditingController emailController = TextEditingController();
    final TextEditingController passwordController = TextEditingController();
    
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Cambiar correo electrónico'),
        content: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: emailController,
                decoration: InputDecoration(
                  labelText: 'Nuevo correo electrónico',
                  border: OutlineInputBorder(),
                ),
                keyboardType: TextInputType.emailAddress,
              ),
              SizedBox(height: 16),
              TextField(
                controller: passwordController,
                decoration: InputDecoration(
                  labelText: 'Contraseña actual',
                  border: OutlineInputBorder(),
                ),
                obscureText: true,
              ),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text('Cancelar'),
          ),
          ElevatedButton(
            onPressed: () {
              // Validate email
              if (emailController.text.isEmpty || passwordController.text.isEmpty) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text("Por favor complete todos los campos"))
                );
                return;
              }
              
              // Here you would implement the actual email change logic
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text("Correo electrónico cambiado exitosamente"))
              );
            },
            child: Text('Cambiar'),
          ),
        ],
      ),
    );
  }
}


