import 'dart:math';
import 'package:flutter/material.dart';

class AuthService {
  // Singleton pattern
  static final AuthService _instance = AuthService._internal();
  factory AuthService() => _instance;
  AuthService._internal();
  
  // Store user information
  String? _currentUserEmail;
  String? _currentUserName;
  
  // Store verification information
  String? _pendingVerificationEmail;
  String? _verificationCode;
  DateTime? _verificationCodeExpiry;
  
  // Getters
  String? get currentUserEmail => _currentUserEmail;
  String? get currentUserName => _currentUserName;
  String? get pendingVerificationEmail => _pendingVerificationEmail;
  bool get isLoggedIn => _currentUserEmail != null;
  
  // Register a new user
  Future<bool> registerUser(String name, String email, String password) async {
    try {
      // In a real app, you would call an API to register the user
      // For this example, we'll just simulate a delay
      await Future.delayed(const Duration(seconds: 1));
      
      // Store the email for verification
      _pendingVerificationEmail = email;
      _currentUserName = name;
      
      // Generate a verification code
      _generateVerificationCode();
      
      return true;
    } catch (e) {
      debugPrint('Error registering user: $e');
      return false;
    }
  }
  
  // Generate a random 4-digit verification code
  void _generateVerificationCode() {
    final random = Random();
    _verificationCode = (1000 + random.nextInt(9000)).toString();
    
    // Set expiry time to 30 minutes from now
    _verificationCodeExpiry = DateTime.now().add(const Duration(minutes: 01));
    
    debugPrint('Generated verification code: $_verificationCode');
  }
  
  // Verify the code entered by the user
  Future<bool> verifyCode(String enteredCode) async {
    try {
      // Simulate API call
      await Future.delayed(const Duration(seconds: 1));
      
      // Check if code is expired
      if (_verificationCodeExpiry == null || 
          DateTime.now().isAfter(_verificationCodeExpiry!)) {
        return false;
      }
      
      // Check if code matches
      if (enteredCode == _verificationCode) {
        // Set the user as verified and logged in
        _currentUserEmail = _pendingVerificationEmail;
        _pendingVerificationEmail = null;
        _verificationCode = null;
        _verificationCodeExpiry = null;
        
        return true;
      }
      
      return false;
    } catch (e) {
      debugPrint('Error verifying code: $e');
      return false;
    }
  }
  
  // Resend verification code
  Future<bool> resendVerificationCode() async {
    try {
      // Check if there's a pending verification
      if (_pendingVerificationEmail == null) {
        return false;
      }
      
      // Generate a new code
      _generateVerificationCode();
      
      // In a real app, you would call an API to send the email with the code
      // For this example, we'll just simulate a delay
      await Future.delayed(const Duration(seconds: 1));
      
      return true;
    } catch (e) {
      debugPrint('Error resending verification code: $e');
      return false;
    }
  }
  
  // Login user
  Future<bool> loginUser(String email, String password) async {
    try {
      // In a real app, you would call an API to authenticate the user
      // For this example, we'll just simulate a delay
      await Future.delayed(const Duration(seconds: 1));
      
      // Set the user as logged in
      _currentUserEmail = email;
      _currentUserName = "User"; // In a real app, you would get this from the API
      
      return true;
    } catch (e) {
      debugPrint('Error logging in: $e');
      return false;
    }
  }
  
  // Logout user
  Future<void> logoutUser() async {
    _currentUserEmail = null;
    _currentUserName = null;
  }
  
  // Reset password
  Future<bool> resetPassword(String email) async {
    try {
      // In a real app, you would call an API to send a password reset email
      // For this example, we'll just simulate a delay
      await Future.delayed(const Duration(seconds: 1));
      
      return true;
    } catch (e) {
      debugPrint('Error resetting password: $e');
      return false;
    }
  }
}

