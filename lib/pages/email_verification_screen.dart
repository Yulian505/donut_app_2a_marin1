import 'dart:async';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class EmailVerificationScreen extends StatefulWidget {
  final String email;

  const EmailVerificationScreen({
    Key? key,
    required this.email,
  }) : super(key: key);

  @override
  State<EmailVerificationScreen> createState() => _EmailVerificationScreenState();
}

class _EmailVerificationScreenState extends State<EmailVerificationScreen> {
  // Controllers for the 4 digit code input fields
  final TextEditingController _digit1Controller = TextEditingController();
  final TextEditingController _digit2Controller = TextEditingController();
  final TextEditingController _digit3Controller = TextEditingController();
  final TextEditingController _digit4Controller = TextEditingController();
  
  // Focus nodes for each digit field
  final FocusNode _digit1FocusNode = FocusNode();
  final FocusNode _digit2FocusNode = FocusNode();
  final FocusNode _digit3FocusNode = FocusNode();
  final FocusNode _digit4FocusNode = FocusNode();
  
  // Timer variables
  late Timer _timer;
  int _timeLeft = 1800; // 30 minutes in seconds
  bool _canResend = false;
  
  // Verification code
  late String _verificationCode;
  String? _errorMessage;
  bool _isVerifying = false;
  
  @override
  void initState() {
    super.initState();
    // Generate a random 4-digit code
    _generateVerificationCode();
    // Start the timer
    _startTimer();
    // Simulate sending the email
    _sendVerificationEmail();
  }
  
  @override
  void dispose() {
    // Dispose controllers and focus nodes
    _digit1Controller.dispose();
    _digit2Controller.dispose();
    _digit3Controller.dispose();
    _digit4Controller.dispose();
    
    _digit1FocusNode.dispose();
    _digit2FocusNode.dispose();
    _digit3FocusNode.dispose();
    _digit4FocusNode.dispose();
    
    // Cancel the timer
    _timer.cancel();
    
    super.dispose();
  }
  
  // Generate a random 4-digit code
  void _generateVerificationCode() {
    final random = Random();
    _verificationCode = (1000 + random.nextInt(9000)).toString();
    debugPrint('Verification code: $_verificationCode'); // For testing purposes
  }
  
  // Start the 30-minute timer
  void _startTimer() {
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() {
        if (_timeLeft > 0) {
          _timeLeft--;
        } else {
          _canResend = true;
          timer.cancel();
        }
      });
    });
  }
  
  // Format the remaining time as mm:ss
  String get _formattedTimeLeft {
    final minutes = (_timeLeft ~/ 60).toString().padLeft(2, '0');
    final seconds = (_timeLeft % 60).toString().padLeft(2, '0');
    return '$minutes:$seconds';
  }
  
  // Simulate sending the verification email
  Future<void> _sendVerificationEmail() async {
    // In a real app, you would call an API to send the email with the code
    // For this example, we'll just simulate a delay
    await Future.delayed(const Duration(seconds: 2));
    
    // Show a snackbar to indicate the email was sent
    if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Verification code sent to ${widget.email}'),
          backgroundColor: Colors.green,
        ),
      );
    }
  }
  
  // Resend the verification code
  Future<void> _resendVerificationCode() async {
    if (!_canResend && _timeLeft > 0) return;
    
    setState(() {
      _isVerifying = true;
      _errorMessage = null;
    });
    
    // Generate a new code
    _generateVerificationCode();
    
    // Reset the timer
    _timeLeft = 1800;
    _canResend = false;
    _startTimer();
    
    // Send the new code
    await _sendVerificationEmail();
    
    setState(() {
      _isVerifying = false;
    });
  }
  
  // Verify the entered code
  Future<void> _verifyCode() async {
    // Get the entered code
    final enteredCode = _digit1Controller.text + 
                        _digit2Controller.text + 
                        _digit3Controller.text + 
                        _digit4Controller.text;
    
    if (enteredCode.length != 4) {
      setState(() {
        _errorMessage = 'Please enter all 4 digits';
      });
      return;
    }
    
    setState(() {
      _isVerifying = true;
      _errorMessage = null;
    });
    
    // Simulate API call delay
    await Future.delayed(const Duration(seconds: 1));
    
    if (enteredCode == _verificationCode) {
      // Code is correct, navigate to home
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Email verified successfully!'),
            backgroundColor: Colors.green,
          ),
        );
        
        // Navigate to home after a short delay
        Future.delayed(const Duration(seconds: 1), () {
          Navigator.pushReplacementNamed(context, '/home');
        });
      }
    } else {
      // Code is incorrect
      setState(() {
        _isVerifying = false;
        _errorMessage = 'Invalid verification code. Please try again.';
        
        // Clear the input fields
        _digit1Controller.clear();
        _digit2Controller.clear();
        _digit3Controller.clear();
        _digit4Controller.clear();
        
        // Set focus to the first field
        _digit1FocusNode.requestFocus();
      });
    }
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(24),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Email icon
                Container(
                  width: 80,
                  height: 80,
                  decoration: BoxDecoration(
                    color: const Color(0xFF5C6BC0),
                    shape: BoxShape.circle,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.1),
                        blurRadius: 10,
                        offset: const Offset(0, 4),
                      ),
                    ],
                  ),
                  child: const Icon(
                    Icons.email_outlined,
                    color: Colors.white,
                    size: 40,
                  ),
                ),
                const SizedBox(height: 24),
                
                // Title
                Text(
                  'Verify your email address',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: const Color(0xFF2E7D32),
                  ),
                ),
                const SizedBox(height: 16),
                
                // Subtitle
                Text(
                  'We have sent a verification code to',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.grey.shade700,
                    fontSize: 16,
                  ),
                ),
                Text(
                  widget.email,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
                const SizedBox(height: 16),
                
                // Instructions
                Text(
                  'Enter the 4-digit code below to verify your email address.\nYou might need to check your spam folder.',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.grey.shade700,
                    fontSize: 14,
                  ),
                ),
                const SizedBox(height: 32),
                
                // Code input fields
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    _buildDigitInput(_digit1Controller, _digit1FocusNode, _digit2FocusNode),
                    const SizedBox(width: 12),
                    _buildDigitInput(_digit2Controller, _digit2FocusNode, _digit3FocusNode),
                    const SizedBox(width: 12),
                    _buildDigitInput(_digit3Controller, _digit3FocusNode, _digit4FocusNode),
                    const SizedBox(width: 12),
                    _buildDigitInput(_digit4Controller, _digit4FocusNode, null),
                  ],
                ),
                const SizedBox(height: 16),
                
                // Error message
                if (_errorMessage != null)
                  Padding(
                    padding: const EdgeInsets.only(bottom: 16),
                    child: Text(
                      _errorMessage!,
                      style: const TextStyle(
                        color: Colors.red,
                        fontSize: 14,
                      ),
                    ),
                  ),
                
                // Timer
                Text(
                  'Code expires in: $_formattedTimeLeft',
                  style: TextStyle(
                    color: _timeLeft < 300 ? Colors.red : Colors.grey.shade700,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(height: 32),
                
                // Verify button
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: _isVerifying ? null : _verifyCode,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF2E7D32),
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                    ),
                    child: _isVerifying
                        ? const SizedBox(
                            height: 20,
                            width: 20,
                            child: CircularProgressIndicator(
                              color: Colors.white,
                              strokeWidth: 2,
                            ),
                          )
                        : const Text(
                            'Verify Email',
                            style: TextStyle(fontSize: 16),
                          ),
                  ),
                ),
                const SizedBox(height: 16),
                
                // Resend button
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: (_canResend || _timeLeft == 0) && !_isVerifying
                        ? _resendVerificationCode
                        : null,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF9C27B0),
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                    ),
                    child: Text(
                      _canResend || _timeLeft == 0
                          ? 'Resend Code'
                          : 'Resend Code (${_formattedTimeLeft})',
                      style: const TextStyle(fontSize: 16),
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                
                // Return to site button
                SizedBox(
                  width: double.infinity,
                  child: OutlinedButton(
                    onPressed: () {
                      Navigator.pushReplacementNamed(context, '/login');
                    },
                    style: OutlinedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      side: const BorderSide(color: Color(0xFF2E7D32)),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                    ),
                    child: const Text(
                      'Return to Login →',
                      style: TextStyle(
                        fontSize: 16,
                        color: Color(0xFF2E7D32),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 24),
                
                // Footer text
                const Text(
                  'You can reach us if you have any questions.',
                  style: TextStyle(
                    color: Colors.grey,
                    fontSize: 12,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
  
  // Build a single digit input field
  Widget _buildDigitInput(
    TextEditingController controller,
    FocusNode focusNode,
    FocusNode? nextFocusNode,
  ) {
    return Container(
      width: 60,
      height: 60,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            blurRadius: 10,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: TextField(
        controller: controller,
        focusNode: focusNode,
        keyboardType: TextInputType.number,
        textAlign: TextAlign.center,
        maxLength: 1,
        decoration: const InputDecoration(
          counterText: '',
          border: OutlineInputBorder(
            borderSide: BorderSide.none,
          ),
        ),
        style: const TextStyle(
          fontSize: 24,
          fontWeight: FontWeight.bold,
        ),
        inputFormatters: [
          FilteringTextInputFormatter.digitsOnly,
        ],
        onChanged: (value) {
          if (value.isNotEmpty && nextFocusNode != null) {
            nextFocusNode.requestFocus();
          }
          
          // Auto-verify when all digits are entered
          if (value.isNotEmpty && nextFocusNode == null) {
            // Check if all fields are filled
            if (_digit1Controller.text.isNotEmpty &&
                _digit2Controller.text.isNotEmpty &&
                _digit3Controller.text.isNotEmpty &&
                _digit4Controller.text.isNotEmpty) {
              _verifyCode();
            }
          }
        },
      ),
    );
  }
}

