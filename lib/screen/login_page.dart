import 'package:flutter/material.dart';
import 'home_page.dart';
import 'signup_page.dart';
import 'verification_page.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController mail = TextEditingController();
  TextEditingController pass = TextEditingController();

  bool mailErr = false;
  bool passErr = false;
  bool showPass = false;

  bool ckMail(String t) {
    return t.isNotEmpty && t.contains('@') && t.contains('.');
  }

  bool ckPass(String t) {
    if (t.isEmpty && t.length < 8) return false;
    bool l = t.contains(RegExp(r'[a-zA-Z]'));
    bool n = t.contains(RegExp(r'[0-9]'));
    bool sym = t.contains(RegExp(r'[^a-zA-Z0-9]'));
    return l && n && sym;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF8F5F2),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.only(top: 45.0, left: 20.0, right: 20.0, bottom: 20.0),
          child: Column(
          children: [Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                    Text('Welcome Foodi!',style: TextStyle(fontSize: 25,fontWeight: FontWeight.bold,color: Color(0xFF2D2013),),),
                      SizedBox(height: 5),
                    Text('Login to continue and explore the',style: TextStyle(fontSize: 16, color: Colors.grey),),
                    Text('world of recipes',style :TextStyle(fontSize: 16,color: Colors.grey),),
                    ],
                  ),
                  Image.asset('Assets/log_page_assets/login_logo.png', height: 50),
                ],
              ),
              SizedBox(height: 15),
              Image.asset('Assets/log_page_assets/Login_page_image.png', height: 220, fit: BoxFit.contain),
              SizedBox(height: 10),
              Text('Login', style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Color(0xFF2D2013))),
              SizedBox(height: 15),
              TextField(
                controller: mail,
                onChanged: (val) {
                  if (mailErr) {
                    setState(() {
                      mailErr = !ckMail(val);
                    });
                  }
                },
                decoration: InputDecoration(
                  hintText: 'Email address',
                  prefixIcon: Icon(Icons.email, color: Color(0xFF2D2013)),
                  filled: true,
                  fillColor: Color(0xFFE8E3DC),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                    borderSide: BorderSide(color: mailErr ? Colors.red : Color(0xFF2D2013), width: 2),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                    borderSide: BorderSide(color: mailErr ? Colors.red : Color(0xFF2D2013), width: 2),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                    borderSide: BorderSide(color: mailErr ? Colors.lightGreen : Color(0xFF2D2013), width: 2),
                  ),
                ),
              ),
              if (mailErr)
                Padding(
                  padding: EdgeInsets.only(top: 4, left: 12),
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      'Email is invalid',
                      style: TextStyle(color: Colors.red, fontSize: 12, fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
              SizedBox(height: 12),
              TextField(
                controller: pass,
                obscureText: !showPass,
                onChanged: (val) {
                  if (passErr) {
                    setState(() {
                      passErr = !ckPass(val);
                    });
                  }
                },
                decoration: InputDecoration(
                  hintText: 'Password > 8 & includes char,num,sym',
                  prefixIcon: Icon(Icons.lock_clock, color: Color(0xFF2D2013)),
                  suffixIcon: IconButton(
                    icon: Icon(showPass ? Icons.visibility : Icons.visibility_off, color: Color(0xFF2D2013)),
                    onPressed: () {
                      setState(() {
                        showPass = !showPass;
                      });
                    },
                  ),
                  filled: true,
                  fillColor: Color(0xFFE8E3DC),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                    borderSide: BorderSide(color: passErr ? Colors.red : Color(0xFF2D2013), width: 2),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                    borderSide: BorderSide(color: passErr ? Colors.red : Color(0xFF2D2013), width: 2),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                    borderSide: BorderSide(color: passErr ? Colors.lightGreen : Color(0xFF2D2013), width: 2),
                  ),
                ),
              ),
              if (passErr)
                Padding(
                  padding: EdgeInsets.only(top: 4, left: 12),
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      'Password is invalid',
                      style: TextStyle(color: Colors.red, fontSize: 12, fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
              SizedBox(height: 18),
              ElevatedButton(
                onPressed: () {
                  setState(() {
                    mailErr = !ckMail(mail.text);
                    passErr = !ckPass(pass.text);
                  });

                  if (!mailErr && !passErr) {
                    Navigator.push(context, MaterialPageRoute(builder: (context) => VerificationPage()));
                  }
                },style: ElevatedButton.styleFrom(backgroundColor: Color(0xFF2D2013),
                foregroundColor: Colors.white,minimumSize: Size(double.infinity, 50),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20),),
                ),
                child: Text('Login Now', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
              ),
              SizedBox(height: 6),
              TextButton(
                onPressed: () {
                  Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(builder: (context) => HomePage()),
                    (route) => false,
                  );
                },
                child: Text('Login as Guest', style: TextStyle(color: Color(0xFF2D2013), fontWeight: FontWeight.bold, fontSize: 16)),
              ),
              SizedBox(height: 8),
            Row(mainAxisAlignment: MainAxisAlignment.center,
                children: [
                Text("Don't have an account? ",style: TextStyle(color: Colors.grey, fontSize: 14),),
                TextButton(onPressed: () {
                        Navigator.push(context,
                           MaterialPageRoute(builder: (context) => const SignupPage()),);
                    },
                    child: Text('Register', style: TextStyle(color: Color(0xFF2D2013), fontWeight: FontWeight.bold, fontSize: 16)),
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
