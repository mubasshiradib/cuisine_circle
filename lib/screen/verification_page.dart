import 'dart:async';
import 'package:flutter/material.dart';

class VerificationPage extends StatefulWidget {
  const VerificationPage({super.key});
  @override
  State<VerificationPage> createState() => _VerificationPageState();
}
class _VerificationPageState extends State<VerificationPage> {
  TextEditingController in1 = TextEditingController();
  TextEditingController in2 = TextEditingController();
  TextEditingController in3 = TextEditingController();
  TextEditingController in4 = TextEditingController();
  Timer? time;
  int sec = 60;
  @override
  void initState() {
    super.initState();
    startTimer();
  }
  void startTimer() {
    time?.cancel();
    setState(() => sec = 60);
    time = Timer.periodic(Duration(seconds: 1), (t) {
      if (sec > 0) {
        setState(() => sec--);} 
        else {
        time?.cancel();}
    });
  }

  void reset() {
    in1.clear();
    in2.clear();
    in3.clear();
    in4.clear();
    startTimer();
  }
  Widget inputValue(TextEditingController c) {
    return Container(width: 54,height: 54,
      decoration: BoxDecoration(color: Color(0xFFE8E3DC),borderRadius: BorderRadius.circular(15),
        border: Border.all(color: Color(0xFF2D2013), width: 2),
      ),
      child: TextField(controller: c,obscureText: true, keyboardType: TextInputType.number,
        textAlign: TextAlign.center,maxLength: 1,
        style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Color(0xFF2D2013)),
        decoration: InputDecoration(counterText: '', border: InputBorder.none),
        onChanged: (val) {
          if (val.isNotEmpty) FocusScope.of(context).nextFocus();
        },
      ),
    );
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF8F5F2),
      body: SingleChildScrollView(
        child: Padding(padding: EdgeInsets.only(top: 55.0, left: 20.0, right: 20.0, bottom: 20.0),
          child: Column(
            children: [Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [IconButton(icon: Icon(Icons.arrow_back, color: Color(0xFF2D2013)),
                    onPressed: () => Navigator.pop(context),),
                  Text('Verification', style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold, color: Color(0xFF2D2013))),
                  Image.asset('Assets/verification_page_assets/verification_logo.png', height: 45),
                ],
              ),
              SizedBox(height: 15),
              Image.asset('Assets/verification_page_assets/varification_page.png', height: 200, fit: BoxFit.contain),
              SizedBox(height: 15),
              Text('OTP Verification', style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Color(0xFF2D2013))),
              SizedBox(height: 8),
              Text('Enter the verification code we just sent on your email address', textAlign: TextAlign.center, style: TextStyle(fontSize: 14, color: Colors.grey)),
              SizedBox(height: 20),
              Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [inputValue(in1), inputValue(in2), inputValue(in3), inputValue(in4)],
              ),
              SizedBox(height: 15),
              sec > 0? Text('Resend code in ${sec}s', style: TextStyle(fontSize: 14, color: Colors.grey))
                  : TextButton(onPressed: reset,
                      child: Text('Resend Code', style: TextStyle(fontSize: 14, color: Color(0xFF2D2013), fontWeight: FontWeight.bold)),
                    ),
              SizedBox(height: 15),
              ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color(0xFF2D2013),
                  foregroundColor: Colors.white,
                  minimumSize: Size(double.infinity, 50),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                ),
                child: Text('Confirm', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
