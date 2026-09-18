import 'package:flutter/material.dart';
import '../auth_sevices.dart';
import 'login_page.dart';

class ForgotPasswordPage extends StatefulWidget {
  const ForgotPasswordPage({super.key});

  @override
  State<ForgotPasswordPage> createState() => _ForgotPasswordPageState();
}

class _ForgotPasswordPageState extends State<ForgotPasswordPage> {
  final AuthSevices _auth = AuthSevices();
  TextEditingController mail = TextEditingController();

  bool mailErr = false;
  bool isLoading = false;
  bool isSent = false;

  bool ckMail(String t) => t.isNotEmpty && t.contains('@') && t.contains('.');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8F5F2),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 45),
          child: Column(
            children: [
              Align(
                alignment: Alignment.topRight,
                child: Image.asset('Assets/log_page_assets/login_logo.png', height: 45),
              ),
              const SizedBox(height: 20),
              if (!isSent) ...[
                Image.asset('Assets/forget_pass_image/forget.png', height: 210, fit: BoxFit.contain),
                const SizedBox(height: 15),
                const Text('Forgot Password?', style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Color(0xFF2D2013))),
                const SizedBox(height: 6),
                const Text("Enter your email address and we'll send you a link to reset your password.", textAlign: TextAlign.center, style: TextStyle(color: Colors.grey)),
                const SizedBox(height: 15),
                TextField(
                  controller: mail,
                  onChanged: (val) { if (mailErr) setState(() => mailErr = !ckMail(val)); },
                  decoration: InputDecoration(
                    hintText: 'Enter your email address',
                    prefixIcon: const Icon(Icons.email, color: Color(0xFF2D2013)),
                    filled: true,
                    fillColor: const Color(0xFFE8E3DC),
                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(20), borderSide: BorderSide(color: mailErr ? Colors.red : const Color(0xFF2D2013), width: 2)),
                    enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(20), borderSide: BorderSide(color: mailErr ? Colors.red : const Color(0xFF2D2013), width: 2)),
                    focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(20), borderSide: BorderSide(color: mailErr ? Colors.red : const Color(0xFF2D2013), width: 2)),
                  ),
                ),
                if (mailErr) const Padding(padding: EdgeInsets.only(top: 4), child: Text('Email is invalid', style: TextStyle(color: Colors.red, fontSize: 12))),
                const SizedBox(height: 15),
                ElevatedButton(
                  onPressed: isLoading
                      ? null
                      : () async {
                          setState(() => mailErr = !ckMail(mail.text));
                          if (!mailErr) {
                            setState(() => isLoading = true);
                            String? res = await _auth.resetPassword(email: mail.text);
                            if (!mounted) return;
                            setState(() => isLoading = false);
                            if (res == null) {
                              setState(() => isSent = true);
                            } else {
                              ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(res)));
                            }
                          }
                        },
                  style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFF2D2013), foregroundColor: Colors.white, minimumSize: const Size(double.infinity, 48), shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20))),
                  child: isLoading ? const SizedBox(height: 20, width: 20, child: CircularProgressIndicator(color: Colors.white, strokeWidth: 2)) : const Text('Send Reset Link', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                ),
              ] else ...[
                const SizedBox(height: 40),
                const Icon(Icons.mark_email_read_outlined, size: 80, color: Color(0xFF2D2013)),
                const SizedBox(height: 15),
                const Text('Check Your Email', style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Color(0xFF2D2013))),
                const SizedBox(height: 8),
                const Text('If an account matches that email, you may receive a password reset link. Please check your inbox and spam folder.', textAlign: TextAlign.center, style: TextStyle(color: Colors.grey)),
              ],
              const SizedBox(height: 10),
              TextButton(
                onPressed: () => Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const LoginPage())),
                child: const Text('Back to Login', style: TextStyle(color: Color(0xFF2D2013), fontWeight: FontWeight.bold, fontSize: 16)),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
