import 'package:flutter/material.dart';
import '../auth_sevices.dart';
import 'login_page.dart';

class SignupPage extends StatefulWidget {
  const SignupPage({super.key});

  @override
  State<SignupPage> createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  final AuthSevices _authService = AuthSevices();

  TextEditingController N = TextEditingController();
  TextEditingController mail = TextEditingController();
  TextEditingController number = TextEditingController();
  TextEditingController pass = TextEditingController();
  TextEditingController rePass = TextEditingController();

  bool nameErr = false;
  bool emailErr = false;
  bool numErr = false;
  bool passErr = false;
  bool conPassErr = false;

  bool showNum = true;
  bool showPass = false;
  bool showConPass = false;
  bool isLoading = false;

  bool ckName(String t) {
    return t.isNotEmpty && t.length >= 6 && RegExp(r'^[A-Z]').hasMatch(t);
  }

  bool ckMail(String t) {
    return t.isNotEmpty && t.contains('@') && t.contains('.');
  }

  bool ckNum(String t) {
    return t.length == 11 && t.startsWith('01') && RegExp(r'^[0-9]+$').hasMatch(t);
  }

  bool ckPass(String t) {
    if (t.length < 8) return false;
    bool l = t.contains(RegExp(r'[a-zA-Z]'));
    bool n = t.contains(RegExp(r'[0-9]'));
    bool sym = t.contains(RegExp(r'[^a-zA-Z0-9]'));
    return l && n && sym;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8F5F2),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(top: 55.0, left: 20.0, right: 20.0, bottom: 15.0),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Create an account',
                        style: TextStyle(fontSize: 27, fontWeight: FontWeight.bold, color: Color(0xFF2D2013)),
                      ),
                      SizedBox(height: 5),
                      Text('Please type full information', style: TextStyle(fontSize: 15, color: Colors.grey)),
                      Text('below to create your account', style: TextStyle(fontSize: 15, color: Colors.grey)),
                    ],
                  ),
                  Image.asset('Assets/Sign_up_page_image/sign_up_logo.png', height: 50),
                ],
              ),
              const SizedBox(height: 5),
              Image.asset('Assets/Sign_up_page_image/sign_up_ui.png', height: 190, fit: BoxFit.contain),
              const SizedBox(height: 5),
              TextField(
                controller: N,
                onChanged: (val) {
                  if (nameErr) {
                    setState(() {
                      nameErr = !ckName(val);
                    });
                  }
                },
                decoration: InputDecoration(
                  hintText: 'Name',
                  prefixIcon: const Icon(Icons.person, color: Color(0xFF2D2013)),
                  filled: true,
                  fillColor: const Color(0xFFE8E3DC),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                    borderSide: BorderSide(color: nameErr ? Colors.red : const Color(0xFF2D2013), width: 2),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                    borderSide: BorderSide(color: nameErr ? Colors.red : const Color(0xFF2D2013), width: 2),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                    borderSide: BorderSide(color: nameErr ? Colors.lightGreen : const Color(0xFF2D2013), width: 2),
                  ),
                ),
              ),
              if (nameErr)
                const Padding(
                  padding: EdgeInsets.only(top: 4, left: 12),
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      'Name is invalid',
                      style: TextStyle(color: Colors.red, fontSize: 12, fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
              const SizedBox(height: 8),
              TextField(
                controller: mail,
                onChanged: (val) {
                  if (emailErr) {
                    setState(() {
                      emailErr = !ckMail(val);
                    });
                  }
                },
                decoration: InputDecoration(
                  hintText: 'Email address',
                  prefixIcon: const Icon(Icons.email, color: Color(0xFF2D2013)),
                  filled: true,
                  fillColor: const Color(0xFFE8E3DC),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                    borderSide: BorderSide(color: emailErr ? Colors.red : const Color(0xFF2D2013), width: 2),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                    borderSide: BorderSide(color: emailErr ? Colors.red : const Color(0xFF2D2013), width: 2),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                    borderSide: BorderSide(color: emailErr ? Colors.lightGreen : const Color(0xFF2D2013), width: 2),
                  ),
                ),
              ),
              if (emailErr)
                const Padding(
                  padding: EdgeInsets.only(top: 4, left: 12),
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      'Email is invalid',
                      style: TextStyle(color: Colors.red, fontSize: 12, fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
              const SizedBox(height: 8),
              TextField(
                controller: number,
                keyboardType: TextInputType.phone,
                obscureText: !showNum,
                onChanged: (val) {
                  if (numErr) {
                    setState(() {
                      numErr = !ckNum(val);
                    });
                  }
                },
                decoration: InputDecoration(
                  hintText: 'Mobile number',
                  prefixIcon: const Icon(Icons.phone, color: Color(0xFF2D2013)),
                  suffixIcon: IconButton(
                    icon: Icon(showNum ? Icons.visibility : Icons.visibility_off, color: const Color(0xFF2D2013)),
                    onPressed: () {
                      setState(() {
                        showNum = !showNum;
                      });
                    },
                  ),
                  filled: true,
                  fillColor: const Color(0xFFE8E3DC),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                    borderSide: BorderSide(color: numErr ? Colors.red : const Color(0xFF2D2013), width: 2),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                    borderSide: BorderSide(color: numErr ? Colors.red : const Color(0xFF2D2013), width: 2),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                    borderSide: BorderSide(color: numErr ? Colors.lightGreen : const Color(0xFF2D2013), width: 2),
                  ),
                ),
              ),
              if (numErr)
                const Padding(
                  padding: EdgeInsets.only(top: 4, left: 12),
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      'Mobile number is invalid',
                      style: TextStyle(color: Colors.red, fontSize: 12, fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
              const SizedBox(height: 8),
              TextField(
                controller: pass,
                obscureText: !showPass,
                onChanged: (val) {
                  if (passErr) {
                    setState(() {
                      passErr = !ckPass(val);
                    });
                  }
                  if (conPassErr) {
                    setState(() {
                      conPassErr = !ckPass(rePass.text) || rePass.text != val;
                    });
                  }
                },
                decoration: InputDecoration(
                  hintText: 'Password > 8 & includes char,num,sym',
                  prefixIcon: const Icon(Icons.lock_clock, color: Color(0xFF2D2013)),
                  suffixIcon: IconButton(
                    icon: Icon(showPass ? Icons.visibility : Icons.visibility_off, color: const Color(0xFF2D2013)),
                    onPressed: () {
                      setState(() {
                        showPass = !showPass;
                      });
                    },
                  ),
                  filled: true,
                  fillColor: const Color(0xFFE8E3DC),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                    borderSide: BorderSide(color: passErr ? Colors.red : const Color(0xFF2D2013), width: 2),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                    borderSide: BorderSide(color: passErr ? Colors.red : const Color(0xFF2D2013), width: 2),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                    borderSide: BorderSide(color: passErr ? Colors.lightGreen : const Color(0xFF2D2013), width: 2),
                  ),
                ),
              ),
              if (passErr)
                const Padding(
                  padding: EdgeInsets.only(top: 4, left: 12),
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      'Password is invalid',
                      style: TextStyle(color: Colors.red, fontSize: 12, fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
              const SizedBox(height: 8),
              TextField(
                controller: rePass,
                obscureText: !showConPass,
                onChanged: (val) {
                  if (conPassErr) {
                    setState(() {
                      conPassErr = !ckPass(val) || val != pass.text;
                    });
                  }
                },
                decoration: InputDecoration(
                  hintText: 'Again the same password',
                  prefixIcon: const Icon(Icons.lock_clock, color: Color(0xFF2D2013)),
                  suffixIcon: IconButton(
                    icon: Icon(showConPass ? Icons.visibility : Icons.visibility_off, color: const Color(0xFF2D2013)),
                    onPressed: () {
                      setState(() {
                        showConPass = !showConPass;
                      });
                    },
                  ),
                  filled: true,
                  fillColor: const Color(0xFFE8E3DC),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                    borderSide: BorderSide(color: conPassErr ? Colors.red : const Color(0xFF2D2013), width: 2),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                    borderSide: BorderSide(color: conPassErr ? Colors.red : const Color(0xFF2D2013), width: 2),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                    borderSide: BorderSide(color: conPassErr ? Colors.lightGreen : const Color(0xFF2D2013), width: 2),
                  ),
                ),
              ),
              if (conPassErr)
                const Padding(
                  padding: EdgeInsets.only(top: 4, left: 12),
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      'Passwords do not match',
                      style: TextStyle(color: Colors.red, fontSize: 12, fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
              const SizedBox(height: 10),
              const Text(
                'By signing up, you agree to our Terms of use and privacy notice',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 13, color: Colors.grey),
              ),
              const SizedBox(height: 10),
              ElevatedButton(
                onPressed: isLoading
                    ? null
                    : () async {
                  setState(() {
                    nameErr = !ckName(N.text);
                    emailErr = !ckMail(mail.text);
                    numErr = !ckNum(number.text);
                    passErr = !ckPass(pass.text);
                    conPassErr = !ckPass(rePass.text) || rePass.text != pass.text;
                  });

                  if (!nameErr && !emailErr && !numErr && !passErr && !conPassErr) {
                    setState(() => isLoading = true);

                    // Mobile number-shoh call kora hocche
                    String? res = await _authService.signUp(
                      name: N.text.trim(),
                      email: mail.text.trim(),
                      password: pass.text.trim(),
                      phoneNumber: number.text.trim(),
                    );

                    if (!mounted) return;

                    setState(() => isLoading = false);

                    if (res == null) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Account created! Verification link sent to your email. Please login after verifying.')),
                      );
                      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const LoginPage()));
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text(res)),
                      );
                    }
                  }
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF2D2013),
                  foregroundColor: Colors.white,
                  minimumSize: const Size(double.infinity, 48),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                ),
                child: isLoading
                    ? const SizedBox(
                  height: 20,
                  width: 20,
                  child: CircularProgressIndicator(color: Colors.white, strokeWidth: 2),
                )
                    : const Text('Join Now', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
              ),
              const SizedBox(height: 6),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text('Already have an account? ', style: TextStyle(color: Colors.grey, fontSize: 15)),
                  TextButton(
                    onPressed: () {
                      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const LoginPage()));
                    },
                    child: const Text('Sign In', style: TextStyle(color: Color(0xFF2D2013), fontWeight: FontWeight.bold, fontSize: 15)),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}