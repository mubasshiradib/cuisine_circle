import 'package:flutter/material.dart';
import 'home_page.dart';
class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF8F5F2),
      body: Padding(padding: EdgeInsets.only(top: 40.0, left: 20.0, right: 20.0, bottom: 20.0),
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
                Image.asset('Assets/log_page_assets/login_logo.png', height: 50),],),
                SizedBox(height: 15),
                Expanded(child: 
                Image.asset('Assets/log_page_assets/Login_page_image.png', fit: BoxFit.contain),),
                SizedBox(height: 10),
               Text('Login',
              style: TextStyle(fontSize: 24,fontWeight: FontWeight.bold,color: Color(0xFF2D2013),),
               ),
               SizedBox(height: 15),
              TextField(
               decoration: InputDecoration(hintText: 'Email address',
                prefixIcon: Icon(Icons.email, color: Color(0xFF2D2013)),filled: true,fillColor: Color(0xFFE8E3DC),
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(20),
                  borderSide: BorderSide(color: Color(0xFF2D2013), width: 2),),
                ),
               ),
               SizedBox(height: 12),
            TextField(
              obscureText: true,
              decoration: InputDecoration(hintText: 'Password',prefixIcon: Icon(Icons.lock_clock, color: Color(0xFF2D2013)),
                filled: true,fillColor: Color(0xFFE8E3DC),
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(20),
                  borderSide: BorderSide(color: Color(0xFF2D2013), width: 2),
                ),
              ),
            ),
            SizedBox(height: 18),
            ElevatedButton(
              onPressed: () {
                Navigator.push(context,MaterialPageRoute(builder: (context) => VerificationPage()),);
              },style: ElevatedButton.styleFrom(backgroundColor: Color(0xFF2D2013),
                foregroundColor: Colors.white,minimumSize: Size(double.infinity, 50),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20),),
              ),
              child: Text('Login Now', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
            ),
            SizedBox(height: 6),
            TextButton(
              onPressed: () {
                Navigator.pushReplacement(context,
                  MaterialPageRoute(builder: (context) => HomePage()),);
              },
              child: Text('Login as Guest',
                style: TextStyle(color: Color(0xFF2D2013),fontWeight: FontWeight.bold,
                  fontSize: 16,),
              ),
            ),
            SizedBox(height: 8),
            Row(mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text("Don't have an account? ",style: TextStyle(color: Colors.grey, fontSize: 14),),
                TextButton(onPressed: () {
                        Navigator.push(context,
                           MaterialPageRoute(builder: (context) => const SignupPage()),);
                  },
                  child: Text('Register',style: TextStyle(color: Color(0xFF2D2013),fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class VerificationPage extends StatelessWidget {
  const VerificationPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Verification')),
      body: Center(
        child: Text('Verification Page', style: TextStyle(fontSize: 20)),
      ),
    );
  }
}

class SignupPage extends StatelessWidget {
  const SignupPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Signup')),
      body: Center(
        child: Text('Signup Page', style: TextStyle(fontSize: 20)),
      ),
    );
  }
}
