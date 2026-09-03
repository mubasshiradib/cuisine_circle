import 'package:flutter/material.dart';
import 'login_page.dart';
class SignupPage extends StatelessWidget {
  const SignupPage({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF8F5F2),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.only(top: 55.0, left: 20.0, right: 20.0, bottom: 15.0),
          child: Column(
            children: [
              Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [Column(crossAxisAlignment: CrossAxisAlignment.start,
                    children: [Text('Create an account',
                        style: TextStyle(fontSize: 27, fontWeight: FontWeight.bold, color: Color(0xFF2D2013)),
                      ),
                      SizedBox(height: 5),
                      Text('Please type full information',style: TextStyle(fontSize: 15, color: Colors.grey),),
                      Text('below to create your account', style: TextStyle(fontSize: 15, color: Colors.grey),),
                    ],
                  ),
                  Image.asset('Assets/Sign_up_page_image/sign_up_logo.png', height: 50),
                ],
              ),
              SizedBox(height: 5),
              Image.asset('Assets/Sign_up_page_image/sign_up_ui.png', height: 190, fit: BoxFit.contain),
              SizedBox(height: 5),
              TextField(decoration: InputDecoration(
                  hintText: 'Name',
                  prefixIcon: Icon(Icons.person, color: Color(0xFF2D2013)),filled: true,fillColor: Color(0xFFE8E3DC),
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(20), borderSide: BorderSide(color: Color(0xFF2D2013), width: 2)),
                ),
              ),
              SizedBox(height: 8),
              TextField(decoration: InputDecoration(hintText: 'Email address',
                  prefixIcon: Icon(Icons.email, color: Color(0xFF2D2013)),filled: true,fillColor: Color(0xFFE8E3DC),
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(20), borderSide: BorderSide(color: Color(0xFF2D2013), width: 2)),
                ),
              ),
              SizedBox(height: 8),
              TextField(
                obscureText: true,keyboardType: TextInputType.phone,
                decoration: InputDecoration(hintText: 'Mobile number',
                  prefixIcon: Icon(Icons.phone, color: Color(0xFF2D2013)),filled: true,fillColor: Color(0xFFE8E3DC),
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(20), borderSide: BorderSide(color: Color(0xFF2D2013), width: 2)),
                ),
              ),
              SizedBox(height: 8),
              TextField(obscureText: true,
              decoration: InputDecoration(hintText: 'Password',
                  prefixIcon: Icon(Icons.lock_clock, color: Color(0xFF2D2013)),filled: true,fillColor: Color(0xFFE8E3DC),
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(20), borderSide: BorderSide(color: Color(0xFF2D2013), width: 2)),
                ),
              ),
              SizedBox(height: 8),
              TextField(obscureText: true,
                decoration: InputDecoration(hintText: 'Confirm password',
                  prefixIcon: Icon(Icons.lock_clock, color: Color(0xFF2D2013)),filled: true,fillColor: Color(0xFFE8E3DC),
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(20), borderSide: BorderSide(color: Color(0xFF2D2013), width: 2)),
                ),
              ),
              SizedBox(height: 10),
              Text('By signing up, you agree to our Terms of use and privacy notice',textAlign: TextAlign.center,
                style: TextStyle(fontSize: 13, color: Colors.grey),
              ),
              SizedBox(height: 10),
              ElevatedButton(onPressed: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) => VerificationPage()));
                },style: ElevatedButton.styleFrom(backgroundColor: Color(0xFF2D2013),foregroundColor: Colors.white,
                  minimumSize: Size(double.infinity, 48),shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),),
                child: Text('Join Now', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
              ),
              SizedBox(height: 6),
              Row(mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('Already have an account? ', style: TextStyle(color: Colors.grey, fontSize: 15)),
                  TextButton(
                    onPressed: () {Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => LoginPage()));
                    },
                    child: Text('Sign In', style: TextStyle(color: Color(0xFF2D2013), fontWeight: FontWeight.bold, fontSize: 15)),
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
